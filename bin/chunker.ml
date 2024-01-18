open Lang_agent    

let run (prompt) =
  (print_endline (
      "#+begin_src input\n" ^
      prompt ^
      "\n#+end_src input"));
  
  let model = "mistral" in
  let client = Ollama.create_client model in
  ignore
  @@ Lwt_main.run
  @@ Lwt.bind
       Ollama.(
         send
           client
           ~prompt:  prompt
           ())
       (Lwt_io.printlf "#+begin_src output\n%s#+end_src output")


let read_whole_file =
  let filename  = Sys.argv.(1) in
  let ch = open_in_bin filename in
  let s = really_input_string ch (in_channel_length ch) in
  close_in ch;
  s

let read_file  =
  let prompt = read_whole_file in
  let filename  = Sys.argv.(2) in
  let chan = open_in filename in
  try
    while true; do
      let l1 = input_line chan in 
      run (prompt ^ l1)
    done;
  with End_of_file ->
    close_in chan

    
let () = read_file 
