
let type_terms = [  "set";  "type";  "sort"] 
let model_name = "mixtral" 
let url= "https://dev-hub.agentartificial.com" 
let prompt type_name try_n =
  "\"" ^
  "consider a " ^
  "consecutive series "^
  "of " ^ type_name ^
  "to describe " ^
  "the universe and universe of universes" ^
  "what is your ordering?" ^
  "Please use variant number " ^ ( string_of_int try_n) ^
    "\"" 
                       
let count= 10 
let simple = "dune exec ./bin/simple.exe --" 
let binding = "--openai" 
let test_name = "quine_bootstrap"
let make_args type_name i = [
  simple;
  binding;
  "-m";    model_name;
  "-s";    test_name;
  "-x";    ".new_" ^ (string_of_int i);
  "-p";    prompt
    type_name
           i;
  "-u";    url;
]

let do_apply_list    run_cmd make_args type_terms   =
  List.iter (fun s ->

      for i = 1 to count do
        let args = make_args s i in
        run_cmd args 
      done
    ) type_terms 
    
let run_cmd args =
  let cmd =  String.concat " " args in
  Printf.printf "Cmd: %s\n" cmd;
  let inp = Unix.open_process_in cmd in
  let r = In_channel.input_lines inp in
  In_channel.close inp;
  let out = String.concat " " r in
  Printf.printf "Output: %s\n" out
    
let () =do_apply_list run_cmd make_args type_terms 
    
