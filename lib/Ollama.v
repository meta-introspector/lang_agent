(** File generated by coq-of-ocaml *)
Require Import CoqOfOCaml.



(* Definition json_to_field_opt {A B : Set} *)
(*   (name : A) (f_value : B -> variant) (o_value : option B) : A * variant := *)
(*   (name, *)
(*     match o_value with *)
(*     | Some v_value => f_value v_value *)
(*     | None => Variant.Build "Null" unit tt *)
(*     end). *)
Inductive Curl := | NoConnection.

Module client_t.
  Record record : Set := Build {
    model : string;
    gen_url : string -> string;
    c : Curl;
  }.
  Definition with_model model (r : record) :=
    Build model r.(gen_url) r.(c).
  Definition with_gen_url gen_url (r : record) :=
    Build r.(model) gen_url r.(c).
  Definition with_c c (r : record) :=
    Build r.(model) r.(gen_url) c.
End client_t.
Definition client_t := client_t.record.

(* Definition create_client (model : string) : client_t := *)
(*   let base_url := None in *)
(*   {| client_t.model := model; client_t.gen_url := String.append base_url; *)
(*     client_t.c := Ezcurl_lwt.make None tt; |}. *)

Inductive role : Set :=
| Assistant : role
| User : role
| System : role.

(* Definition yojson_of_role (function_parameter : Variant.t) : Variant.t := *)
(*   match function_parameter with *)
(*   | System => Variant.Build "String" string "system" *)
(*   | User => Variant.Build "String" string "user" *)
(*   | Assistant => Variant.Build "String" string "assistant" *)
(*   end. *)

Module message.
  Record record : Set := Build {
    content : string;
    role : role;
  }.
  Definition with_content content (r : record) :=
    Build content r.(role).
  Definition with_role role (r : record) :=
    Build r.(content) role.
End message.
Definition message := message.record.

Module nameless_include.
  
  
  (* Definition yojson_of_message (function_parameter : message) *)
  (*   : Ppx_yojson_conv_lib.Yojson.Safe.t := *)
  (*   let '{| message.content := v_content; message.role := v_role |} := *)
  (*     function_parameter in *)
  (*   let bnds := nil in *)
  (*   let bnds := *)
  (*     let arg := yojson_of_role v_role in *)
  (*     cons ("role", arg) bnds in *)
  (*   let bnds := *)
  (*     let arg := *)
  (*       Ppx_yojson_conv_lib.Yojson_conv.Primitives.yojson_of_string v_content in *)
  (*     cons ("content", arg) bnds in *)
  (*   Variant.Build "Assoc" (list (string * Ppx_yojson_conv_lib.Yojson.Safe.t)) *)
  (*     bnds. *)
  

End nameless_include.

Include nameless_include.

(* Definition send_raw_k {A : Set} *)
(*   (k_value : sum Ezcurl_core.response (Curl.curlCode * string) -> Lwt.t A) *)
(*   (client : client_t) (model : string) (prompt : string) *)
(*   (function_parameter : unit) : Lwt.t A := *)
(*   let '_ := function_parameter in *)
(*   let '_ := CoqOfOCaml.Stdlib.print_endline (String.append "DEBUG:" prompt) in *)
(*   let body := *)
(*     (fun (l_value : list (string * Yojson.Safe.t)) => *)
(*       Yojson.Safe.to_string None None None None *)
(*         (Variant.Build "Assoc" (list (string * Yojson.Safe.t)) l_value)) *)
(*       (Stdlib.List.filter *)
(*         (fun (function_parameter : string * Yojson.Safe.t) => *)
(*           let '(_, v_value) := function_parameter in *)
(*           nequiv_decb v_value (Variant.Build "Null" unit tt)) *)
(*         [ *)
(*           ("model", (Variant.Build "String" string model)); *)
(*           ("prompt", (Variant.Build "String" string prompt)) *)
(*         ]) in *)
(*   let headers := [ ("content-type", "application/json") ] in *)
(*   let endpoint := "/api/generate" in *)
(*   let __ppx_lwt_0 := *)
(*     Ezcurl_lwt.post None (Some client.(client_t.c)) None (Some headers) *)
(*       (Some (Variant.Build "String" string body)) nil *)
(*       (client.(client_t.gen_url) endpoint) tt in *)
(*   let Reraise := *)
(*     (* ❌ No module type was found for this structure. *) *)
(*     no_expected_module_type_found in *)
(*   Lwt.backtrace_bind *)
(*     (fun (exn_value : extensible_type) => *)
(*       (* ❌ Try-with are not handled *) *)
(*       try_with (fun _ => Reraise.reraise exn_value) (fun exn_value => exn_value)) *)
(*     ppx_lwt_0 *)
(*     (fun (resp : sum Ezcurl_core.response (Curl.curlCode * string)) => *)
(*       k_value resp). *)
Inductive int := One.

Module ollama_response.
  Record record : Set := Build {
    model : string;
    created_at : string;
    response : string;
    isdone : bool;
    context : option (list int);
    total_duration : option int;
    load_duration : option int;
    prompt_eval_count : option int;
    prompt_eval_duration : option int;
    eval_count : option int;
    eval_duration : option int;
  }.
  Definition with_model model (r : record) :=
    Build model r.(created_at) r.(response) r.(isdone) r.(context)
      r.(total_duration) r.(load_duration) r.(prompt_eval_count)
      r.(prompt_eval_duration) r.(eval_count) r.(eval_duration).
  Definition with_created_at created_at (r : record) :=
    Build r.(model) created_at r.(response) r.(isdone) r.(context)
      r.(total_duration) r.(load_duration) r.(prompt_eval_count)
      r.(prompt_eval_duration) r.(eval_count) r.(eval_duration).
  Definition with_response response (r : record) :=
    Build r.(model) r.(created_at) response r.(isdone) r.(context)
      r.(total_duration) r.(load_duration) r.(prompt_eval_count)
      r.(prompt_eval_duration) r.(eval_count) r.(eval_duration).
  Definition with_isdone isdone (r : record) :=
    Build r.(model) r.(created_at) r.(response) isdone r.(context)
      r.(total_duration) r.(load_duration) r.(prompt_eval_count)
      r.(prompt_eval_duration) r.(eval_count) r.(eval_duration).
  Definition with_context context (r : record) :=
    Build r.(model) r.(created_at) r.(response) r.(isdone) context
      r.(total_duration) r.(load_duration) r.(prompt_eval_count)
      r.(prompt_eval_duration) r.(eval_count) r.(eval_duration).
  Definition with_total_duration total_duration (r : record) :=
    Build r.(model) r.(created_at) r.(response) r.(isdone) r.(context)
      total_duration r.(load_duration) r.(prompt_eval_count)
      r.(prompt_eval_duration) r.(eval_count) r.(eval_duration).
  Definition with_load_duration load_duration (r : record) :=
    Build r.(model) r.(created_at) r.(response) r.(isdone) r.(context)
      r.(total_duration) load_duration r.(prompt_eval_count)
      r.(prompt_eval_duration) r.(eval_count) r.(eval_duration).
  Definition with_prompt_eval_count prompt_eval_count (r : record) :=
    Build r.(model) r.(created_at) r.(response) r.(isdone) r.(context)
      r.(total_duration) r.(load_duration) prompt_eval_count
      r.(prompt_eval_duration) r.(eval_count) r.(eval_duration).
  Definition with_prompt_eval_duration prompt_eval_duration (r : record) :=
    Build r.(model) r.(created_at) r.(response) r.(isdone) r.(context)
      r.(total_duration) r.(load_duration) r.(prompt_eval_count)
      prompt_eval_duration r.(eval_count) r.(eval_duration).
  Definition with_eval_count eval_count (r : record) :=
    Build r.(model) r.(created_at) r.(response) r.(isdone) r.(context)
      r.(total_duration) r.(load_duration) r.(prompt_eval_count)
      r.(prompt_eval_duration) eval_count r.(eval_duration).
  Definition with_eval_duration eval_duration (r : record) :=
    Build r.(model) r.(created_at) r.(response) r.(isdone) r.(context)
      r.(total_duration) r.(load_duration) r.(prompt_eval_count)
      r.(prompt_eval_duration) r.(eval_count) eval_duration.
End ollama_response.
Definition ollama_response := ollama_response.record.

(* Module nameless_include. *)
  
  
(*   Definition ollama_response_of_yojson *)
(*     : Ppx_yojson_conv_lib.Yojson.Safe.t -> ollama_response := *)
(*     let _tp_loc := "ollama.ml.ollama_response" in *)
(*     fun (function_parameter : Ppx_yojson_conv_lib.Yojson.Safe.t) => *)
(*       match function_parameter with *)
(*       | (Assoc field_yojsons) as yojson => *)
(*         let model_field : Stdlib.ref (Ppx_yojson_conv_lib.Option.t string) := *)
(*           Stdlib.ref_value None *)
(*         in let created_at_field *)
(*           : Stdlib.ref (Ppx_yojson_conv_lib.Option.t string) := *)
(*           Stdlib.ref_value None *)
(*         in let response_field *)
(*           : Stdlib.ref (Ppx_yojson_conv_lib.Option.t string) := *)
(*           Stdlib.ref_value None *)
(*         in let isdone_field : Stdlib.ref (Ppx_yojson_conv_lib.Option.t bool) := *)
(*           Stdlib.ref_value None *)
(*         in let context_field *)
(*           : Stdlib.ref (Ppx_yojson_conv_lib.Option.t (list int)) := *)
(*           Stdlib.ref_value None *)
(*         in let total_duration_field *)
(*           : Stdlib.ref (Ppx_yojson_conv_lib.Option.t int) := *)
(*           Stdlib.ref_value None *)
(*         in let load_duration_field *)
(*           : Stdlib.ref (Ppx_yojson_conv_lib.Option.t int) := *)
(*           Stdlib.ref_value None *)
(*         in let prompt_eval_count_field *)
(*           : Stdlib.ref (Ppx_yojson_conv_lib.Option.t int) := *)
(*           Stdlib.ref_value None *)
(*         in let prompt_eval_duration_field *)
(*           : Stdlib.ref (Ppx_yojson_conv_lib.Option.t int) := *)
(*           Stdlib.ref_value None *)
(*         in let eval_count_field *)
(*           : Stdlib.ref (Ppx_yojson_conv_lib.Option.t int) := *)
(*           Stdlib.ref_value None *)
(*         in let eval_duration_field *)
(*           : Stdlib.ref (Ppx_yojson_conv_lib.Option.t int) := *)
(*           Stdlib.ref_value None *)
(*         in let duplicates : Stdlib.ref (list string) := *)
(*           Stdlib.ref_value nil *)
(*         in let extra : Stdlib.ref (list string) := *)
(*           Stdlib.ref_value nil in *)
(*         let fix iter (function_parameter : list (string * Yojson.Safe.t)) *)
(*           : unit := *)
(*           match function_parameter with *)
(*           | cons (field_name, _field_yojson) tail => *)
(*             let '_ := *)
(*               match field_name with *)
(*               | "model" => *)
(*                 match Ppx_yojson_conv_lib.op_exclamation model_field with *)
(*                 | None => *)
(*                   let fvalue := *)
(*                     Ppx_yojson_conv_lib.Yojson_conv.Primitives.string_of_yojson *)
(*                       _field_yojson in *)
(*                   Stdlib.op_coloneq model_field (Some fvalue) *)
(*                 | Some _ => *)
(*                   Stdlib.op_coloneq duplicates *)
(*                     (cons field_name *)
(*                       (Ppx_yojson_conv_lib.op_exclamation duplicates)) *)
(*                 end *)
(*               | "created_at" => *)
(*                 match Ppx_yojson_conv_lib.op_exclamation created_at_field with *)
(*                 | None => *)
(*                   let fvalue := *)
(*                     Ppx_yojson_conv_lib.Yojson_conv.Primitives.string_of_yojson *)
(*                       _field_yojson in *)
(*                   Stdlib.op_coloneq created_at_field (Some fvalue) *)
(*                 | Some _ => *)
(*                   Stdlib.op_coloneq duplicates *)
(*                     (cons field_name *)
(*                       (Ppx_yojson_conv_lib.op_exclamation duplicates)) *)
(*                 end *)
(*               | "response" => *)
(*                 match Ppx_yojson_conv_lib.op_exclamation response_field with *)
(*                 | None => *)
(*                   let fvalue := *)
(*                     Ppx_yojson_conv_lib.Yojson_conv.Primitives.string_of_yojson *)
(*                       _field_yojson in *)
(*                   Stdlib.op_coloneq response_field (Some fvalue) *)
(*                 | Some _ => *)
(*                   Stdlib.op_coloneq duplicates *)
(*                     (cons field_name *)
(*                       (Ppx_yojson_conv_lib.op_exclamation duplicates)) *)
(*                 end *)
(*               | "done" => *)
(*                 match Ppx_yojson_conv_lib.op_exclamation isdone_field with *)
(*                 | None => *)
(*                   let fvalue := *)
(*                     Ppx_yojson_conv_lib.Yojson_conv.Primitives.bool_of_yojson *)
(*                       _field_yojson in *)
(*                   Stdlib.op_coloneq isdone_field (Some fvalue) *)
(*                 | Some _ => *)
(*                   Stdlib.op_coloneq duplicates *)
(*                     (cons field_name *)
(*                       (Ppx_yojson_conv_lib.op_exclamation duplicates)) *)
(*                 end *)
(*               | "context" => *)
(*                 match Ppx_yojson_conv_lib.op_exclamation context_field with *)
(*                 | None => *)
(*                   let fvalue := *)
(*                     Ppx_yojson_conv_lib.Yojson_conv.Primitives.list_of_yojson *)
(*                       Ppx_yojson_conv_lib.Yojson_conv.Primitives.int_of_yojson *)
(*                       _field_yojson in *)
(*                   Stdlib.op_coloneq context_field (Some fvalue) *)
(*                 | Some _ => *)
(*                   Stdlib.op_coloneq duplicates *)
(*                     (cons field_name *)
(*                       (Ppx_yojson_conv_lib.op_exclamation duplicates)) *)
(*                 end *)
(*               | "total_duration" => *)
(*                 match Ppx_yojson_conv_lib.op_exclamation total_duration_field *)
(*                   with *)
(*                 | None => *)
(*                   let fvalue := *)
(*                     Ppx_yojson_conv_lib.Yojson_conv.Primitives.int_of_yojson *)
(*                       _field_yojson in *)
(*                   Stdlib.op_coloneq total_duration_field (Some fvalue) *)
(*                 | Some _ => *)
(*                   Stdlib.op_coloneq duplicates *)
(*                     (cons field_name *)
(*                       (Ppx_yojson_conv_lib.op_exclamation duplicates)) *)
(*                 end *)
(*               | "load_duration" => *)
(*                 match Ppx_yojson_conv_lib.op_exclamation load_duration_field *)
(*                   with *)
(*                 | None => *)
(*                   let fvalue := *)
(*                     Ppx_yojson_conv_lib.Yojson_conv.Primitives.int_of_yojson *)
(*                       _field_yojson in *)
(*                   Stdlib.op_coloneq load_duration_field (Some fvalue) *)
(*                 | Some _ => *)
(*                   Stdlib.op_coloneq duplicates *)
(*                     (cons field_name *)
(*                       (Ppx_yojson_conv_lib.op_exclamation duplicates)) *)
(*                 end *)
(*               | "prompt_eval_count" => *)
(*                 match Ppx_yojson_conv_lib.op_exclamation prompt_eval_count_field *)
(*                   with *)
(*                 | None => *)
(*                   let fvalue := *)
(*                     Ppx_yojson_conv_lib.Yojson_conv.Primitives.int_of_yojson *)
(*                       _field_yojson in *)
(*                   Stdlib.op_coloneq prompt_eval_count_field (Some fvalue) *)
(*                 | Some _ => *)
(*                   Stdlib.op_coloneq duplicates *)
(*                     (cons field_name *)
(*                       (Ppx_yojson_conv_lib.op_exclamation duplicates)) *)
(*                 end *)
(*               | "prompt_eval_duration" => *)
(*                 match *)
(*                   Ppx_yojson_conv_lib.op_exclamation prompt_eval_duration_field *)
(*                   with *)
(*                 | None => *)
(*                   let fvalue := *)
(*                     Ppx_yojson_conv_lib.Yojson_conv.Primitives.int_of_yojson *)
(*                       _field_yojson in *)
(*                   Stdlib.op_coloneq prompt_eval_duration_field (Some fvalue) *)
(*                 | Some _ => *)
(*                   Stdlib.op_coloneq duplicates *)
(*                     (cons field_name *)
(*                       (Ppx_yojson_conv_lib.op_exclamation duplicates)) *)
(*                 end *)
(*               | "eval_count" => *)
(*                 match Ppx_yojson_conv_lib.op_exclamation eval_count_field with *)
(*                 | None => *)
(*                   let fvalue := *)
(*                     Ppx_yojson_conv_lib.Yojson_conv.Primitives.int_of_yojson *)
(*                       _field_yojson in *)
(*                   Stdlib.op_coloneq eval_count_field (Some fvalue) *)
(*                 | Some _ => *)
(*                   Stdlib.op_coloneq duplicates *)
(*                     (cons field_name *)
(*                       (Ppx_yojson_conv_lib.op_exclamation duplicates)) *)
(*                 end *)
(*               | "eval_duration" => *)
(*                 match Ppx_yojson_conv_lib.op_exclamation eval_duration_field *)
(*                   with *)
(*                 | None => *)
(*                   let fvalue := *)
(*                     Ppx_yojson_conv_lib.Yojson_conv.Primitives.int_of_yojson *)
(*                       _field_yojson in *)
(*                   Stdlib.op_coloneq eval_duration_field (Some fvalue) *)
(*                 | Some _ => *)
(*                   Stdlib.op_coloneq duplicates *)
(*                     (cons field_name *)
(*                       (Ppx_yojson_conv_lib.op_exclamation duplicates)) *)
(*                 end *)
(*               | _ => *)
(*                 if *)
(*                   Ppx_yojson_conv_lib.op_exclamation *)
(*                     Ppx_yojson_conv_lib.Yojson_conv.record_check_extra_fields *)
(*                 then *)
(*                   Stdlib.op_coloneq extra *)
(*                     (cons field_name (Ppx_yojson_conv_lib.op_exclamation extra)) *)
(*                 else *)
(*                   tt *)
(*               end in *)
(*             iter tail *)
(*           | [] => tt *)
(*           end in *)
(*         let '_ := iter field_yojsons in *)
(*         match Ppx_yojson_conv_lib.op_exclamation duplicates with *)
(*         | cons _ _ => *)
(*           Ppx_yojson_conv_lib.Yojson_conv_error.record_duplicate_fields _tp_loc *)
(*             (Ppx_yojson_conv_lib.op_exclamation duplicates) yojson *)
(*         | [] => *)
(*           match Ppx_yojson_conv_lib.op_exclamation extra with *)
(*           | cons _ _ => *)
(*             Ppx_yojson_conv_lib.Yojson_conv_error.record_extra_fields _tp_loc *)
(*               (Ppx_yojson_conv_lib.op_exclamation extra) yojson *)
(*           | [] => *)
(*             match *)
(*               ((Ppx_yojson_conv_lib.op_exclamation model_field), *)
(*                 (Ppx_yojson_conv_lib.op_exclamation created_at_field), *)
(*                 (Ppx_yojson_conv_lib.op_exclamation response_field), *)
(*                 (Ppx_yojson_conv_lib.op_exclamation isdone_field), *)
(*                 (Ppx_yojson_conv_lib.op_exclamation context_field), *)
(*                 (Ppx_yojson_conv_lib.op_exclamation total_duration_field), *)
(*                 (Ppx_yojson_conv_lib.op_exclamation load_duration_field), *)
(*                 (Ppx_yojson_conv_lib.op_exclamation prompt_eval_count_field), *)
(*                 (Ppx_yojson_conv_lib.op_exclamation prompt_eval_duration_field), *)
(*                 (Ppx_yojson_conv_lib.op_exclamation eval_count_field), *)
(*                 (Ppx_yojson_conv_lib.op_exclamation eval_duration_field)) with *)
(*             | *)
(*               (Some model_value, Some created_at_value, Some response_value, *)
(*                 Some isdone_value, context_value, total_duration_value, *)
(*                 load_duration_value, prompt_eval_count_value, *)
(*                 prompt_eval_duration_value, eval_count_value, *)
(*                 eval_duration_value) => *)
(*               {| ollama_response.model := model_value; *)
(*                 ollama_response.created_at := created_at_value; *)
(*                 ollama_response.response := response_value; *)
(*                 ollama_response.isdone := isdone_value; *)
(*                 ollama_response.context := context_value; *)
(*                 ollama_response.total_duration := total_duration_value; *)
(*                 ollama_response.load_duration := load_duration_value; *)
(*                 ollama_response.prompt_eval_count := prompt_eval_count_value; *)
(*                 ollama_response.prompt_eval_duration := *)
(*                   prompt_eval_duration_value; *)
(*                 ollama_response.eval_count := eval_count_value; *)
(*                 ollama_response.eval_duration := eval_duration_value; |} *)
(*             | _ => *)
(*               Ppx_yojson_conv_lib.Yojson_conv_error.record_undefined_elements *)
(*                 _tp_loc yojson *)
(*                 [ *)
(*                   ((Ppx_yojson_conv_lib.poly_equal *)
(*                     (Ppx_yojson_conv_lib.op_exclamation *)
(*                       model_field) None), "model"); *)
(*                   ((Ppx_yojson_conv_lib.poly_equal *)
(*                     (Ppx_yojson_conv_lib.op_exclamation *)
(*                       created_at_field) None), *)
(*                     "created_at"); *)
(*                   ((Ppx_yojson_conv_lib.poly_equal *)
(*                     (Ppx_yojson_conv_lib.op_exclamation *)
(*                       response_field) None), *)
(*                     "response"); *)
(*                   ((Ppx_yojson_conv_lib.poly_equal *)
(*                     (Ppx_yojson_conv_lib.op_exclamation *)
(*                       isdone_field) None), "isdone") *)
(*                 ] *)
(*             end *)
(*           end *)
(*         end *)
(*       | yojson => *)
(*         Ppx_yojson_conv_lib.Yojson_conv_error.record_list_instead_atom _tp_loc *)
(*           yojson *)
(*       end. *)
  
  
  
(*   Definition yojson_of_ollama_response (function_parameter : ollama_response) *)
(*     : Ppx_yojson_conv_lib.Yojson.Safe.t := *)
(*     let '{| *)
(*       ollama_response.model := v_model; *)
(*         ollama_response.created_at := v_created_at; *)
(*         ollama_response.response := v_response; *)
(*         ollama_response.isdone := v_isdone; *)
(*         ollama_response.context := v_context; *)
(*         ollama_response.total_duration := v_total_duration; *)
(*         ollama_response.load_duration := v_load_duration; *)
(*         ollama_response.prompt_eval_count := v_prompt_eval_count; *)
(*         ollama_response.prompt_eval_duration := v_prompt_eval_duration; *)
(*         ollama_response.eval_count := v_eval_count; *)
(*         ollama_response.eval_duration := v_eval_duration *)
(*         |} := function_parameter in *)
(*     let bnds := nil in *)
(*     let bnds := *)
(*       match v_eval_duration with *)
(*       | None => bnds *)
(*       | Some v_value => *)
(*         let arg := *)
(*           Ppx_yojson_conv_lib.Yojson_conv.Primitives.yojson_of_int v_value in *)
(*         let bnd := ("eval_duration", arg) in *)
(*         cons bnd bnds *)
(*       end in *)
(*     let bnds := *)
(*       match v_eval_count with *)
(*       | None => bnds *)
(*       | Some v_value => *)
(*         let arg := *)
(*           Ppx_yojson_conv_lib.Yojson_conv.Primitives.yojson_of_int v_value in *)
(*         let bnd := ("eval_count", arg) in *)
(*         cons bnd bnds *)
(*       end in *)
(*     let bnds := *)
(*       match v_prompt_eval_duration with *)
(*       | None => bnds *)
(*       | Some v_value => *)
(*         let arg := *)
(*           Ppx_yojson_conv_lib.Yojson_conv.Primitives.yojson_of_int v_value in *)
(*         let bnd := ("prompt_eval_duration", arg) in *)
(*         cons bnd bnds *)
(*       end in *)
(*     let bnds := *)
(*       match v_prompt_eval_count with *)
(*       | None => bnds *)
(*       | Some v_value => *)
(*         let arg := *)
(*           Ppx_yojson_conv_lib.Yojson_conv.Primitives.yojson_of_int v_value in *)
(*         let bnd := ("prompt_eval_count", arg) in *)
(*         cons bnd bnds *)
(*       end in *)
(*     let bnds := *)
(*       match v_load_duration with *)
(*       | None => bnds *)
(*       | Some v_value => *)
(*         let arg := *)
(*           Ppx_yojson_conv_lib.Yojson_conv.Primitives.yojson_of_int v_value in *)
(*         let bnd := ("load_duration", arg) in *)
(*         cons bnd bnds *)
(*       end in *)
(*     let bnds := *)
(*       match v_total_duration with *)
(*       | None => bnds *)
(*       | Some v_value => *)
(*         let arg := *)
(*           Ppx_yojson_conv_lib.Yojson_conv.Primitives.yojson_of_int v_value in *)
(*         let bnd := ("total_duration", arg) in *)
(*         cons bnd bnds *)
(*       end in *)
(*     let bnds := *)
(*       match v_context with *)
(*       | None => bnds *)
(*       | Some v_value => *)
(*         let arg := *)
(*           Ppx_yojson_conv_lib.Yojson_conv.Primitives.yojson_of_list *)
(*             Ppx_yojson_conv_lib.Yojson_conv.Primitives.yojson_of_int v_value in *)
(*         let bnd := ("context", arg) in *)
(*         cons bnd bnds *)
(*       end in *)
(*     let bnds := *)
(*       let arg := *)
(*         Ppx_yojson_conv_lib.Yojson_conv.Primitives.yojson_of_bool v_isdone in *)
(*       cons ("done", arg) bnds in *)
(*     let bnds := *)
(*       let arg := *)
(*         Ppx_yojson_conv_lib.Yojson_conv.Primitives.yojson_of_string v_response *)
(*         in *)
(*       cons ("response", arg) bnds in *)
(*     let bnds := *)
(*       let arg := *)
(*         Ppx_yojson_conv_lib.Yojson_conv.Primitives.yojson_of_string v_created_at *)
(*         in *)
(*       cons ("created_at", arg) bnds in *)
(*     let bnds := *)
(*       let arg := *)
(*         Ppx_yojson_conv_lib.Yojson_conv.Primitives.yojson_of_string v_model in *)
(*       cons ("model", arg) bnds in *)
(*     Variant.Build "Assoc" (list (string * Ppx_yojson_conv_lib.Yojson.Safe.t)) *)
(*       bnds. *)
  

(* End nameless_include. *)

(* Include nameless_include. *)

(* Definition myproc (body : string) : string := *)
(*   if Stdlib.op_eqeq (CoqOfOCaml.String.length body) 0 then *)
(*     "" *)
(*   else *)
(*     (* ❌ Use a trivial matching for the `with` clause, like: *) *)
(*     typ_with_with_non_trivial_matching. *)

(* Definition split_n : string -> list string := *)
(*   Stdlib.String.split_on_char "010" % char. *)

(* Definition extract_content1 (body : string) : string := *)
(*   let fpp := split_n body in *)
(*   let fp2 := List.map myproc fpp in *)
(*   Stdlib.String.concat "" fp2. *)

(* Definition extract_content (body : string) : Lwt.t string := *)
(*   Lwt._return (extract_content1 body). *)

(* Definition send : client_t -> string -> string -> unit -> Lwt.t string := *)
(*   send_raw_k *)
(*     (fun (function_parameter : *)
(*       sum Ezcurl_core.response (Curl.curlCode * string)) => *)
(*       match function_parameter with *)
(*       | Stdlib.Ok {| Ezcurl_core.response.body := body |} => *)
(*         extract_content body *)
(*       | Stdlib.Error (_code, e_value) => Lwt.fail_with e_value *)
(*       end). *)
