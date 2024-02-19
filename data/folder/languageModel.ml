(* let generate_language_model ?grammar ?previous accumulator str = None *)
type grammar = int
type previous = string


let generate ~(grammar:string) ~(previous:string) (*accumulator*) ~(new_example:string) =
  let result =  grammar ^ previous ^ new_example in
  (* Process the result further or return it *)
  result




(* declare a stub for this ocaml code *)
(* let result = LanguageModel.generate ~grammar ~previous:accumulator ~new_example:str in *)
