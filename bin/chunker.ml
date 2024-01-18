open Lang_agent    

let run (prompt) =
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
       (Lwt_io.printlf "res: %s")


let read_file  =
  let filename  = Sys.argv.(1) in
  let chan = open_in filename in
  try
    while true; do
      let l1 = input_line chan in 
      run l1
    done;
  with End_of_file ->
    close_in chan

let () = read_file 
