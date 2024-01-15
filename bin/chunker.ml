open Lang_agent    

let run () =
  let model = "mistral" in
  let client = Ollama.create_client model in
  ignore
  @@ Lwt_main.run
  @@ Lwt.bind
       Ollama.(
         send
           client
           ~prompt: "Tell me an epic story about the battle between the llamas vs the camels"
           ())
       (Lwt_io.printlf "res: %s")

let () = run ()
