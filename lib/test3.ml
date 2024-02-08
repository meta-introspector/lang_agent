(* Define a base class with a virtual method *)
class virtual ['a] base = object
  method virtual pointer : 'a -> unit
end;;

(* Define a child class that inherits from base and has a string field *)
class child1 s = object
  inherit [string] base
  val mutable str : string = s
  method pointer x = str <- x
  method get_str = str
end;;

(* Define another child class that inherits from base and has an int field *)
class child2 n = object
  inherit [int] base
  val mutable num : int = n
  method pointer x = num <- x
  method get_num = num
end;;
