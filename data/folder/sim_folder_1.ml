type input = {
  grammar : string;
  prev_results : string;
  new_example : string;
}

let merge_workflows input =
  let {grammar; prev_results; new_example} = input in
  let rec fold_left op acc = function
    | []   -> acc
    | h :: t -> fold_left op (op acc h) t
  in
  (* let base_case acc = acc in *)
  let operation str accumulator =
    let result = LanguageModel.generate ~grammar ~previous:accumulator ~new_example:str in
    if TestResult.is_good result then result else accumulator
  in
  fold_left operation prev_results [new_example]
