(* 
open Openai_client
 *)
open Lang_agent
let window_size = ref 1024
    
(* A function that returns the last line of a file that matches a given pattern *)
(* let last_line_matching ic : string = *)
(*   let line = ref "" in *)
(*   try *)
(*     while true; do *)
(*       line := input_line ic *)
(*     done; *)
(*     ! line *)
(*   with End_of_file -> *)
(*     close_in ic; *)
(*     !line *)

(* split_file : string -> int -> unit *)
(* split_file file n splits the file into chunks of n lines each
special case the last line is in is own chunk
 *)
let split_file ic n =
  let chunks = ref [] in
  let chunk = ref 0 in
  let buf = Buffer.create 1024 in
  let eof = ref false in
  let line = ref "" in 
  while not !eof do
    incr chunk;
    let lines = ref 0 in
    while not !eof && !lines < n do
      try
        line := input_line ic;
        Buffer.add_string buf !line;
        Buffer.add_char buf '\n';
        incr lines
      with
        End_of_file ->        
          eof := true
    done;

    chunks := List.append !chunks  [ Buffer.contents buf ];
    Buffer.clear buf;
    if not ! eof then     
      (*append the last line as a chunk*)
      chunks := List.append !chunks  [ !line ]    
    (* clear the buffer *)
    
  done;
  (* close the input file *)
  chunks


(* let chunk_file_into_parts ic asize : string list = *)
(*   let line = ref "" in *)
(*   let chunks = ref [] in *)
(*   let chunk = ref "" in     *)
(*   try *)
(*     while true; do *)
(*       line := input_line ic; *)
(*       chunk := !chunk ^ ! line; *)
(*       if String.length !chunk > asize then *)
(*         ( *)
(*           chunks := List.append !chunks  [!chunk]; *)
(*           chunk := "" *)
(*         ) *)
(*     done;  !chunks   *)
(*   with End_of_file -> *)
(*     close_in ic; *)
(*     (\* append the final line as a new chunk*\) *)
(*     !chunks *)


(*coq/lib/loc.ml *)
(* type source = *)
(*   (\* OCaml won't allow using DirPath.t in InFile *\) *)
(*   | InFile of { dirpath : string option; file : string } *)

(* type location = { *)
(*     lc_fname : source; (\** filename or toplevel input *\) *)
(*     lc_line_nb : int; (\** start line number *\) *)
(*     ln_bol_pos : int; (\** position of the beginning of start line *\) *)
(*     ln_line_nb_last : int; (\** end line number *\) *)
(*     ln_bol_pos_last : int; (\** position of the beginning of end line *\) *)
(*     ln_bp : int; (\** start position *\) *)
(*     ln_ep : int; (\** end position *\) *)
(* } *)

(* type location_list = location list *)

let rec parse_loc_list a : string =
  match a with
  | [] -> ""
  | head :: rest -> head ^ "," ^ parse_loc_list rest

let parse_loc (line :string)  =
  let parts2 = String.split_on_char ':' line in
  let fname = parse_loc_list parts2  in
  (* (print_endline ("DEBUG5:" ^ fname)); *)
  fname
     (* { *)
     (*   lc_fname = fname; (\** filename or toplevel input *\) *)
     (*   lc_line_nb = lineno; (\** start line number *\) *)
     (* } *)

let rec process_fp l  =
  match l with
  | h :: t -> parse_loc h :: process_fp t
  | [] -> []

let parse_file_points (line: string)  =
  let parts1 = String.split_on_char ',' line in
  process_fp parts1


 (* A function that traverses a directory and prints the last line matching the pair pattern for each file *)
let traverse_and_print: 'client_t1 -> 'client_t2 -> string -> string -> string -> string -> string ->unit =
  fun client1 param_record path model prompt1 suffix check_suffix ->
  (print_endline ("Consider:" ^  model ^path));
  let rec aux dir =
    let entries = Sys.readdir dir in
    Array.iter (fun entry ->
        let full_path = Filename.concat dir entry in
        let full_out_path = full_path ^ suffix in
        if Sys.is_directory full_path then
          (
            (print_endline ("DEBUG1:" ^  full_path));
            aux full_path
          )
        else
          (*Unix.file_kind  *)
          let fs = Unix.lstat full_path in
            match fs.st_kind with
            | S_CHR -> (print_endline ("DEBUG2 char" ^  full_path)); 
            | S_SOCK -> (print_endline ("DEBUG3 char"^  full_path)); 
            | S_BLK -> (print_endline ("DEBUG4 block"^  full_path)); 
            | S_FIFO -> (print_endline ("DEBUG2 FIFO"^  full_path)); 
            | S_LNK -> (print_endline ("DEBUG2 LINK"^  full_path)); 
            | S_DIR -> (print_endline ("DEBUG2 DIR" ^  full_path));
            | S_REG ->
               if Sys.file_exists  full_path then

                 if  Filename.check_suffix full_path check_suffix then
                
                   if Sys.file_exists  full_out_path then
                     print_endline ("SKIP existing" ^ full_out_path)
                   else
                     
                     (* (print_endline ("DEBUG2 " ^  full_path)); *)
                   let ic = open_in full_path in
                   print_endline ("OPEN INPUT:" ^ full_path);
                   
                   let chunks = split_file ic ! window_size in
                   (* let ll =  last_line_matching ic in
                      let chunks =  chunks_in ic in
                    *)
                   close_in ic;
                   let do_one  (data)=
                     let prompt = prompt1 ^ data in
                     (* print_endline ("send" ^ prompt); *)
                     let res = (client1#lang_prompt param_record prompt ) in
                     (* print_endline ("get" ^ res); *)
                     
                     let oc = open_out full_out_path in

                     print_endline ("OUTPUT: " ^ full_out_path);
                     
                     (* print_endline ("DEBUGOUTPUT:" ^ res); *)
                     Printf.fprintf oc
                       "\n#+begin_src input\n%s\n#+end_src\n#+begin_src output %s\n%s\n#+end_src\n"
                       data model res;
                     close_out oc;
                     "FIXME"
                
                   in
                   let ln = List.map do_one ! chunks  in
                   let lr = List.rev ln in
                   match lr  with
                   | [] -> print_endline ("DEBUG@ERROR")
                   | 
                     
                     le::_ ->print_endline ("DEBUG20 " ^  String.concat "@" (parse_file_points le));
                             ()
                
      ) entries
  in
  aux path

let input_files = ref []

let anon_fun filename =
  input_files := filename::!input_files

(*module make_open_id = OpenAIClientModule*)



let () =
  let start = ref "" in
  let prompt = ref "" in
  let model = ref "mistral" in
  let suffix = ref ".out" in
  let check_suffix = ref ".out" in  
  let open_ai_client  = new Openai_client.open_ai_lang_model in
  let ollama_client  = new Ollama.ollama_lang_model    in
  (* let open_ai_client_ref  = ref open_ai_client in *)
  (* let ollama_client_ref  = ref ollama_client in *)
  let use_ollama_ref  = ref true in 
  let url = ref "" in
  let help_str = "test" in
  let opts = [
      "-s", Arg.Set_string start, "startdir";
      "-p", Arg.Set_string prompt, "prompt";
      "-x", Arg.Set_string suffix, "suffix";
      "-c", Arg.Set_string check_suffix, "checksuffix";      
      "-m", Arg.Set_string model, "model";
      "--openai", Arg.Unit (fun () -> (print_endline ("DEBUG1 openai MODEL :"  ) );
                                      use_ollama_ref := false; ()
                    ),      " Use Openai ";          
      "--ollama", Arg.Unit (fun () -> (print_endline ("DEBUG1 ollama MODEL :" ))),      " Use Ollama (default)"; 
      "-u", Arg.Set_string url, "url";
      "-w", Arg.Set_int window_size, "window_size";
  ] |> Arg.align in
  Arg.parse opts anon_fun help_str;
  Printf.printf "DEBUG3 Starting path %s\n" !start;
  (print_endline ("DEBUG4 MODEL :" ^ ! model) );

  if ! use_ollama_ref then
    let client_param_record = (ollama_client#lang_init())  in 
    let client_param_record2 = ollama_client#lang_open client_param_record ! url in 
    let client_param_record3 = ollama_client#lang_set_model client_param_record2 ! model in 
    traverse_and_print ollama_client client_param_record3 !start !model !prompt !suffix !check_suffix 
  else
    let client_param_record = (open_ai_client#lang_init())  in 
    let client_param_record2 = open_ai_client#lang_open client_param_record ! url in 
    let client_param_record3 = open_ai_client#lang_set_model client_param_record2 ! model in 
    traverse_and_print open_ai_client client_param_record3 !start !model !prompt !suffix !check_suffix 

  (* let open_ai_client = !binding in  *)
  (* (\* new Openai_client.open_ai_lang_model    ()   *\) *)
  (* (\* Lang_model.client_t aka record of parameters *\) *)
  (*  let client_param_record = (open_ai_client#lang_init())  in *)
      
  (*     let client_param_record2 = open_ai_client#lang_open client_param_record ! url in *)
  (*     let client_param_record3 = open_ai_client#lang_set_model client_param_record2 ! model in *)
  (*     traverse_and_print open_ai_client client_param_record3 !start !model !prompt *)
                         (*         map_lookup_file_snippets fp snippet_size       *)
