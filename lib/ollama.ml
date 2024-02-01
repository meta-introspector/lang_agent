(* open Lwt.Syntax *)
(* open Yojson *)
(* open Printexc *)
open Ppx_yojson_conv_lib.Yojson_conv.Primitives

include Yojson.Safe

(*
   parts from 
   
https://github.com/janestreet/ppx_yojson_conv_lib
   and OpenAI-OCaml
   https://github.com/meta-introspector/openai-ocaml
*)


let json_to_field_opt name f o =
  ( name
  , match o with
    | Some v -> f v
    | None -> `Null )
;;

type client_t =
  { model : string
  ; gen_url : string -> string
  ; c : Curl.t
  }

let create_client model =
  let base_url = "http://localhost:11434" in
  { model; gen_url = ( ^ ) base_url; c = Ezcurl_lwt.make () }
;;

type role =
  [ `System
  | `User
  | `Assistant
  ]

let yojson_of_role = function
  | `System -> `String "system"
  | `User -> `String "user"
  | `Assistant -> `String "assistant"
;;

type message =
  { content : string
  ; role : role
  }
[@@deriving yojson_of]
  
(** raw API request:
 * @param k for continuation to avoid redefining labeled parameters
*)

let send_raw_k
  k
  (client : client_t)
  (model : string)
  (prompt : string)  
  ()
  =
  let body =
    List.filter
      (fun (_, v) -> v <> `Null)
      [ "model", `String model
      ; "prompt",`String prompt
      ]
    |> fun l -> Yojson.Safe.to_string (`Assoc l)
  in
  let headers =
    [ "content-type", "application/json"
    ]
  in
  let endpoint = "/api/generate" in
  let%lwt resp =
    Ezcurl_lwt.post
      ~client:client.c
      ~headers
      ~content:(`String body)
      ~url:(client.gen_url endpoint)
      ~params:[]
      ()
  in
  k resp

type ollama_response =
  { model : string
  ; created_at : string
  ; response : string
  ; isdone : bool [@key "done"]
  ; context: (int list) option[@yojson.option]
  ; total_duration:int option[@yojson.option]
  ; load_duration: int option[@yojson.option]
  ; prompt_eval_count: int option[@yojson.option]
  ; prompt_eval_duration : int option[@yojson.option]
  ; eval_count: int option[@yojson.option]
  ; eval_duration : int option[@yojson.option]
  }
[@@deriving yojson]

(* open Ppx_yojson_conv_lib.Yojson_conv.Primitives *)
       
let myproc (body:string):string =
  if (String.length body ) == 0 then ""
  else    
    try
      let json = Yojson.Safe.from_string body in
      let record_opt = (ollama_response_of_yojson json) in
      (* (print_endline ( "DEBUGBODY:" ^ body ^ "DEBUG2"^   record_opt.response) );        *)
      record_opt.response        
    with
    | Ppx_yojson_conv_lib.Yojson_conv.Of_yojson_error (loc, exn) ->
      Printf.eprintf "Loc at  %s\n" (Printexc.to_string loc);
      Printf.eprintf "Error at  %s\n" (Yojson.Safe.show exn); "error"
  (* | exn -> *)
  (*   Printf.eprintf "Unexpected error: %s\n" (   to_string exn); "errorr2" *)


    
let split_n = String.split_on_char '\n'
    
let extract_content1 body = 
  let fpp =  (split_n body ) in
  let fp2 = List.map myproc fpp  in
  String.concat "" fp2
let extract_content body = 
  Lwt.return (extract_content1 body)

let send =
  send_raw_k
  @@ function
  | Ok { body; _ } -> extract_content body
  | Error (_code, e) -> Lwt.fail_with e



