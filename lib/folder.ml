(*
folder

   take inputs :
   grammar : A
   Previous Results : D initially, Initial example : B
   New Example : C
   Created new output D.
   Test D. If good, repeat loop with new D. Othewise feed error back to create new D up to 3 times.
   start with this following code and rewrite it to suit our needs.
*)

let rec fold_left op acc = function
  | []   -> acc
  | h :: t -> fold_left op (op acc h) t
                
