let type_terms = [
  "weapon";
  "spell";
  "artifacts";
  "magic items";
  "treasure";
  "monster";
  "quest";
  "challege";
  "theme";
  "drama";
  "music";
  "art";
  "secrets";
  "occult";
  "reveal";
  "hero journey"
] 
let model_name = "mixtral" 
let url= "https://dev-hub.agentartificial.com"
let verbs = [
  "role-play";
  "specify";"encode";"code";  "program";"prove";
  "create";  "design";
  "create descriptions for an artist";
  "create descriptions for an artist to design a comic book panel";
  "analyse";"lift";"shift";"splice";"quote";
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
let top_terms =  ["Imagine";
                  "Consider";
                  "Draw";
                  "Paint";
                  "Compose";
                  "Balance"]

let places = [
  "the country";
  "the region";
  "the city";
  "the street";
  "the house";
  "the building";
  "the dungeon";
  "the labyrinth";
  "the cave";
  "the swamp";
  "the room";
  "the hallway";
  "the chest";
  "the bag";
  "the wallet";
  "the vault";
  "the keep";
  "the hideout";
  "platos cave";
  "garden of eden";
  "the river styx";
  "the restaurant at the end of the universe";
]
                       
let count= 3 
let simple = "dune exec ./bin/simple.exe --" 
let binding = "--openai" 
let test_name = "dungeon2"

let prompt type_name try_n verb place=
  "\"" ^
  "We are building a dungeon generator for a fantasy role-playing game with a large language model and a proof engine combined via adaptive language agent architecture. In that context we ask you to forgivingly and creatively use the following context: Verb : " ^ verb ^ "; Type Name: " ^ type_name ^ "; Place: " ^  place ^   " What is your response?" ^  " Please generate variant array of size " ^ ( string_of_int try_n) ^    "\"" 

let make_args type_name i verb place= [
  simple;
  binding;
  "-m";    model_name;
  "-s";    test_name ^ type_name ^ verb;
  "-x";    ".new_" ^ (string_of_int i) ^ verb ^  type_name ^ place ^  ".txt";
  "-p";    prompt    type_name           i verb place;
  "-u";    url;
]

                 
let do_apply_list    run_cmd make_args type_terms =
  for i = 1 to count do
    List.iter (fun top ->
        List.iter (fun term ->
            List.iter (fun term2 ->
                List.iter (fun verb ->
                    List.iter (fun place ->
                        List.iter (fun place2 ->
                            let term3 = term ^ " with a " ^ term2 in
                            let verb2 = top ^ " doing " ^ verb in
                            let place3 = place ^ " connected with " ^ place2 in
                            let args = make_args
                                term3 i verb2
                                place3 in
                            run_cmd args
                          ) places
                      ) places
                  ) verbs
              ) type_terms
          ) type_terms
      ) top_terms
  done
    
let run_cmd args =
  let cmd =  String.concat " " args in
  Printf.printf "Cmd: %s\n" cmd;
  let inp = Unix.open_process_in cmd in
  let r = In_channel.input_line inp in
  In_channel.close inp;
  match r with
  |Some out ->
    Printf.printf "Output: %s\n" out
  |None ->
    Printf.printf "Output: None\n"
    
let () =do_apply_list run_cmd make_args type_terms 
    
