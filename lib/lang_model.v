(*
Intuitional language model
everyone creates different versions of this for themselves.

this is mine that i will create mappings onto other systems with it.

pair_Type is  similar to total2 of unimath

 *)

(*Unimath*)
Definition UU := Type.
Inductive empty : UU := .

Notation "∅" := empty.
Notation "'λ' x .. y , t" := (fun x => .. (fun y => t) ..)
  (at level 200, x binder, y binder, right associativity).
  (* type this in emacs in agda-input method with \lambda *)
Record total2 { T: UU } ( P: T -> UU ) := tpair { pr1 : T; pr2 : P pr1 }.
Notation "'∑'  x .. y , P" := (total2 (λ x, .. (total2 (λ y, P)) ..))
  (at level 200, x binder, y binder, right associativity) : type_scope.
  (* type this in emacs in agda-input method with \sum *)
Reserved Notation "A × B" (at level 75, right associativity).
Definition dirprod (X Y : UU) := ∑ x:X, Y.
Notation "A × B" := (dirprod A B): type_scope.


(** The one-element type *)

Inductive unit : UU :=
    tt : unit.

(** The two-element type *)

Inductive bool : UU :=
  | true : bool
  | false : bool.



Inductive coprod (A B:UU) : UU :=
| ii1 : A -> coprod A B
| ii2 : B -> coprod A B.


Arguments tpair {_} _ _ _.
Arguments pr1 {_ _} _.
Arguments pr2 {_ _} _.





Definition dirprod_pr1 {X Y : UU} := pr1 : X × Y -> X.
Definition dirprod_pr2 {X Y : UU} := pr2 : X × Y -> Y.


Reserved Notation "x ,, y" (at level 60, right associativity).
Notation "x ,, y" := (tpair _ x y).
Definition make_dirprod {X Y : UU} (x:X) (y:Y) : X × Y := x,,y.

(**)
Class
  pair_type (  t_a:Type)
  ( t_b: Type ).

Class Protocol_type 
  (t_state_machine: Type) :=
  {
    state_machine  :  unit -> t_state_machine
  }.

Class  Network_type
  ( t_address:Type)
  ( t_connection:Type) := {
    net_connect  : t_address -> t_connection
  }.

Class  auth_type (t_key:Type)
  (t_auth:Type):=
  {
    authenticate  : t_key -> t_auth
  }.
    
Class  Connection_type
  (t_address:Type)
  (t_key:Type)
  (t_auth:Type)
  (t_state_machine:Type)
  (t_connection:Type) :=
  {
    ct_connect  :  t_address -> t_connection
  }.

Class connection_type2  (t_auth:Type)  (t_network:Type)
  (t_protocol:Type)  (t_connection:Type)  := 
  {
    connect  : t_auth -> t_network ->t_protocol -> t_connection
  }.
    
Class archtype_type
  ( t_name:Type)
  (t_attributes:Type)
  (t_stories:Type)
  (t_embodiments:Type)
  (t_identity:Type)
  := {  }.

Class heros_journey_type(    t_call_to_adventure:Type)
  (t_refusal:Type)
  (t_resurrection:Type)
  (*fill in the rest*)
  := { 
  }.

Class introspector_prompt_model
  (  t_context:Type)
  (t_environment:Type)
  (t_goal:Type)  (t_language:Type)  (t_state_machine:Type)  (t_protocol:Type)  (t_project:Type)  (t_notations:Type)  (t_error_retry_handler:Type)  (t_logging_handler:Type)  (t_introspection_visitor:Type)
  (t_short_term_memory:Type)  (t_long_term_memory:Type)  (t_lemmas:Type)  (t_proofs:Type)
(t_sets:Type)(t_types:Type)(t_propositions:Type)
(t_universes:Type)(t_objects:Type)
(t_validators:Type)(t_grammars:Type)
(t_prelude:Type)
(t_string:Type)
  := {
    prompt_type  : (*t_auth -> t_network*) t_protocol -> t_string
  }.
    

Class class_type_result
  (t_name:Type)   
  (t_param:Type)
  (t_params:Type)
  (t_method:Type)
  (t_methods:Type)
  (t_method_param:Type)
  (t_type:Type)
  ( t_val:Type)
  ( t_vals:Type) 
   :=
     {
       begin_type :   t_name ->   t_params ->   t_methods ->   t_vals ->   t_type (*result*);   
       begin_method :   t_name ->   t_params ->   t_method (*result*);
       add_method :   t_methods ->   t_method ->   t_methods (*result*);
       begin_val :   t_name ->   t_type ->   t_val (*result*);
       add_val :   t_vals ->   t_val ->   t_vals (*result*)
     }.
      
Class model_params
  ( t_string:Type)
  ( t_prompt:Type)
    ( t_nat:Type)
    ( t_real:Type)
    ( t_result:Type)
    :=
 {
   request :
    (*prompt*)  t_prompt ->
    (*tokens*)  t_nat ->
    (*temp   *) t_real ->
    (*top_k*)   t_nat ->
    (*top_n*)   t_nat ->
    (*output*)  t_result
}.

Class lang_model
  (t_connection:Type)
  (t_model_params:Type)
  (t_style:Type)
  (t_prompt:Type)
  (t_result:Type)
   := {
(* A method that generates text given a prompt and a style *)
   generate_text : t_connection -> t_model_params -> t_style -> t_prompt -> t_result

 }.

(* (\* A method that completes a prompt given a style *\) *)
(* method complete_prompt : string -> string -> string *)
(* (\* A method that answers a question given a context and a style *\) *)
(* method answer_question : string -> string -> string -> string *)
(* method  get_tag: unit -> string *)



(* create a ocaml abstract typeclass of mythos *)
Class mythos
  (    t_region:Type)
  (t_epoch:Type)
  (t_language:Type)
  (t_archtypes:Prop × Prop)
  (t_names:Type)(t_prompt_type:Type)
  (t_response_type:Type   )
 := {
       invoke : t_prompt_type -> t_response_type
}.

(*
  now create a mythos of athena please  
 *)

Class archtype_warrior := { }.
Class archtype_woman := { }.

(*
   (archtype_warrior:Type)
  (archtype_woman:Type )
 *)
Global Instance   t_archtype_athena :  pair_type archtype_warrior archtype_woman :=  {  }.


Definition   t_archtype_athena2 := make_dirprod  archtype_warrior  archtype_woman.

Class  t_names_nil := {  }.
Class  t_region_greece := {  }.
Class  t_epoch_classical := {  }.
Class t_language_classical_greek := {}.
Inductive string :=
  | SomeString.

(* Inductive  t_archtype_athena2 : Type *)
(*   := Athena t_archtype_athena. *)

Instance  greek_athena_mythos :
  (*
(t_region_greece:Type)(t_epoch_classical:Type)(t_language_classical_greek:Type)(t_archtype_athena:Type)(t_names_nil:Type)(string:Type)string
  )*)
  mythos
    t_region_greece
    t_epoch_classical
    t_language_classical_greek
    t_archtype_athena2
    t_names_nil
    string
    string
    
  := {
(* (self)
  This is a mythos of Athena, the goddess of wisdom
 and warfare in Greek mythology.
 *)
    invoke (prompt:string) := SomeString
      (* "Is it because of your mother you say " ^ prompt *)
}.


Require Coq.extraction.Extraction.
Extraction Language Haskell.
Extraction "test.hs" greek_athena_mythos .

