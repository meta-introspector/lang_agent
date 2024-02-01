open Lang_agent    

let run (prompt) =
  (print_endline (
      "\n#+begin_src input\n" ^
      prompt ^
      "\n#+end_src input\n"));
  
  let model = "mixtral" in
  let client = Ollama.create_client model in
  ignore
  @@ Lwt_main.run
(* ~prompt:prompt ~model:model*)
  @@ Lwt.bind
       Ollama.(
         send
           client prompt ())
       (Lwt_io.printlf "\n#+begin_src output\n%s\n#+end_src output")


let read_whole_file filename =
  let ch = open_in_bin filename in
  let s = really_input_string ch (in_channel_length ch) in
  close_in ch;
  s

let read_prompt_file = read_whole_file  Sys.argv.(1)

let read_sep_file = read_whole_file  Sys.argv.(2)

let read_data_file = read_whole_file  Sys.argv.(3) 
  
let read_file  =
  let prompt = read_prompt_file in
  let sep = read_sep_file in
  let data = read_data_file in  
  run (prompt ^ data ^ sep )
    
let () = read_file 
