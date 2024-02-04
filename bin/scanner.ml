
(* A function that returns the last line of a file that matches a given pattern *)
let last_line_matching ic : string =
  let line = ref "" in
  try
    while true; do
      line := input_line ic
    done;
    ! line
  with End_of_file ->
    close_in ic;
    (print_endline ("DEBUG4:" ^  !line));
    !line

    (* let result = if Str.string_match pattern line 0 then Some line else None in *)
    (* match last_line_matching pattern ic with *)
    (* | Some _ as r -> r *)
    (* | None -> result *)


(* A regular expression that matches a (filename:linenumber) pair
   let pair_pattern = Str.regexp "([^:]+):\\([0-9]+\\)"
  
 *)




(* A function that traverses a directory and prints the last line matching the pair pattern for each file *)
let traverse_and_print path =
  (print_endline ("DEBUG0:" ^  path));
  let rec aux dir =
    let entries = Sys.readdir dir in
    Array.iter (fun entry ->
        let full_path = Filename.concat dir entry in
                
        if Sys.is_directory full_path then
          (
            (print_endline ("DEBUG1:" ^  full_path));
            aux full_path
          )
        else
          (*Unix.file_kind  *)
          let fs = Unix.lstat full_path in
          match fs.st_kind with
          | S_CHR -> (print_endline ("DEBUG2 char" ^  full_path));
          | S_SOCK -> (print_endline ("DEBUG2 char"^  full_path));
          | S_BLK -> (print_endline ("DEBUG2 block"^  full_path));
          | S_FIFO -> (print_endline ("DEBUG2 FIFO"^  full_path));
          | S_LNK -> (print_endline ("DEBUG2 LINK"^  full_path));
          | S_DIR -> (print_endline ("DEBUG2 DIR" ^  full_path));
          | S_REG ->
             if Sys.file_exists  full_path then
               (* (print_endline ("DEBUG2 " ^  full_path)); *)
             let ic = open_in full_path in
             let ll =  last_line_matching ic
             in
             (print_endline ("DEBUG2 " ^  full_path  ^ " LL " ^ ll));
                
      ) entries
  in
  aux path

let input_files = ref []

let anon_fun filename =
  input_files := filename::!input_files

let () =

  let start = ref "" in
  let help_str = "test" in
  let opts = [
    "-s", Arg.Set_string start, "startdir";
  ] |> Arg.align in

  Arg.parse opts anon_fun help_str;
  Printf.printf "DEBUG %s\n" !start;
  traverse_and_print !start
