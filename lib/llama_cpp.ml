open Ppx_yojson_conv_lib.Yojson_conv.Primitives
open Lang_model
include Yojson.Safe

let json_to_field_opt name f o =
  ( name
  , match o with
    | Some v -> f v
    | None -> `Null )
;;

type client_t =
  { 
   mutable url : string
  ; c : Curl.t
  }

let create_client  =
  let base_url = "http://localhost:8080" in
  {  url = base_url; c = Ezcurl_lwt.make () }
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

  
let send_raw_k
  k
  (client : client_t)
  (prompt : string)
  (grammar : string)  
  ()
  =
  (* print_endline ( "DEBUG:" ^ prompt );  *)
  let body =
    List.filter
      (fun (_, v) -> v <> `Null)
      [ "n_predict", `Int 128
      ; "prompt",`String prompt
      ; "grammar",  `String grammar
      ]
    |> fun l -> Yojson.Safe.to_string (`Assoc l)
  in
  let headers =
    [ "content-type", "application/json"
    ]
  in
  let endpoint = "/completion" in
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

type llama_cpp_timings =
  { 
    predicted_ms: float option [@yojson.option]
  ;predicted_n:int option [@yojson.option]
  ;predicted_per_second:float option [@yojson.option]
  ;predicted_per_token_ms:float option [@yojson.option]
  ;prompt_ms:float option [@yojson.option]
  ;prompt_n:int option [@yojson.option]
  ;prompt_per_second:float option [@yojson.option]
  ;prompt_per_token_ms:float option [@yojson.option]
  } [@@deriving yojson]

type llama_cpp_generation_settings =
  {
    dynatemp_exponent:float option [@yojson.option]
  ; dynatemp_range:float option [@yojson.option]
  ; frequency_penalty:float  option [@yojson.option]
  ; grammar:string
  ; ignore_eos:bool option [@yojson.option]
  ; logit_bias: (int list)  option [@yojson.option]
  ; min_p :float option [@yojson.option]
  ; mirostat:int option [@yojson.option]
  ; mirostat_eta:float option [@yojson.option]
  ; mirostat_tau:float option [@yojson.option]
  ; model:string     
  ; n_ctx: int option [@yojson.option]
  ; n_keep: int option [@yojson.option]
  ; n_predict: int option [@yojson.option]
  ; n_probs: int option [@yojson.option]
  ; penalize_nl: bool option [@yojson.option]
  ; penalty_prompt_tokens: (string list) option [@yojson.option]
  ; presence_penalty: float option [@yojson.option]
  ; repeat_last_n: int option [@yojson.option]
  ; repeat_penalty: float option [@yojson.option]
  ; seed: int option [@yojson.option]
  ; stop: (string list) option [@yojson.option]
  ; stream : bool 
  ; temp: float option [@yojson.option]
  ; tfs_z: float option [@yojson.option]
  ; top_k: int option [@yojson.option]
  ; top_p: float option [@yojson.option]
  ; typical_p: float option [@yojson.option] 
  ; use_penalty_prompt_tokens: bool option [@yojson.option]
  }
[@@deriving yojson]
  
type llama_cpp_response =
  {
    content: string
  ; generation_settings: llama_cpp_generation_settings option [@yojson.option]
  ; model : string option [@yojson.option]
  ; prompt : string 
  ; slot_id: int option [@yojson.option]
  ; stop : bool option [@yojson.option]
  ; stopped_eos : bool option [@yojson.option]
  ; stopped_limit : bool option [@yojson.option]
  ; stopped_word : bool option [@yojson.option]
  ; stopping_word : string    option [@yojson.option]  
  ;timings : llama_cpp_timings option [@yojson.option]
  ;tokens_cached:int option [@yojson.option]
  ;tokens_evaluated:int option [@yojson.option]
  ;tokens_predicted:int option [@yojson.option]
  ;truncated:bool option [@yojson.option] 
  }
[@@deriving yojson]

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
      print_endline ( "JSON:" ^ body );  
      let json = Yojson.Safe.from_string body in

      let record_opt = (llama_cpp_response_of_yojson json) in
      record_opt.content
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

type (* 't_key, *) t_key_string = string
type (* url 't_address, *) t_address_string = string

type (* 't_temperature, *) t_temperature_float = Float.t
type (* 't_max_tokens, *) t_max_tokens_int = Int.t
type (* assistent prompt 't_system_content, *) t_system_content_string = string
type (* 't_prompt, *) t_prompt_string = string
type (* 't_response *) t_response_string = string


let dobind1 prompt the_client grammar  =
  let newprompt = prompt in
  let%lwt result = send the_client newprompt grammar () in
  Lwt.return result

let dobind prompt the_client  grammar =
  let result = Lwt_main.run (dobind1 prompt the_client grammar) in
  result
    
    
class llama_cpp_lang_model  = object (* (self) *)
  inherit [client_t] openai_like_lang_model
  method  lang_init  () : client_t Lang_model.client_t  =
    let client = create_client  in
    mk_client_t client

  method  lang_auth  (self: 't_connection) (_ (*key*) :'t_key):'t_connection = self 
  method  lang_open   (self: 't_connection) (url (*address*): 't_address) =
    self.agt_driver.url <- url;
    self
  method  lang_set_model (self: 't_connection) (_ : 't_model) =
    self
  method  lang_set_grammar (self: 't_connection) (grammar: 't_grammar_string) =
    self.agt_grammar <- grammar;
    self
    
  method  lang_set_temp  (self: 't_connection) (_ (*temp*) :'t_temperature) = self

  method  lang_set_max_tokens (self: 't_connection) (_ (*token*): 't_max_tokens) = self
  method  lang_set_system_content (self: 't_connection) (_ (*prompt*): 't_prompt)=  self
  method  lang_prompt
           (connection : 't_connection)
           (prompt:'t_prompt) :'t_response=
    let connection1 =  connection.agt_driver in
    let res:string = (dobind prompt connection1 connection.agt_grammar) in  
    " Result: " ^ res
end

module LlamaCppClientModule
         ( A: LLMClientModule
           with type t =
                       llama_cpp_lang_model
         )  = struct
  let init ()  = new llama_cpp_lang_model
end

module LlamaCppClientModule2 = struct
  let init ()  = new llama_cpp_lang_model
end

module type LLMClientModuleLlamaCpp2 = sig
  val init : unit -> llama_cpp_lang_model      
end





