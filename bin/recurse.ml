open Lang_agent
let last_response = ref ""
let process_prompt: 'client_t1 -> 'client_t2 -> string -> string -> string -> string -> int ->unit =
  fun client1 param_record path model prompt1 suffix repeat ->
  (print_endline ("Consider:" ^  model ^ path));
  let aux dir =
    let full_path = dir  in
    let full_out_path = full_path ^ suffix in    
    if Sys.file_exists  full_out_path then
      print_endline ("SKIP existing " ^ full_out_path)
    else
      let oc = open_out full_out_path in

      let do_one lr  =
        let prompt = prompt1 ^ " "^   lr in
        print_endline ("send" ^ prompt); 
        let res = (client1#lang_prompt param_record prompt ) in
        print_endline ("OUTPUT: " ^ full_out_path);
        last_response  := res;
        print_endline ("LR:" ^ !last_response       ); 
        if res == "ERROR"
        then
          print_endline ("ERROR: " ^ full_out_path)
        else
          (
            Printf.fprintf oc
              "\n#+begin_src input\n%s\n#+end_src\n#+begin_src output %s\n%s\n#+end_src\n"
              prompt model res;
          );        
        res
      in
      for _ = 1 to repeat do
        let lo = do_one !last_response in
        print_endline ("DEBUG: " ^ lo);
        ()
      done;
      close_out oc
in
aux (path )

let anon_fun _ = ()
  

let () =
  let start = ref "" in
  let item_count = ref 1 in
  let prompt = ref "" in
  let model = ref "mistral" in
  let suffix = ref ".out" in

  let open_ai_client  = new Openai_client.open_ai_lang_model in
  let ollama_client  = new Ollama.ollama_lang_model    in
  let use_ollama_ref  = ref true in 
  let url = ref "" in
  let help_str = "test" in
  let opts = [
      "-s", Arg.Set_string start, "startdir";
      "-n", Arg.Set_int item_count, "generate count items";
      "-p", Arg.Set_string prompt, "prompt";
      "-x", Arg.Set_string suffix, "suffix";
      "-m", Arg.Set_string model, "model";
      "--openai", Arg.Unit (fun () -> 
                      use_ollama_ref := false; ()
                    ),      " Use Openai ";          
      "--ollama", Arg.Unit (fun () -> ()),      " Use Ollama (default)"; 
      "-u", Arg.Set_string url, "url";
    ] |> Arg.align in
  Arg.parse opts anon_fun help_str;
  Printf.printf "DEBUG3 path %s\n" !start;
  (print_endline ("DEBUG4 MODEL :" ^ ! model) );

  if ! use_ollama_ref then
    let client_param_record = (ollama_client#lang_init())  in 
    let client_param_record2 = ollama_client#lang_open client_param_record ! url in 
    let client_param_record3 = ollama_client#lang_set_model client_param_record2 ! model in 
    process_prompt ollama_client client_param_record3 !start !model !prompt !suffix !item_count
  else
    let client_param_record = (open_ai_client#lang_init())  in 
    let client_param_record2 = open_ai_client#lang_open client_param_record ! url in 
    let client_param_record3 = open_ai_client#lang_set_model client_param_record2 ! model in 
    process_prompt open_ai_client client_param_record3 !start !model !prompt !suffix !item_count

