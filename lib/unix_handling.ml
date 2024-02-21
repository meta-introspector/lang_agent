let run_cmd args =
  let lines = ref [] in
  let cmd = String.concat " " args in
  Printf.printf "Cmd: %s\n" cmd;
  flush stdout;
  let inp = Unix.open_process_in cmd in  
  try
    while true do
      lines := (input_line inp) :: !lines
    done;
    (*!lines*)
    ()
      
  with End_of_file -> 
    let _ = Unix.close_process_in inp in
    (*!lines*)
    ()
