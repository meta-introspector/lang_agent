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

(* (\*fix this ocaml code and complete it based on the comments*\) *)
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

(*
  in ocaml rewrite the following code to be more generic method
  that can be used where Ollama is replaced with some variable
  that can be any subclass of a base language binding class
 *)
(* let run_model client (model:string)(prompt:string)  = *)
(*   (print_endline ( *)
(*       "\n#+begin_src input "^model^"\n" ^ *)
(*       prompt ^ *)
(*       "\n#+end_src input\n"));   *)
(*   let res = (client#lang_prompt client prompt ) in *)
(*   (\* (print_endline "\n#+begin_src output\n"^res^"\n#+end_src output"); *\) *)
(*   res *)


 (* A function that traverses a directory and prints the last line matching the pair pattern for each file *)
let traverse_and_print: 'client_t1 -> 'client_t2 -> string -> string -> string ->unit =
  fun client1 param_record path model prompt1  ->
  (print_endline ("DEBUG0:" ^  model ^path));
  let rec aux dir =
    let entries = Sys.readdir dir in
    Array.iter (fun entry ->
        let full_path = Filename.concat dir entry in
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
                 (* (print_endline ("DEBUG2 " ^  full_path)); *)
                 let ic = open_in full_path in

                 let chunks = split_file ic ! window_size in
                 (* let ll =  last_line_matching ic in
                    let chunks =  chunks_in ic in
                  *)
                 let do_one  (data)=
                   let prompt = prompt1 ^ data in
                   let res = (client1#lang_prompt param_record prompt ) in
                   data ^ res
                 in
                 let ln = List.map do_one ! chunks  in
                 let lr = List.rev ln in
                 match lr  with
                 | [] -> print_endline ("DEBUG@ERROR")
                 | _ ->
                   (*
                     le::_ ->print_endline ("DEBUG20 " ^  String.concat "@" (parse_file_points le)) *)()
                  
        ) entries
    in
    aux path

let input_files = ref []

let anon_fun filename =
  input_files := filename::!input_files

let () =
  let start = ref "" in
  let prompt = ref "" in
  let model = ref "mistral" in
  let binding = ref "ollama" in
  let help_str = "test" in
  let opts = [
      "-s", Arg.Set_string start, "startdir";
      "-p", Arg.Set_string prompt, "prompt";
      "-m", Arg.Set_string model, "model";
      "-b", Arg.Set_string binding, "binding";
      "-w", Arg.Set_int window_size, "window_size";
  ] |> Arg.align in

  Arg.parse opts anon_fun help_str;
  Printf.printf "DEBUG3 Starting path %s\n" !start;
  (print_endline ("DEBUG4 MODEL :" ^ ! model) );
  (print_endline ("DEBUG5 BINDING :" ^ ! binding) );
  
  if !binding == "openai" then
    (print_endline ("DEBUG OPENAI :") );
    let open_ai_client = new Openai_client.open_ai_lang_model in 
    (* let client = Openai_client.create_init in *)
    
    (*Lang_model.client_t aka record of parameters
     *)
    let client_param_record = (open_ai_client#lang_init())  in
    
    let str_out = (open_ai_client#lang_prompt client_param_record "Hello" ) in
    (print_endline ("DEBUG OPENAI1 :" ^str_out) );
      
    traverse_and_print open_ai_client client_param_record !start !model !prompt; 
    (*         map_lookup_file_snippets fp snippet_size       *)
    if !binding == "ollama" then
      let ollama_client = new Openai_client.open_ai_lang_model in 
      (* let client_old = Ollama.create_client ! model in *)
      let client_param_record = (open_ai_client#lang_init())  in
      traverse_and_print ollama_client client_param_record !start !model !prompt;         
      (print_endline ("DEBUG1 :" ^ str_out) )
