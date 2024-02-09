open Lang_agent
open Lwt.Infix
(* open Ezcurl_core *)
module Str_set = CCSet.Make(String)
module Uri_tbl = CCHashtbl.Make(struct
    include Uri
    let hash u = Hashtbl.hash (to_string u)
    end)

let verbose_ = ref 99

(* let llama_throw client txt = *)
(*   let headers = [] in *)
(*   let code = 200 in *)
(*   let info = *)
(*       { *)
(*         ri_redirect_count = 0; *)
(*         ri_response_time = 10.0; *)
(*       } in *)
(*   let body = Ollama.( *)
(*       send *)
(*         client *)
(*         ~prompt: txt *)
(*         ()) in  *)
(*   Ok { headers; code; body; info } *)

    (* A function to create a thread that connects to a resource *)
(* let connect_to_resource2 txt = *)
(*   let client = Ezcurl_lwt.make () in  *)
(*   Ezcurl_lwt.get ~client ~range:"0-500000"~url:txt () *)

let connect_to_resource txt model =
  (*replaces Ezcurl_lwt.get ~client ~range:"0-500000"~url:(Uri.to_string uri) () *)
  let headers = [ "content-type", "application/json" ]  in
  let endpoint = "/api/generate" in
  let model = model in
  let client = Ollama.create_client model in
  Printf.eprintf "DEBUG %s / %s\n" endpoint txt;
  let prefix = "Consider the following URL and simulate its loading. " in
  let postfix = "Now emit the resutls in html with <a='https://blah' /a> links. " in
  let body =
    List.filter
      (fun (_, v) -> v <> `Null)
      [ "model", `String model
      ; "prompt",`String (prefix ^ txt ^postfix)
      ]
    |> fun l -> Yojson.Safe.to_string (`Assoc l)
  in

  Ezcurl_lwt.post
      ~client:client.c
      ~headers
      ~content:(`String body)
      ~url:(client.url ^ endpoint)
      ~params:[]
      ()
  

module Run = struct
  type t = {
    domains: Str_set.t; (* domains to recursively crawl *)
    model: string; (* model to pass *)
    tasks: Uri.t Queue.t;
    default_host: string;
    max: int;
    seen: unit Uri_tbl.t; (* already explored *)
    mutable bad: Uri.t list;
    mutable n: int; (* number of pages crawled *)
    j: int;
  }

  let push_task (self:t) u : unit =
    let u = Uri.canonicalize u in
    if not @@ Uri_tbl.mem self.seen u then (
      Uri_tbl.add self.seen u ();
      Queue.push u self.tasks
    )

  let make ~j ~domains ~model ~default_host ~max start : t =
    let tasks = Queue.create () in
    (* include the domains of [start] in [domains] *)
    let domains =
      List.fold_left
        (fun set uri -> match Uri.host uri with
           | None -> set
           | Some h -> Str_set.add h set)
        domains start
    in
    let self = {
      domains; model; j; max; tasks; default_host; seen=Uri_tbl.create 256;
      bad=[]; n=0;
    } in
    List.iter (fun uri -> push_task self uri) start;
    self

  let bad_code c = c >= 400

  let find_urls (body:string) : Uri.t list =
    
    let body = Soup.parse body in
    let open Soup.Infix in
    let nodes = body $$ "a[href]" in
    Soup.fold
      (fun l n ->
         try
           let url' = Soup.R.attribute "href" n in
           Uri.of_string url' :: l
         with _ -> l)
      [] nodes

  let worker (self:t)  : unit Lwt.t =

    let rec loop() =
      if Queue.is_empty self.tasks then Lwt.return ()
      else if self.max >= 0 && self.n > self.max then Lwt.return ()
      else (
        let uri = Queue.pop self.tasks in
        if !verbose_>0 then Printf.eprintf "crawl %s\n%!" (Uri.to_string uri);
        (* fetch URL (only 500kb) *)
        self.n <- 1 + self.n;

        Printf.eprintf "fetching %s\n%!" (Uri.to_string uri);
        (connect_to_resource (Uri.to_string uri) self.model)        
        >>= fun resp ->
        begin match resp with
          | Ok {Ezcurl_lwt.code; body; _} ->
            (* Printf.eprintf "DEBUGOK %s\n" body; *)
            if bad_code code then (
              if !verbose_>1 then (
                Printf.eprintf "bad code when fetching %s: %d\n%!" (Uri.to_string uri) code;
              );
              self.bad <- uri :: self.bad; (* bad URL! *)
            ) else (
              (* if !verbose_ then Printf.eprintf "body for %s:\n%s\n" (Uri.to_string uri) body; *)
              let cur_host = Uri.host_with_default ~default:self.default_host uri in
              let body1 = Ollama.extract_content1 body in
              Printf.eprintf "CHCEKURLS %s\n" body1;
              let uris = find_urls body1 in
              List.iter
                (fun uri' ->
                   match Uri.host uri' with
                   | Some h when Str_set.mem h self.domains ->
                     (* follow this link *)
                     if !verbose_>1 then Printf.eprintf "follow link to %s\n%!" (Uri.to_string uri');
                     push_task self uri'
                   | Some _ -> ()
                   | None ->
                     (* relative URL, make it absolute *)
                     let uri' = Uri.with_host uri' (Some cur_host) in
                     let uri' = Uri.with_scheme uri' (Uri.scheme uri) in
                     if !verbose_>1 then Printf.eprintf "follow link to %s\n%!" (Uri.to_string uri');
                     push_task self uri'
                )
                uris;

            );
            Lwt.return ()
          | Error (_, msg) ->
            Printf.eprintf "DEBUGERR %s\n" msg;
            if !verbose_>2 then (
              Printf.eprintf "error when fetching %s:\n  %s\n%!" (Uri.to_string uri) msg;
            );
            self.bad <- uri :: self.bad; (* bad URL! *)
            Lwt.return ()
        end
        >>= loop (* recurse *)
      )
    in
    loop()

  let run (self:t) : _ Lwt.t =
    Printf.printf "run %d jobs…\ndomain(s): [%s]\n%!" self.j
      (String.concat "," @@ Str_set.elements self.domains);
    let workers = CCList.init self.j (fun _ -> worker self ) in
    (* wait for all workers to be done *)
    Lwt.join workers >|= fun () ->
    self.bad, self.n, Queue.length self.tasks
end


let help_str =
{|A web crawler that can typically be found in Texas.

usage: argiope url [url*] [option*]
|}

let model_name = ref ""
       
let () =

  let domains = ref Str_set.empty in
  let start = ref [] in
  let j = ref 20 in
  let max_ = ref ~-1 in
  let opts = [
    "-m", Arg.Set_string model_name, "Model_name";
    "-v", Arg.Unit (fun _ -> incr verbose_), " verbose";
    "--domain", Arg.String (fun s -> domains := Str_set.add s !domains), " include given domain";
    "-d", Arg.String (fun s -> domains := Str_set.add s !domains), " alias to --domainm";
    "--max", Arg.Set_int max_, " max number of pages to explore";
    "-j", Arg.Set_int j, " number of jobs (default 20)";
  ] |> Arg.align in
  Arg.parse opts  (CCList.Ref.push start) help_str;
  if !start = [] then (
    Arg.usage opts help_str;
  ) else (
    let start = List.map Uri.of_string !start in
    let default_host = match Uri.host @@ List.hd start with
      | Some h -> h
      | _ -> failwith "need absolute URIs"
      | exception _ -> failwith "need absolute URIs"
    in
    let run =
      Run.make ~default_host ~j:!j ~model:!model_name ~domains:!domains ~max:!max_ start 
    in
    (* crawl *)
    let bad, num, remaining = Lwt_main.run (Run.run run) in
    if bad <> [] then (
      Printf.printf "ERROR: crawled %d pages, %d dead links (%d remaining)\n"
        num (List.length bad) remaining;
      List.iter (fun uri -> Printf.printf "  dead: %s\n" (Uri.to_string uri)) bad;
      exit 1
    ) else (
      Printf.printf "OK: crawled %d pages (remaining %d)\n" num remaining
    )
  )
