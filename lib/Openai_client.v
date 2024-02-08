(** File generated by coq-of-ocaml *)
Require Import CoqOfOCaml.CoqOfOCaml.
Require Import CoqOfOCaml.Settings.

Definition t_key_string : Set := string.

Definition t_address_string : Set := string.

Definition t_model_name : Set := string.

Definition t_temperature_float : Set := Stdlib.Float.t.

Definition t_max_tokens_int : Set := Stdlib.Int.t.

Definition t_system_content_string : Set := string.

Definition t_prompt_string : Set := string.

Definition t_response_string : Set := string.

Definition dobind
  (prompt : string) (the_client : Openai.Client.t)
  (self : Lang_agent.Lang_model.client_t) : string :=
  let newprompt := String.append "Is it because of your mother you say " prompt
    in
  let result_value := Stdlib.ref_value "" in
  let '_ :=
    CoqOfOCaml.Stdlib.ignore
      (Lwt_main.run
        (Lwt.bind
          (Openai.Chat_completion.send the_client None
            (Some self.(Lang_agent.Lang_model.client_t.agt_tokens))
            [
              {|
                Openai.Chat_completion.message.content :=
                  self.(Lang_agent.Lang_model.client_t.agt_system_prompt);
                Openai.Chat_completion.message.role :=
                  Variant.Build "System" unit tt; |};
              {| Openai.Chat_completion.message.content := newprompt;
                Openai.Chat_completion.message.role :=
                  Variant.Build "User" unit tt; |}
            ] (Some self.(Lang_agent.Lang_model.client_t.agt_temp)) None None
            None None None None None None tt)
          (Lwt_io.printlf
            (CamlinternalFormatBasics.Format
              (CamlinternalFormatBasics.String_literal "res: "
                (CamlinternalFormatBasics.String
                  CamlinternalFormatBasics.No_padding
                  CamlinternalFormatBasics.End_of_format)) "res: %s")))) in
  Stdlib.op_exclamation result_value.

(* ❌ Structure item `class` not handled. *)
(* class *)
