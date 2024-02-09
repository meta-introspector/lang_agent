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

(* type client_t =  { *)
(*     agt_client :  Client.t option *)
(*     ; agt_temp : t_temperature_float *)
(*     ; agt_tokens : t_max_tokens_int *)
(*     ; agt_system_prompt : t_system_content_string *)
(*     (\* ; agt_user_prompt : t_prompt_string *\) *)
(*   } *)

(* let create_init = *)
(*   let agt_temp = 0.0 in *)
(*   let agt_tokens = 4000 in *)
(*   let agt_system_prompt = "" in *)
(*   let agt_client = None in *)
(*   { *)
(*     agt_client; *)
(*     agt_temp; *)
(*     agt_tokens; *)
(*     agt_system_prompt *)
(*   } *)

let dobind prompt the_client self:string=
  let newprompt =  prompt in
  let result = ref "" in    
  ignore
  @@ Lwt_main.run
  @@ Lwt.bind
       Chat_completion.(
    send
      the_client
      ~temperature:self.agt_temp
      ~max_tokens:self.agt_tokens
      ~messages: [ { role = `System; content = self.agt_system_prompt }
                 ; { role = `User; content = newprompt }
      ]
      ())
       (Lwt_io.printlf "res: %s");
  !result

(* [
          client_t,
          (* 't_key, *) t_key_string,
          (* url 't_address, *) t_address_string,
          (* url 't_model, *) t_model_name,
          (* 't_temperature, *) t_temperature_float ,
          (* 't_max_tokens, *) t_max_tokens_int ,
          (* 't_system_content, *) t_system_content_string,
          (* 't_prompt, *) t_prompt_string,
          (* 't_response *) t_response_string
  ] lang_connection_type*)


    
class  open_ai_lang_model  = object (* (self) *)
  inherit [Client.t] openai_like_lang_model
  method  lang_init  () : Client.t Lang_model.client_t  =
    let client = Client.create_custom "no_url_yet" "no_api_key_yet" "no_model" in
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
    let res = (dobind prompt connection1 connection ) in  
    "Response" ^ prompt ^ " Res "^ res
end


module OpenAIClientModule
         ( A: LLMClientModule
           with type t =
                       open_ai_lang_model
         )  = struct
  let init ()  = new open_ai_lang_model   
end

module OpenAIClientModule2 = struct
  let init ()  = new open_ai_lang_model   
end



