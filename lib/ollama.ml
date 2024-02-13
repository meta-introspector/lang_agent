(* open Lwt.Syntax *)
(* open Yojson *)
(* open Printexc *)
open Ppx_yojson_conv_lib.Yojson_conv.Primitives
open Lang_model
include Yojson.Safe

(*
   parts from 
   
https://github.com/janestreet/ppx_yojson_conv_lib
   and OpenAI-OCaml
   https://github.com/meta-introspector/openai-ocaml
*)


let json_to_field_opt name f o =
  ( name
  , match o with
    | Some v -> f v
    | None -> `Null )
;;

type client_t =
  { mutable model : string
  ; mutable url : string
  ; c : Curl.t
  }

let create_client model =
  let base_url = "http://localhost:11434" in
  { model; url = base_url; c = Ezcurl_lwt.make () }
;;

type role =
  [ `System
  | `User
  | `Assistant
  ]

let yojson_of_role = function
  | `System -> `String "system"
  | `User -> `String "user"
  | `Assistant -> `String "assistant"
;;

type message =
  { content : string
  ; role : role
  }
[@@deriving yojson_of]
  
(** raw API request:
 * @param k for continuation to avoid redefining labeled parameters
*)

let send_raw_k
  k
  (client : client_t)
  (model )
  (prompt : string)  
  ()
  =
  (* print_endline ( "DEBUG:" ^ prompt );  *)
  let body =
    List.filter
      (fun (_, v) -> v <> `Null)
      [ "model", `String model
      ; "prompt",`String prompt
      ]
    |> fun l -> Yojson.Safe.to_string (`Assoc l)
  in
  let headers =
    [ "content-type", "application/json"
    ]
  in
  let endpoint = "/api/generate" in
  let%lwt resp =
    Ezcurl_lwt.post
      ~client:client.c
      ~headers
      ~content:(`String body)
      ~url:(client.url ^ endpoint)
      ~params:[]
      ()
  in
  k resp

type ollama_response =
  { model : string
  ; created_at : string
  ; response : string
  ; isdone : bool [@key "done"]
  ; context: (int list) option[@yojson.option]
  ; total_duration:int option[@yojson.option]
  ; load_duration: int option[@yojson.option]
  ; prompt_eval_count: int option[@yojson.option]
  ; prompt_eval_duration : int option[@yojson.option]
  ; eval_count: int option[@yojson.option]
  ; eval_duration : int option[@yojson.option]
  }
[@@deriving yojson]

(* open Ppx_yojson_conv_lib.Yojson_conv.Primitives *)

let contains s1 s2 =
  let re = Str.regexp_string s2
  in
  try ignore (Str.search_forward re s1 0); true
  with Not_found -> false

let myproc (body:string):string =
  if contains body "error"  then
    (print_endline ( "DEBUGBODY:" ^ body ) );

  if (String.length body ) == 0 then ""
  else
    try
      let json = Yojson.Safe.from_string body in
      let record_opt = (ollama_response_of_yojson json) in
      record_opt.response        
    with
    | Ppx_yojson_conv_lib.Yojson_conv.Of_yojson_error (loc, exn) ->
      Printf.eprintf "Loc at  %s\n" (Printexc.to_string loc);
      Printf.eprintf "Error at  %s\n" (Yojson.Safe.show exn); "ERROR2"
  (* | exn -> *)
  (*   Printf.eprintf "Unexpected error: %s\n" (   to_string exn); "errorr2" *)


    
let split_n = String.split_on_char '\n'
    
let extract_content1 body = 
  let fpp =  (split_n body ) in
  let fp2 = List.map myproc fpp  in
  String.concat "" fp2
let extract_content body = 
  Lwt.return (extract_content1 body)

let send =
  send_raw_k
  @@ function
  | Ok { body; _ } -> extract_content body
  | Error (_code, e) -> Lwt.fail_with e


(*open ai compatible api*)

type (* 't_key, *) t_key_string = string
type (* url 't_address, *) t_address_string = string
type (* enume of available 't_model, *) t_model_name = string
type (* 't_temperature, *) t_temperature_float = Float.t
type (* 't_max_tokens, *) t_max_tokens_int = Int.t
type (* assistent prompt 't_system_content, *) t_system_content_string = string
type (* 't_prompt, *) t_prompt_string = string
type (* 't_response *) t_response_string = string

(* let dobind2 prompt the_client model= *)
(*   let newprompt =  prompt in *)
(*   let result = ref "" in     *)
(*   ignore *)
(*   @@ Lwt_main.run *)
(*   @@ Lwt.bind( *)
(*     send *)
(*       the_client *)
(*       model *)
(*       newprompt *)
(*       () *)
(*        ); *)
(*   (Lwt.return (result) ) *)
(*   !result *)

let dobind1 prompt the_client model =
  let newprompt = prompt in
  let%lwt result = send the_client model newprompt () in
  Lwt.return result

let dobind prompt the_client model =
  let result = Lwt_main.run (dobind1 prompt the_client model) in
  result
    
    
class  ollama_lang_model  = object (* (self) *)
  inherit [client_t] openai_like_lang_model
  method  lang_init  () : client_t Lang_model.client_t  =
    let client = create_client   "no_model" in
    mk_client_t client

  method  lang_auth  (self: 't_connection) (_ (*key*) :'t_key):'t_connection = self 
  method  lang_open   (self: 't_connection) (url (*address*): 't_address) =
    self.agt_driver.url <- url;
    self
  method  lang_set_model (self: 't_connection) (model: 't_model) =
    self.agt_driver.model <- model;
    self  
  method  lang_set_temp  (self: 't_connection) (_ (*temp*) :'t_temperature) = self

  method  lang_set_max_tokens (self: 't_connection) (_ (*token*): 't_max_tokens) = self
  method  lang_set_system_content (self: 't_connection) (_ (*prompt*): 't_prompt)=  self
  method  lang_prompt
           (connection : 't_connection)
           (prompt:'t_prompt) :'t_response=
    let connection1 =  connection.agt_driver in
    let model =  connection1.model in    
    let res:string = (dobind prompt connection1 model) in  
    " Result: " ^ res
end


module OllamaClientModule
         ( A: LLMClientModule
           with type t =
                       ollama_lang_model
         )  = struct
  let init ()  = new ollama_lang_model
end

module OllamaClientModule2 = struct
  let init ()  = new ollama_lang_model
end

module type LLMClientModuleOllama2 = sig
  val init : unit -> ollama_lang_model      
end





