open Openai
open Lang_model

type (* 't_key, *) t_key_string = string
type (* url 't_address, *) t_address_string = string
type (* enume of available 't_model, *) t_model_name = string
type (* 't_temperature, *) t_temperature_float = Float.t
type (* 't_max_tokens, *) t_max_tokens_int = Int.t
type (* assistent prompt 't_system_content, *) t_system_content_string = string
type (* 't_prompt, *) t_prompt_string = string
type (* 't_response *) t_response_string = string

type client_t =  {
    agt_client :  Client.t option
    ; agt_model : t_model_name
    ; agt_temp : t_temperature_float
    ; agt_tokens : t_max_tokens_int
    ; agt_system_prompt : t_system_content_string
    (* ; agt_user_prompt : t_prompt_string *)
  }

let create_init =
  let agt_temp = 0.0 in
  let agt_tokens = 4000 in
  let agt_system_prompt = "" in
  let agt_model = "" in
  let agt_client = None in
  {
    agt_client;
    agt_model;
    agt_temp;
    agt_tokens;
    agt_system_prompt
  }

let dobind prompt the_client self:string=
  let newprompt =  "Is it because of your mother you say " ^ prompt in
  let result = ref "" in    
  ignore
  @@ Lwt_main.run
  @@ Lwt.bind
       Chat_completion.(
    send
      the_client
      (*~model:self.agt_model*)
      ~temperature:self.agt_temp
      ~max_tokens:self.agt_tokens
      ~messages: [ { role = `System; content = self.agt_system_prompt }
                 ; { role = `User; content = newprompt }
      ]
      ())
       (Lwt_io.printlf "res: %s");
  !result

class open_ai_lang_model : [
          client_t,
          (* 't_key, *) t_key_string,
          (* url 't_address, *) t_address_string,
          (* url 't_model, *) t_model_name,
          (* 't_temperature, *) t_temperature_float ,
          (* 't_max_tokens, *) t_max_tokens_int ,
          (* 't_system_content, *) t_system_content_string,
          (* 't_prompt, *) t_prompt_string,
          (* 't_response *) t_response_string
        ] lang_connection_type  = object 
  method lang_init  () :'t_connection =   create_init

  method lang_auth  (self: 't_connection) (_ (*key*) :'t_key):'t_connection = self 
  method lang_open   (self: 't_connection) (
             _ (*address*): 't_address) = self
  method lang_set_temp  (self: 't_connection) (
             _ (*temp*) :'t_temperature) = self
  method lang_set_model (self: 't_connection) (_ (*model*): 't_model) = self
  method lang_set_max_tokens (self: 't_connection) (_ (*token*): 't_max_tokens) = self
  method lang_set_system_content (self: 't_connection) (_ (*prompt*): 't_prompt)=  self
  method lang_prompt
           (self : 't_connection)
           (prompt:'t_prompt) :'t_response=
    match self.agt_client with
    | None ->""
    | Some the_client ->
       let res = (dobind prompt the_client self) in   "TOODO" ^ res
 
end

