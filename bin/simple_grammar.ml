open Lang_agent


type backend =
  | BNone
  | BLlamaCpp of Llama_cpp.llama_cpp_lang_model

type backend2 =

  | B2None  
  | B2LlamaCpp of Llama_cpp.client_t Lang_model.client_t

let lc_lang_prompt lang_client  param_record prompt =
  match lang_client with 
  | BLlamaCpp m ->( match param_record with | B2LlamaCpp p -> m#lang_prompt p prompt
                                            | _ -> "")
  | _ -> ""

let do_one prompt1 client1 param_record full_out_path=
  let prompt = prompt1  in
  (* (print_endline ("chunk: " ^  prompt)); *)
  try
    let res = (lc_lang_prompt client1 param_record prompt ) in
    print_endline ("OUTPUT: " ^ full_out_path);        
    if res == "ERROR"
    then
      (
        print_endline ("ERROR: " ^ full_out_path);
        "erro"
      )
    else
      (
        let oc = open_out full_out_path in
        (Printf.fprintf oc
           "\n#+begin_src input\n%s\n#+end_src\n#+begin_src output\n%s\n#+end_src\n"
           prompt res);
        close_out oc;
        res
      )
      with
        Yojson__Common.Json_error s ->
        print_endline ("ERROR: " ^ s);
        "error"
        
        
let window_size = ref 10

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


let do_split_file full_path =
  let ic = open_in full_path in
  print_endline ("OPEN INPUT: " ^ full_path);
  let chunks = split_file ic ! window_size in
  close_in ic;
  chunks

let aux dir suffix prompt1 client1 param_record =
  let full_path = dir  in
  let full_out_path = full_path ^ suffix in    
  if Sys.file_exists  full_out_path then
    (
      print_endline ("SKIP existing" ^ full_out_path);
      "error"
    )
  else
    (
      print_endline ("Calling server. waiting for response.");
      do_one prompt1 client1 param_record full_out_path
    )

let process_prompt: backend -> 'client_t2 -> string -> string -> string -> string -> int ->unit =
  fun client1 param_record path model prompt1 suffix repeat ->
  (print_endline ("Consider model: " ^  model ^ " path: "^ path ^ " prompt" ^ prompt1));
  for i = 1 to repeat do
    let _ = aux (path ^ "_" ^(string_of_int i)) (suffix ^ (string_of_int i)) prompt1 client1 param_record in
    ()
  done

let anon_fun _ = ()

let lc_init lang_client aurl amodel agrammar=
  match lang_client with 
  | BNone -> B2None
  | BLlamaCpp m ->
    let a = m#lang_init() in
    let c1 = m#lang_open a aurl in 
    let c2 = m#lang_set_model c1 amodel in
    (print_endline ("DEBUG9 GRAMMAR :" ^ (string_of_int (String.length agrammar ))));
    let c3 = m#lang_set_grammar c2 agrammar in
    B2LlamaCpp c3


  
let read_whole_file filename =
  (print_endline ("DEBUG1 read :" ^ filename));
  let ch = open_in_bin filename in
  let s = really_input_string ch (in_channel_length ch) in
  close_in ch;
  s
        
let () =
  let start = ref "" in
  let item_count = ref 1 in
  let prompt = ref "" in
  let header_prompt = ref "" in
  let trailer_prompt = ref "" in
  let model = ref "mistral" in
  let grammar = ref "" in
  let suffix = ref ".out" in
  let lang_client  = ref BNone in
  let url = ref "" in
  let help_str = "test" in
  let opts = [
    "-s", Arg.Set_string start, "startdir";
    "-w", Arg.Set_int window_size, "window_size";
    "-n", Arg.Set_int item_count, "generate count items";
    "-p", Arg.Set_string prompt, "prompt filename";
    "-h", Arg.Set_string header_prompt, "header prompt filename";
    "-t", Arg.Set_string trailer_prompt, "trailer prompt filename";
    "-g", Arg.Set_string grammar, "grammar filename";
    "-x", Arg.Set_string suffix, "suffix";
    "-m", Arg.Set_string model, "model";
    "--llamacpp", Arg.Unit (fun () ->
        lang_client  := BLlamaCpp  new Llama_cpp.llama_cpp_lang_model  ; ()
        ),      " Use Ollama (default)";
      "-u", Arg.Set_string url, "url";
    ] |> Arg.align in
  Arg.parse opts anon_fun help_str;
  Printf.printf "DEBUG3 path %s\n" !start;
  (print_endline ("DEBUG4 MODEL :" ^ ! model) );
  grammar := read_whole_file  !grammar;
  let header = read_whole_file  !header_prompt in
  let trailer = read_whole_file  !trailer_prompt in
  let chunks1 = do_split_file !prompt in
  let client_param_record = lc_init !lang_client !url !model !grammar  in 
  let do_one (p1:string) =
    (
      (print_endline ("DEBUG41 chunk :" ^ (string_of_int (String.length p1 ))) );
      let pp  = header ^ p1 ^ trailer in 
      process_prompt !lang_client client_param_record !start !model pp !suffix !item_count
    )
  in
  let _ = (List.map do_one !chunks1) in ()

