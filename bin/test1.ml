(* class virtual language_binding : object *)
(*   method virtual send : self -> string -> string -> unit -> unit *)
(* end *)



(* let run_model : language_binding -> string -> string -> unit = *)
(*   fun language_binding model prompt -> *)
(*     print_endline ( *)
(*       "\n#+begin_src input "^model^"\n" ^ *)
(*       prompt ^ *)
(*       "\n#+end_src input\n" *)
(*     ); *)
(*     Lwt_main.run *)
(*       (Lwt.bind *)
(*          (language_binding#send language_binding model prompt ()) *)
(*          (Lwt_io.printlf "\n#+begin_src output\n%s\n#+end_src output")) *)

(* (\* Assuming concrete implementations inheriting from language_binding *\) *)
(* class ollama : language_binding inherits object *)
(*   method! send _model _prompt _data _unused = *)
(*     (\* Implementation using Ollama.send for your needs *\) *)

(* class my_binding : language_binding inherits object *)
(*   method! send _model _prompt _data _unused = *)
(*     (\* Implementation using your binding specifics *\) *)

(* (\* Usage *\) *)
(* let model = "your_model" *)
(* let prompt = "your_prompt" *)

(* run_model (new ollama : language_binding) model prompt *)
(* run_model (new my_binding : language_binding) model prompt *)
