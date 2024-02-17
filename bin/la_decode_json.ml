
include Yojson.Safe

open Lang_agent

let anon_fun _ = ()
  
let read_whole_file filename =
  let ch = open_in_bin filename in
  let s = really_input_string ch (in_channel_length ch) in
  close_in ch;
  s
        
let () =
  let prompt = ref "" in
  let help_str = "test" in
  let opts = [
      "-p", Arg.Set_string prompt, "prompt filename";
    ] |> Arg.align in
  Arg.parse opts anon_fun help_str;
  let pt =  !prompt in
  (print_endline ("DEBUG9 PROMPT FILE:" ^ pt) );
  let promptf = read_whole_file pt in 
  (print_endline ("DEBUG9 PROMPT :" ^ promptf) );
  let json = Yojson.Safe.from_string promptf in
  try
    let record_opt = (Llama_cpp.llama_cpp_response_of_yojson json) in  
    (print_endline ("DEBUG9 OUT :" ^ record_opt.content) );
  with
  | Ppx_yojson_conv_lib__Yojson_conv.Of_yojson_error(w, _) ->
    (print_endline ("ERROR" ^ Printexc.to_string w ));
  | _ ->    
    (print_endline ("ERROR"));
