(* Require Import MirrorSolve.FirstOrder. *)
(* Require Import MirrorSolve.BV. *)
(* Require Import MirrorSolve.SMT. *)
(* Require Import MirrorSolve.UF. *)
(* Require Import MirrorSolve.FOList. *)
(* Require Import MirrorSolve.HLists. *)

(* Import HListNotations. *)

(* Require Import Coq.Strings.String. *)

(* Require Import MirrorSolve.Reflection.Core. *)
(* Require Import MirrorSolve.Reflection.FM. *)

(* Require Import Coq.ZArith.BinInt. *)
(* Require Import MirrorSolve.Automation.Equations. *)

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
Notation "'∑u'  x .. y , P" := (total2 (λ x, .. (total2 (λ y, P)) ..))
  (at level 200, x binder, y binder, right associativity) : type_scope.
  (* type this in emacs in agda-input method with \sum *)
Reserved Notation "A ×u B" (at level 75, right associativity).
Definition dirprod (X Y : UU) := ∑u x:X, Y.
Notation "A ×u B" := (dirprod A B): type_scope.
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
Definition dirprod_pr1 {X Y : UU} := pr1 : X ×u Y -> X.
Definition dirprod_pr2 {X Y : UU} := pr2 : X ×u Y -> Y.
Reserved Notation "x ,,u y" (at level 60, right associativity).
Notation "x ,,u y" := (tpair _ x y).
Definition make_dirprod {X Y : UU} (x:X) (y:Y) : X ×u Y := x,,uy.

(*
  typeclass
 *)
Class  pair_type (t_a:Type)( t_b: Type ).
Inductive string :=
  | SomeString.

  (*Please help finish this proof
   what are the next tactics we can use
   how can we resolve the error?*)
  Set Printing All.
  Set Typeclasses Debug.
Class Protocol_type   (t_state_machine: Type) :=  {    state_machine  :  unit -> t_state_machine  }.
Inductive Protocols {t_state_machine: Type} : Type :=| Pt_state_machine (x: t_state_machine) .
Inductive StateMachine  : Type :=| St_start| St_step| St_end.
Inductive Protocols2 : Type := | Pt_state_machine2 (c :StateMachine ) .
Definition newstate := St_start.
Definition newstate2 := forall _ : unit, Protocols2.
Definition newstate3 (u : unit) : Protocols2 :=
  match u with
  | tt => Pt_state_machine2 St_start
  end.

#[export] Instance t_Protocol :
  Protocol_type Protocols2 :=
    {
      state_machine := newstate3
    }.

Class  Network_type  ( t_address:Type) ( t_connection:Type) :=
  {
    net_connect  : t_address -> t_connection;
    net_tracert  : t_address -> t_connection;
    net_ping  : t_address -> t_connection;
    net_whois  : t_address -> t_connection;
    net_tcpdump  : t_address -> t_connection;
    net_proxy  : t_address -> t_connection;
    net_mitmproxy  : t_address -> t_connection;
    net_subnet  : t_address -> t_connection;                                        
  }.

Record  TNetwork_type   :=  {
    t_address:Type;
    t_connection:Type
  }.
Inductive  TNetwork_type2 :=
| TNetwork_type2a2 ( t_address:Type)(t_connection:Type)
| TNetwork_type2b2 ( t_address:Type).

Inductive  Socket :=
| FileHandle
(*
  Sys.Socket
 *).
  
Inductive  TNetwork_type3 :=
| TNetwork_type2a ( t_address:string)(t_connection:Socket)
| TNetwork_type2b ( t_address:string).


(*Create a coq inductive type and record type to implement for the following type class *)
Class auth_type (t_key:Type) (t_auth:Type):=
  {
    authenticate  : t_key -> t_auth;
    auth_share  : t_key ;
    auth_generate  : t_key ;
    auth_revoke  : t_key ;
    auth_refresh  : t_key ;                               
  }.

Record  TAuth_type   :=  {
    t_key:Type;
    t_auth:Type
  }.
    
Class  Connection_type
  (t_address:Type)
  (t_key:Type)
  (t_auth:Type)
  (t_state_machine:Type)
  (t_connection:Type) :=
  {
    ct_connect  :  t_address -> t_connection;
    ct_state  :  t_connection -> t_state_machine;  
    ct_disconnect  :  t_address -> t_connection
  }.

Record  TConnection_type   :=  {
    ct_key:Type;
    ct_auth:Type;
    ct_address:Type;
    ct_state_machine:Type;
  }.
    
Class connection_type2  (t_auth:Type)  (t_network:Type)
  (t_protocol:Type)  (t_connection:Type)  := 
  {
    connect  : t_auth -> t_network ->t_protocol -> t_connection
  }.

Record  TConnection_type2   :=  {
    ct2_auth:Type;
    ct2_network:Type;
    ct2_protocol:Type;
    ct2_connection:Type;   
  }.

Class introspector_prompt_model
  (t_language:Type)
  (t_project:Type) :={
    prompt : string
  }.

Class introspector_network_model
  (t_state_machine:Type)
  (t_protocol:Type)
  := {
    prompt_type  : (*t_auth -> t_network*) t_protocol -> string
  }.

  Class introspector_event_model
  (t_error_retry_handler:Type)
  (t_logging_handler:Type)
  (t_introspection_visitor:Type)
    := {
      event :string
  }.

  Class introspector_memory_model
  (t_short_term_memory:Type)
  (t_long_term_memory:Type)
    := {
      memory :string
  }.

  Class introspector_proof_model
    (t_prelude:Type)
    (t_context:Type)
    (t_environment:Type)
    (t_goal:Type)
    (t_notations:Type)
    (t_lemmas:Type)  (t_proofs:Type)
    (t_sets:Type)(t_types:Type)(t_propositions:Type)
    (t_universes:Type)(t_objects:Type)
    (t_validators:Type)
    := {
      proof :string
    }.

  Class introspector_grammar_model
    (t_grammars:Type)
    := {
      grammar: string
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
  (t_author:Type)
  (t_mythos:Type)
  (t_archetypes:Type)
  (t_authority:Type)
  (t_authorization:Type)
  (t_region:Type)
  (t_epoch:Type)
  (t_language:Type)
  (t_emotions:Type)

  (t_names:Type)(t_prompt_type:Type)
  (t_response_type:Type   )
  := {
    create :t_author ->t_mythos;
    invoke : t_prompt_type -> t_response_type;
    evoke : t_prompt_type -> t_emotions;
    reify : t_mythos -> t_archetypes;
    (* embody : t_archetypes ->t_mythos; *)
    (* translate : t_mythos -> t_language-> t_language; *)
    
}.

(*
  now create a mythos of athena please  
 *)

Class  archetype_warrior
  (t_warrior:Type)
  (t_monster:Type)
  (t_outcome:Type)

  := {
    fight :  t_warrior ->t_monster -> t_outcome;
  }.
Class archetype_woman
  (t_woman:Type)
  (t_man:Type)
  (t_embryo:Type)
  (t_baby:Type)
  := {
    
    (*simple life*)
    concieve_a : t_woman -> t_embryo;
    
    (*complex life*)
    concieve_s : t_woman ->t_man -> t_embryo;
    carry_baby : t_woman -> t_embryo -> t_baby;
    give_birth : t_woman -> t_baby
  }.

(*
   (archetype_warrior:Type)
  (archetype_woman:Type )
 *)
(* Definition warrior_woman := pair_type archetype_warrior archetype_woman. *)



(* Definition   t_archetype_athena2 := make_dirprod  archetype_warrior  archetype_woman. *)

Class  t_names_nil := {  }.
Class  t_region_greece := {  }.
Class  t_epoch_classical := {  }.
Class t_language_classical_greek := {}.

(* Inductive  t_archetype_athena2 : Type *)
(*   := Athena t_archetype_athena. *)

Inductive ArchetypeWarrior :=
  | Cadet
  | Warrior.
Inductive ArchetypeWoman :=
  | Girl
  | Woman.

Inductive ArchetypeWarriorWoman :=
  | WarriorWoman (a:ArchetypeWarrior) (b:ArchetypeWoman).

Inductive GreekAuthors :=
  |OtherAuthor
  |Homer.

Inductive GreekMythos :=
  | OtherMythos
  |MythosOfAthena.

Inductive GreekKings :=
  | OtherKing
  | Pisistratus.

Inductive Authorization :=
| Authorized
| Unauthorized.

Inductive Emotions :=
|Happy
|Joy
|Sad.
  
Record total3 { T: Type }{ T2: Type }  := tpair2 { pra1 : T; pra2 : T2 }.

Definition warrior_woman2 := tpair2 ArchetypeWarrior ArchetypeWoman.
Definition warrior_woman := ArchetypeWarriorWoman.


Extraction "mythos.ml" evoke.



#[export]Instance  greek_athena_mythos :
  mythos
    GreekAuthors(*t_author*)
    GreekMythos(*t_mythos*)
    ArchetypeWarriorWoman(*t_archetypes*)
    GreekKings (*(t_authority*)
    Authorization (*(t_authorization*)
    t_region_greece (*t_region:Type*)
    t_epoch_classical  (*t_epoch:Type*)
  t_language_classical_greek(*t_language:Type*)
  Emotions(*t_emotions:Type*)
  t_names_nil(*t_names*)
  string(*t_prompt_type*)
  string(*t_response_type*)
    
  := {
(* (self)
  This is a mythos of Athena, the goddess of wisdom
 and warfare in Greek mythology.
 *)
    invoke (prompt:string) := SomeString;
                                (* "Is it because of your mother you say " ^ prompt *)

    create (auth:GreekAuthors) := MythosOfAthena;
    evoke (a:string) := Joy;
    reify (a :GreekMythos) := WarriorWoman (Warrior) (Woman);
    (* ArchetypeWarriorWoman; *)
    (* embody : t_archetypes ->t_mythos; *)
    (* translate : t_mythos -> t_language-> t_language; *)

}.



(* Instance t_Network_type : Network_type TNetwork_type := { *)

(*   }. *)


Class archetype_type
  (t_name:Type)
  (t_attributes:Type)
  (t_attribute:Type)
  (t_stories:Type)
  (t_story:Type)
  (t_embodiments:Type)
  (t_embodiment:Type)
  (t_identity:Type)
  := {

    (*this identity has this attribute name creating attributes*)
    attribute : t_identity -> t_name -> t_attributes;
    pay_tribute : t_identity -> t_name -> t_attributes;
    pay_homage : t_identity -> t_name -> t_attributes;

    (*this archetype is embodied in this entity creating an embdiment*)
    archetype_instance : t_identity -> t_name -> t_embodiment;
    (*
      this embodied name occurs in story
     *)
    story : t_name -> t_story;
    
    
  }.

(*
The hero's journey is a narrative structure commonly used in storytelling and literature. It involves the main character, the "hero," on a quest to overcome challenges and achieve a goal. The journey typically consists of several stages or phases that the hero must go through.

 *)
(*
  Take this following coq class and extract a list of verbs or morphisms from it and thier parameters.
 *)
Class heros_journey_type
  (t_apotheosis:Type)(* t\_apotheosis: This is the stage where the hero reaches the pinnacle of their abilities or achievements and becomes a legend or an icon in their community or field.*)
  
  (t_risk:Type)
  (t_adventure:Type)  (* `t_call_to_adventure`: This stage marks the beginning of the hero's journey, when the hero receives a call to embark on a quest or mission. This could be a prophecy, a challenge, or an opportunity that the hero cannot ignore.*)
  
  (t_threshold:Type)

  (t_mentor:Type)

  (t_road_of_trials:Type)
  (t_skills:Type)
  (t_wisdom:Type)
  (t_perspective:Type)

  (t_state_machine:Type)
  (t_event:Type)
  (t_call:Type)

  (t_goal:Type)(t_fufillment:Type)
  (t_reward:Type)
  (t_treasure:Type)
  (t_recognition:Type)
  (t_elixer:Type)(* This represents the moment when the hero is rewarded for their efforts and receives some kind of benefit or gain from their journey. This could include a personal transformation or growth, a new skill or ability, or some kind of material reward such as treasure or recognition.
                  *)
    

  (t_narrative:Type)      
  (t_prophecy:Type)
  (t_retry:Type)(*error handling*)
  (t_cave:Type)(*archetype*)
  (t_sword:Type)
  (t_denied:Type)
  (t_failure:Type)
  (t_accepted:Type)
  (t_home:Type)
  (t_challenge:Type)  (t_enemies:Type)  (t_monsters:Type)  (t_obstacles:Type)
  (t_action:Type)
  (t_descent:Type)
(*5. t\_descent:Type
	* This represents the moment when the hero must confront their inner demons or weaknesses and face a crisis or challenge that forces them to question their own values or beliefs.
*)
  (t_decision:Type)
  (t_being:Type)
  (t_hero:Type)
  (t_observation:Type)
  (t_descent:Type)
  (t_world:Type)
  (t_journey:Type)
  (t_situation:Type)
  (t_critical:Type)
  (t_team:Type)
  (t_opportunity:Type) (t_allies:Type)  
  := {
    (*fill in the method signatures*)
    handle_event : t_event;
    recognise : t_recognition;
    recieve : t_call-> t_adventure;
    begin : t_journey -> t_state_machine;
    thrown: t_world -> t_being -> t_event;
    join :  t_team -> t_allies;
    meet :  t_hero -> t_mentor;
    crossing: t_threshold;
    observe: t_observation;
    descend: t_descent; (*LOW*)
    raise: t_apotheosis; (*HIGH*)
    decide: t_decision;
    act: t_action;
    judge: t_action;
    critique: t_action;
    struggle: t_hero -> t_challenge;
    transform: t_hero -> t_challenge;
    take: t_hero -> t_sword;
    gain: t_hero -> t_wisdom;

    refusal: t_hero -> t_call-> t_denied;
    succeed: t_hero -> t_sword;
    return_to: t_hero -> t_home;
    resurrection: t_hero -> t_failure
                  -> t_retry;

  }.



Inductive Diagonalization :=
(* |  Total2 total2  *)
|  Network (a :TNetwork_type)
|  Network2 (a :TNetwork_type2)
|  Network3 (a :TNetwork_type3)
 
|  Auth  (a:TAuth_type  )
| Connection (a:TConnection_type   )
| Connection2  (a : TConnection_type2 )
| Empty (a : empty )
| Unit (unit : UU)
| Bool (bool : UU)
| CoProd (A:UU)(B:UU)
(* | Protocols1 (a:Protocols ) *)
| StateMachine1 (a:StateMachine  )
| Protocols22 (a:Protocols2 )
| String (a:string)
(* | AAthena (a:t_archetype_athena2) *)
.

From MetaCoq.Template Require Import All.

From MetaCoq.Template Require Import Ast Loader TemplateMonad.

          
(* Require Coq.extraction.Extraction.
Extraction Language JSON.
 *)
Extraction Language OCaml.
Unset Extraction Optimize.
(* Recursive Extraction Diagonalization. *)
(* Recursive Extraction net_connect. *)
(* Recursive Extraction state_machine. *)
(* Recursive Extraction TNetwork_type. *)
(* Recursive Extraction connect. *)
(* Recursive Extraction      prompt. *)
(* Recursive Extraction      prompt_type. *)
(* Recursive Extraction      event. *)
(* Recursive Extraction      grammar. *)
(* Recursive Extraction      proof. *)
(* Recursive Extraction  tpair . *)
(* Recursive Extraction  total2 . *)

 
(* Recursive Extraction      begin_type . *)
(* Recursive Extraction  begin_method. *)
(* Recursive Extraction       add_method. *)
(* Recursive Extraction  begin_val. *)
Extraction "test.ml" greek_athena_mythos.

Extraction "begin.ml" begin.
Extraction "mythos.ml" evoke.
Extraction "test_archetype_instance.ml" archetype_instance.

