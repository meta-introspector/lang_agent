
let clean s = 
  String.mapi (fun _ c -> if c = ' ' then '_' else c) s
  
let type_terms = [
  "executable";
  "filter";
  "database";
  "functions";
  "task";
  "project";
  "bug_report";
  "feature_request";
  "theme";
  "security_policy";
  "access_control_list";
  "music";
  "infrastructure_as_code";
  "secrets";
  "hero_journey"
] 
let model_name = "mixtral" 
let url= "https://dev-hub.agentartificial.com"
let verbs = [
  "introspect";
  "reflect";
  "reify";   
  "role-play";
  "specify";"encode";"code";  "program";"prove";
  "create";  "design";
  "create_descriptions_for_an_artist";
  "create_descriptions_for_an_artist_to_design_a_comic_book_panel";
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

let places = [
  "Ast";
  "Bytecode";
  "Term";
  "Proof";
  "Parse Tree";
  "Parser";
  "project";
  "university";
  "company";
  "main memory";
  "stack";
  "heap";
  "tree";
  "list";
  "string";
  "vector";
  "tensor";
  "container";
]

                       
let count= 3 
let simple = "dune exec ./bin/simple.exe --" 
let binding = "--openai" 
let test_name = "generic"

let prompt type_name try_n verb place=
  "\"" ^
  "We are building a prompt software generator for ocaml with coq proofs with a large language model and a proof engine combined via adaptive language agent architecture. In that context we ask you to forgivingly and creativly use the following context: Verb : " ^ verb ^ "; Type Name: " ^ type_name ^ "; Place: " ^  place ^   " . What is your response?" ^  " Please generate prompt variant array of size " ^ ( string_of_int try_n) ^    "\"" 

let make_args type_name i verb place= [
  simple;
  binding;
  "-m";    model_name;
  "-s";    "data/" ^ test_name ^ type_name ^ verb;
  "-x";   (clean ("_" ^ (string_of_int i) ^ verb ^  type_name ^ place ^  ".txt"));
  "-p";    prompt    type_name           i verb place;
  "-u";    url;
]

let top_terms =  [
  "Launch";
  "Bootstrap";
  "Kickstart";
  "Imagine";
  "Consider";
  "Draw";
  "Paint";
  "Compose";
  "Balance"]
                 
let do_apply_list    run_cmd make_args type_terms =
    List.iter (fun top ->
        List.iter (fun term ->
            List.iter (fun term2 ->
                List.iter (fun verb ->
                    List.iter (fun place ->
                      List.iter (fun place2 ->
                            for i = 1 to count do
                              let term3 = term ^ " with a " ^ term2 in
                              let verb2 = top ^ " doing " ^ verb in
                              let place3 = place ^ " connected with " ^ place2 in
                              let args = make_args
                                  term3 (i + 3) verb2
                                  place3 in
                              run_cmd args
                            done
                          ) places
                      ) places
                  ) verbs
              ) type_terms
          ) type_terms
      ) top_terms

    
let run_cmd args =
  let cmd =  String.concat " " args in
  Printf.printf "Cmd: %s\n" cmd;
  flush stdout;
  let inp = Unix.open_process_in cmd in
  let r = In_channel.input_lines inp in
  In_channel.close inp;
  let out = String.concat " " r in
  Printf.printf "Output: %s\n" out
    
let () =do_apply_list run_cmd make_args type_terms 
    
