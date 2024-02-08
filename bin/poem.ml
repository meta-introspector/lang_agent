
(* Instantiate the class for GPT-4 *)
let gpt4_model = new gpt4 "sk-1234567890abcdef"

(* Use the class instance as a component in a chain *)
let poem_chain = [
  (* A prompt template component that generates a prompt for a poem *)
  (fun () -> "Write a poem about " ^ (gpt4_model#complete_prompt "love" "romantic"));
  (* A model component that uses the GPT-4 class instance to generate a poem *)
  (fun prompt -> gpt4_model#generate_text prompt "poetic");
  (* An output parser component that formats the poem *)
  (fun poem -> poem ^ "\n\n- Generated by Copilot")
]

(* Execute the chain and print the result *)
let poem = List.fold_left (fun input component -> component input) "" poem_chain
print_endline poem
