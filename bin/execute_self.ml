let type_terms = [  "set";  "type";  "sort"] 
let model_name = "mixtral" 
let url= "https://dev-hub.agentartificial.com"
let verbs = [
  "consider";"specify";"encode";"code";
  "semiotically";
  "teach";"train";"learn";
  "program";"prove";"design";"analyse";"lift";"shift";"splice";"quote";
  "quasi-quote";
  "quasi-quine-quote";
  "quasi-quine-quote-in-ocaml";
  "quasi-quine-quote-in-ocaml-coq-metacoq";
  "quasi-quine-quote-in-ocaml-coq-metacoq-introspector";
  "quasi-quine-quote-in-ocaml-coq-metacoq-introspector-bootstrap";
  "quasi-quine-quote-in-ocaml-coq-metacoq-introspector-bootstrap-observe";
  "quasi-quine-quote-in-ocaml-coq-metacoq-introspector-bootstrap-orient";
  "quasi-quine-quote-in-ocaml-coq-metacoq-introspector-bootstrap-decide";
  "quasi-quine-quote-in-ocaml-coq-metacoq-introspector-bootstrap-act";
  "meta-quote"
]
let places = [
  "the universe and universe of universes";
  "the universe";
  "the galatic cluster";
  "the galaxy";
  "the solar system cluster";
  "the solar system";
  "the local planets";
  "the planet";
  "the continent";
  "the region";
  "the country";
  "the city";
  "the street";
  "the house";
  "the building";
  "the dungeon";
  "the labyrinth";
  "the cave";
  "the swamp";
  "the minecraft game engine";
  "the fornite game engine";
  "the quake game engine";
  "the doom game engine";  
  "the room";
  "the hallway";
  "the atom";
  "the quark";
  "the string";
  "the smallest concievable partical" 
]

let prompt type_name try_n verb place=
  "\"" ^
  verb ^ " a " ^
  " consecutive series "^
  " of " ^ type_name ^
  " to describe " ^
  place ^
  " what is your ordering?" ^
  " Please use variant number " ^ ( string_of_int try_n) ^
    "\"" 
                       
let count= 3 
let simple = "dune exec ./bin/simple.exe --" 
let binding = "--openai" 
let test_name = "quine_bootstrap_introspector"
let make_args type_name i verb place= [
  simple;
  binding;
  "-m";    model_name;
  "-s";    test_name;
  "-x";    ".new_" ^ (string_of_int i) ^ verb ^  type_name ^  ".txt";
  "-p";    prompt    type_name           i verb place;
  "-u";    url;
]

let do_apply_list    run_cmd make_args type_terms =
  for i = 1 to count do
    List.iter (fun term ->
        List.iter (fun verb ->
            List.iter (fun place ->
                let args = make_args term i verb place in
                run_cmd args
              ) places
          ) verbs
      ) type_terms
  done
    
(* let run_cmd args = *)
(*   let cmd =  String.concat " " args in *)
(*   Printf.printf "Cmd: %s\n" cmd; *)
(*   let inp = Unix.open_process_in cmd in *)
(*   let r = In_channel.input_lines inp in *)
(*   In_channel.close inp; *)
(*   let out = String.concat " " r in *)
(*   Printf.printf "Output: %s\n" out *)
    
let () =do_apply_list Lang_agent__Unix_handling.run_cmd make_args type_terms 
    
