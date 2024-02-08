(* Define the class type for LANGUAGEMODEL *)
class type lang_model_type =
  object
    (* A method that generates text given a prompt and a style *)
    method generate_text : string -> string -> string
    (* A method that completes a prompt given a style *)
    method complete_prompt : string -> string -> string
    (* A method that answers a question given a context and a style *)
    method answer_question : string -> string -> string -> string
    (* An attribute that stores the API key *)
    val api_key : string
  end


