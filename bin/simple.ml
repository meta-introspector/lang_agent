open Lang_agent

type backend =
  | BNone
  | BOllama of Ollama.ollama_lang_model
  | BOpenAi of Openai_client.open_ai_lang_model
  | BLlamaCpp of Llama_cpp.llama_cpp_lang_model

type backend2 =

  | B2None  
  | B2Ollama of Ollama.client_t Lang_model.client_t
  | B2OpenAi of Openai.Client.t Lang_model.client_t
  | B2LlamaCpp of Llama_cpp.client_t Lang_model.client_t

let lc_lang_prompt lang_client  param_record prompt =
  match lang_client with 
  | BOllama   m ->( match param_record with
      | B2Ollama   p -> m#lang_prompt p prompt;
      | _ -> ""
    );
  | BOpenAi   m ->( match param_record with | B2OpenAi   p -> m#lang_prompt p prompt
                                            | _ -> "");
  | BLlamaCpp m ->( match param_record with | B2LlamaCpp p -> m#lang_prompt p prompt
                                            | _ -> "")
  | _ -> ""

let process_prompt: backend -> 'client_t2 -> string -> string -> string -> string -> int ->unit =
  fun client1 param_record path model prompt1 suffix repeat ->
  (print_endline ("Consider:" ^  model ^ path));
  let aux dir =
    let full_path = dir  in
    let full_out_path = full_path ^ suffix in
    
    if Sys.file_exists  full_out_path then
      print_endline ("SKIP existing" ^ full_out_path)
    else
      let do_one  (data)=
        let prompt = prompt1 ^ data in
        (* print_endline ("send" ^ prompt); *)
        let res = (lc_lang_prompt client1 param_record prompt ) in
        
        print_endline ("OUTPUT: " ^ full_out_path);
        
        if res == "ERROR"
        then
          print_endline ("ERROR: " ^ full_out_path)
        else
          (
            let oc = open_out full_out_path in
            Printf.fprintf oc
              "\n#+begin_src input\n%s\n#+end_src\n#+begin_src output %s\n%s\n#+end_src\n"
              data model res;
            close_out oc;
          );
        
        "FIXME"

      in
      
        let _ = do_one prompt1 in
        ()

in
for i = 1 to repeat do
  aux (path ^ "_" ^(string_of_int i))
done


let anon_fun _ = ()

let lc_init lang_client aurl amodel =
  match lang_client with 
  | BNone -> B2None
  | BOllama m ->
    let a = m#lang_init() in
    let c1 = m#lang_open a aurl in 
    let c2 = m#lang_set_model c1 amodel in
    B2Ollama c2
  | BOpenAi m ->
    let a = m#lang_init() in
    let c1 = m#lang_open a aurl in 
    let c2 = m#lang_set_model c1 amodel in
    B2OpenAi c2
  | BLlamaCpp m ->
    let a = m#lang_init() in
    let c1 = m#lang_open a aurl in 
    let c2 = m#lang_set_model c1 amodel in
    B2LlamaCpp c2

  
        
let () =
  let start = ref "" in
  let item_count = ref 1 in
  let prompt = ref "" in
  let model = ref "mistral" in
  let suffix = ref ".out" in

  let lang_client  = ref BNone in
  
  let url = ref "" in
  let help_str = "test" in
  let opts = [
      "-s", Arg.Set_string start, "startdir";
      "-n", Arg.Set_int item_count, "generate count items";
      "-p", Arg.Set_string prompt, "prompt";
      "-x", Arg.Set_string suffix, "suffix";
      "-m", Arg.Set_string model, "model";
      "--openai", Arg.Unit (fun () ->
          lang_client  := BOpenAi new Openai_client.open_ai_lang_model; ()
        ),      " Use Openai ";          
      "--ollama", Arg.Unit (fun () ->
          lang_client  := BOllama new Ollama.ollama_lang_model  ; ()
        ),      " Use Ollama (default)";
      "--llamacpp", Arg.Unit (fun () ->
          lang_client  := BLlamaCpp  new Llama_cpp.llama_cpp_lang_model  ; ()
        ),      " Use Ollama (default)";
      "-u", Arg.Set_string url, "url";
    ] |> Arg.align in
  Arg.parse opts anon_fun help_str;
  Printf.printf "DEBUG3 path %s\n" !start;
  (print_endline ("DEBUG4 MODEL :" ^ ! model) );
    let client_param_record = lc_init !lang_client !url !model   in 
    process_prompt !lang_client client_param_record !start !model !prompt !suffix !item_count


