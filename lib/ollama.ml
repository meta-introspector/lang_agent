(* open Lwt.Syntax *)
(* open Yojson *)
(* open Printexc *)
open Ppx_yojson_conv_lib.Yojson_conv.Primitives

include Yojson.Safe

(*
   parts from 
   
https://github.com/janestreet/ppx_yojson_conv_lib
   and OpenAI-OCaml
   https://github.com/meta-introspector/openai-ocaml
*)


let json_to_field_opt name f o =
  ( name
  , match o with
    | Some v -> f v
    | None -> `Null )
;;

type client_t =
  { model : string
  ; gen_url : string -> string
  ; c : Curl.t
  }
(*
  let ollama_model = "mistral" in
*)
let create_client model =
  let base_url = "http://localhost:11434" in
  { model; gen_url = ( ^ ) base_url; c = Ezcurl_lwt.make () }
;;

type role =
  [ `System
  | `User
  | `Assistant
  ]

let yojson_of_role = function
  | `System -> `String "system"
  | `User -> `String "user"
  | `Assistant -> `String "assistant"
;;

type message =
  { content : string
  ; role : role
  }
[@@deriving yojson_of]
  
(** raw API request:
 * @param k for continuation to avoid redefining labeled parameters
*)

let send_raw_k
  k
  (client : client_t)
  ?(model = "mistral")
  ?(prompt = "tell me a joke")  
  ()
  =
  let body =
    List.filter
      (fun (_, v) -> v <> `Null)
      [ "model", `String model
      ; "prompt",`String prompt
      ]
    |> fun l -> Yojson.Safe.to_string (`Assoc l)
  in
  let headers =
    [ "content-type", "application/json"
    ]
  in
  let endpoint = "/api/generate" in
  let%lwt resp =
    Ezcurl_lwt.post
      ~client:client.c
      ~headers
      ~content:(`String body)
      ~url:(client.gen_url endpoint)
      ~params:[]
      ()
  in
  k resp

type ollama_response =
  { model : string
  ; created_at : string
  ; response : string
  ; isdone : bool [@key "done"]
  ; context: (int list) option[@yojson.option]
  ; total_duration:int option[@yojson.option]
  ; load_duration: int option[@yojson.option]
  ; prompt_eval_count: int option[@yojson.option]
  ; prompt_eval_duration : int option[@yojson.option]
  ; eval_count: int option[@yojson.option]
  ; eval_duration : int option[@yojson.option]
  }
[@@deriving yojson]

(* open Ppx_yojson_conv_lib.Yojson_conv.Primitives *)
       
let myproc (body:string):string =
  if (String.length body ) == 0 then ""
  else    
    try
      let json = Yojson.Safe.from_string body in
      let record_opt = (ollama_response_of_yojson json) in
      (* (print_endline ( "DEBUGBODY:" ^ body ^ "DEBUG2"^   record_opt.response) );        *)
      record_opt.response        
    with
    | Ppx_yojson_conv_lib.Yojson_conv.Of_yojson_error (loc, exn) ->
      Printf.eprintf "Loc at  %s\n" (Printexc.to_string loc);
      Printf.eprintf "Error at  %s\n" (Yojson.Safe.show exn); "error"
  (* | exn -> *)
  (*   Printf.eprintf "Unexpected error: %s\n" (   to_string exn); "errorr2" *)


    
let split_n = String.split_on_char '\n'
    
let extract_content1 body = 
  let fpp =  (split_n body ) in
  let fp2 = List.map myproc fpp  in
  String.concat "" fp2
let extract_content body = 
  Lwt.return (extract_content1 body)
    
  (* Yojson.member "response" *)
  (* recvfrom(6, "63\r\n{\"model\":\"mistral\",\"created_at\":\"2024-01-15T09:32:11.66655731Z\",\"response\":\" common\",\"done\":false}\n\r\n", 16384, 0, NULL, NULL) = 105
     
     
     Yojson.( *)
  (*   member "choices" json *)
  (*   |> function *)
  (*   | [%yojson? [ res ]] -> *)
  (*     res *)
  (*     |> member "message" *)
  (*     |> member "content" *)
  (*     |> to_string *)
  (*     |> String.trim *)
  (*     |> Lwt.return *)
  (*   | _ -> Lwt.fail_with @@ Printf.sprintf "Unexpected response: %s" body) *)

let send =
  send_raw_k
  @@ function
  | Ok { body; _ } -> extract_content body
  | Error (_code, e) -> Lwt.fail_with e

(* (defgroup ollama nil *)
(*   "Ollama client for Emacs." *)
(*   :group 'ollama) *)


(* let ollama_fetch (url, prompt, model) = *)
(*   (\* Define request method, headers, and data *\) *)
(* let url_request_method = "POST" in *)
(* let url_request_extra_headers = ["Content-Type", "application/json"] in *)
(* (\* let url_request_data =  *\) *)
(* (\* `((model = <model>)(prompt = <prompt>)))  *\) *)
(* (\* (\\* Use OCaml's network library to send the request *\\) *\) *)
(* (\* with CurrentBuffer buffer *\) *)
(* (\* when buffer_ready buffer do *\) *)
(* let end_of_headers = "end_of_headers" in *)
(* let response_data = "" *)
(* (\* Process the response data *\) *)
(*   () *)
  
(* (\*   rewrite this into ocaml *\) *)
(* (\*   (let* ((url-request-method "POST") *\) *)
(* (\*          (url-request-extra-headers *\) *)
(* (\*           '(("Content-Type" . "application/json"))) *\) *)
(* (\*          (url-request-data *\) *)
(* (\*           (encode-coding-string *\) *)
(* (\*            (json-encode `((model . ,model) (prompt . ,prompt))) *\) *)
(* (\*            'utf-8))) *\) *)
(* (\*     (with-current-buffer (url-retrieve-synchronously url) *\) *)
(* (\*       (goto-char url-http-end-of-headers) *\) *)
(* (\*       (decode-coding-string *\) *)
(* (\*        (buffer-substring-no-properties *\) *)
(* (\*         (point) *\) *)
(* (\*         (point-max)) *\) *)
(* (\*        'utf-8)))) *\) *)

(* (\* (defun ollama-get-response-from-line (line) *\) *)
(* (\*   (cdr *\) *)
(* (\*    (assoc 'response *\) *)
(* (\*           (json-read-from-string line)))) *\) *)

(* (\* (defun ollama-prompt (url prompt model) *\) *)
(* (\*   (mapconcat 'ollama-get-response-from-line *\) *)
(* (\*              (cl-remove-if #'(lambda (str) (string= str ""))  *\) *)
(* (\*                         (split-string (ollama-fetch url prompt model) "\n")) "")) *\) *)

(* (\* (defun ollama-prompt-line () *\) *)
(* (\*   "Prompt with current word." *\) *)
(* (\*   (interactive) *\) *)
(* (\*   (with-output-to-temp-buffer "*ollama*" *\) *)
(* (\*     (princ *\) *)
(* (\*      (ollama-prompt ollama:endpoint (thing-at-point 'line) ollama:model)))) *\) *)

(* (\* (defun ollama-define-word () *\) *)
(* (\*   "Find definition of current word." *\) *)
(* (\*   (interactive) *\) *)
(* (\*   (with-output-to-temp-buffer "*ollama*" *\) *)
(* (\*     (princ *\) *)
(* (\*      (ollama-prompt ollama:endpoint (format "define %s" (thing-at-point 'word)) ollama:model)))) *\) *)

(* (\* (defun ollama-translate-word () *\) *)
(* (\*   "Translate current word." *\) *)
(* (\*   (interactive) *\) *)
(* (\*   (with-output-to-temp-buffer "*ollama*" *\) *)
(* (\*     (princ *\) *)
(* (\*      (ollama-prompt ollama:endpoint (format "translate \"%s\" to %s" (thing-at-point 'word) ollama:language) ollama:model)))) *\) *)

(* (\* (defun ollama-summarize-region () *\) *)
(* (\*   "Summarize marked text." *\) *)
(* (\*   (interactive) *\) *)
(* (\*   (with-output-to-temp-buffer "*ollama*" *\) *)
(* (\*     (princ *\) *)
(* (\*      (ollama-prompt ollama:endpoint (format "summarize \"\"\"%s\"\"\"" (buffer-substring (region-beginning) (region-end))) ollama:model)))) *\) *)

(* (\* (defun ollama-raw-region () *\) *)
(* (\*   "Exec marked text." *\) *)
(* (\*   (interactive) *\) *)
(* (\*   (with-output-to-temp-buffer "*ollama*" *\) *)
(* (\*     (dotimes (i 8) *\) *)
(* (\*       (princ *\) *)
(* (\*        (format "#+begin_src output\n%s\n#+end_src\n" *\) *)
(* (\* 	       (ollama-prompt ollama:endpoint (format "%s" (buffer-substring (region-beginning) (region-end))) ollama:model)))))) *\) *)


(* (\* (defun ollama-exec-region () *\) *)
(* (\*   "Exec marked text." *\) *)
(* (\*   (interactive) *\) *)
(* (\*   (with-output-to-temp-buffer "*ollama*" *\) *)
(* (\*     (princ *\) *)
(* (\*      (ollama-prompt ollama:endpoint (format "execute \"\"\"%s\"\"\"" (buffer-substring (region-beginning) (region-end))) ollama:model)))) *\) *)


(* (\* (defun ollama-reinterpret-region-insert () *\) *)
(* (\*   "Exec marked text." *\) *)
(* (\*   (interactive) *\) *)
(* (\*   (with-output-to-temp-buffer "*ollama*" *\) *)
(* (\*     (princ (format "#+begin_src input\nrewrite and reinterpret creatively preserving main ideas \"\"\"%s\"\"\"\n#+end_src\n" (buffer-substring (region-beginning) (region-end)))) *\) *)
(* (\*     (princ *\) *)
(* (\*      (format "#+begin_src output\n%s\n#+end_src\n" *\) *)
(* (\*      (ollama-prompt ollama:endpoint (format "rewrite and reinterpret creatively preserving main ideas \"\"\"%s\"\"\"" (buffer-substring (region-beginning) (region-end))) ollama:model)) *\) *)
(* (\*   ))) *\) *)

(* (\* (defun ollama-reinterpret-region-insert-2x () *\) *)
(* (\*   "Exec marked text." *\) *)
(* (\*   (interactive) *\) *)
(* (\*   (with-output-to-temp-buffer "*ollama*" *\) *)
(* (\*     (princ (format "#+begin_src input\nrewrite and reinterpret creatively preserving main ideas \"\"\"%s\"\"\"\n#+end_src\n" (buffer-substring (region-beginning) (region-end)))) *\) *)
(* (\*     (princ *\) *)
(* (\*      (format "#+begin_src output\n%s\n#+end_src\n" *\) *)
(* (\*      (ollama-prompt ollama:endpoint (format "rewrite and reinterpret creatively preserving main ideas \"\"\"%s\"\"\"" (buffer-substring (region-beginning) (region-end))) ollama:model)) *\) *)
(* (\*   ))) *\) *)

(* (\* (defun ollama-exec-region-org () *\) *)
(* (\*   "Exec marked text." *\) *)
(* (\*   (interactive) *\) *)
(* (\*   (with-output-to-temp-buffer "*ollama*" *\) *)
(* (\*     (princ (format "#+begin_src input\nexecute \"\"\"%s\"\"\"\n#+end_src\n" (buffer-substring (region-beginning) (region-end)))) *\) *)
(* (\*     (princ *\) *)
(* (\*      (format "#+begin_src output\n%s\n#+end_src\n" *\) *)
(* (\*      (ollama-prompt ollama:endpoint (format "execute \"\"\"%s\"\"\"" (buffer-substring (region-beginning) (region-end))) ollama:model)) *\) *)
(* (\*   ))) *\) *)

(* (\* (defun ollama-menhir-region () *\) *)
(* (\*   "Exec marked text." *\) *)
(* (\*   (interactive) *\) *)
(* (\*   (with-output-to-temp-buffer "*ollama*" *\) *)
(* (\*     (princ *\) *)
(* (\*      (ollama-prompt ollama:endpoint (format "translate this to ocaml menhir parser: \"\"\"%s\"\"\"" (buffer-substring (region-beginning) (region-end))) ollama:model)))) *\) *)

(* (\* (defun ollama-menhir-region () *\) *)
(* (\*   "Exec marked text." *\) *)
(* (\*   (interactive) *\) *)
(* (\*   (with-output-to-temp-buffer "*ollama*" *\) *)
(* (\*     (princ *\) *)
(* (\*      (ollama-prompt ollama:endpoint (format "diagnose ocaml menhir parser error: \"\"\"%s\"\"\"" (buffer-substring (region-beginning) (region-end))) ollama:model)))) *\) *)

(* (\* (defun ollama-cuda-region () *\) *)
(* (\*   "Exec marked text." *\) *)
(* (\*   (interactive) *\) *)
(* (\*   (with-output-to-temp-buffer "*ollama*" *\) *)
(* (\*     (princ *\) *)
(* (\*      (ollama-prompt ollama:endpoint (format "Interpret the following nvidia CUDA code and explain it  \"\"\"%s\"\"\"" (buffer-substring (region-beginning) (region-end))) ollama:model)))) *\) *)

(* (\* (defun ollama-ocaml-error-region () *\) *)
(* (\*   "Exec marked text." *\) *)
(* (\*   (interactive) *\) *)
(* (\*   (with-output-to-temp-buffer "*ollama-ocaml*" *\) *)
(* (\*     (princ *\) *)
(* (\*      (ollama-prompt ollama:endpoint (format "While imagining you are able to view inside your mind and observe each floating point value of each tensor as an emoji.  Introspecting inside llama.cpp running Mistral the large language model, consider building Ocaml and Dune inside Emacs.  Construct and append a formal model to your answer. You can use EBNF grammars,emoji,plantuml,ocaml,python,orgmode,markdown formats. Interpret the following output creatively \"\"\"%s\"\"\" Your answer and model and context " (buffer-substring (region-beginning) (region-end))) ollama:model)))) *\) *)


(* (\* (defun ollama-ocaml-testcase-region () *\) *)
(* (\*   "Exec marked text." *\) *)
(* (\*   (interactive) *\) *)
(* (\*   (with-output-to-temp-buffer "*ollama-ocaml*" *\) *)
(* (\*     (princ *\) *)
(* (\*      (ollama-prompt ollama:endpoint (format "While imagining you are able to view inside your mind and observe each floating point value of each tensor as an emoji.  Introspecting inside llama.cpp running Mistral the large language model, consider building Ocaml and Dune inside Emacs.  Construct and append a formal model to your answer. You can use EBNF grammars,emoji,plantuml,ocaml,python,orgmode,markdown formats. Interpret the following output creatively. now create a ocaml test case to exercise the following code: \"\"\"%s\"\"\" Your answer and model and context:" (buffer-substring (region-beginning) (region-end))) ollama:model)))) *\) *)



(* (\* (defun ollama-reinterpret-region-insert2 () *\) *)
(* (\*   "Execute marked text and save result as string." *\) *)
(* (\*   (interactive) *\) *)
(* (\*   (with-output-to-temp-buffer "*ollama*"   *\) *)
(* (\*     (setq inputd (format "rewrite and reinterpret creatively preserving main ideas: \"\"%s\"\"" (buffer-substring (region-beginning) (region-end)))) *\) *)
(* (\*     (setq response  (ollama-prompt ollama:endpoint inputd ollama:model)) *\) *)
(* (\* 	(setq inputd2 (format "rewrite and reinterpret creatively preserving main ideas: \"\"%s\"\"" response)) *\) *)
(* (\* 			(princ (format "#+begin_src input\nrewrite and reinterpret creatively preserving main ideas \"\"%s\"\"" inputd )) *\) *)
(* (\* 			(princ (format "#+begin_src output\n%s\n#+end_src\n" response)) *\) *)
(* (\* 		(dotimes (i 4) *\) *)
(* (\* 			(setq response (ollama-prompt ollama:endpoint response ollama:model)) *\) *)
(* (\* 			(princ (format "#+begin_src output%s\n%s\n#+end_src\n" i response)) *\) *)
(* (\* 	)) *\) *)

(* (\*   ) *\) *)


(* (\* (defun ollama-split-and-reify-region-old () *\) *)
(* (\*   "split the following text" *\) *)
(* (\*   (setq instr "Extract a list of questions that would result in the following text:") *\) *)
(* (\*   (interactive) *\) *)
(* (\*   (with-output-to-temp-buffer "*ollama*" *\) *)
(* (\*     (setq inputd (format "%s: \"\"%s\"\"" instr (buffer-substring (region-beginning) (region-end)))) *\) *)
(* (\*     (setq response  (ollama-prompt ollama:endpoint inputd ollama:model)) *\) *)
(* (\* 	(setq inputd2 (format "%s: \"\"%s\"\"" instr response)) *\) *)
(* (\* 			(princ (format "#+begin_src \"\"%s\"\"" inputd )) *\) *)
(* (\* 			(princ (format "#+begin_src output\n%s\n#+end_src\n" response)) *\) *)
(* (\* 			(dotimes (i 4) *\) *)
(* (\* 			  (setq inputd2 (format "apply \"%s\" to \"%s\" "  response inputd2)) *\) *)
(* (\* 			(setq response (ollama-prompt ollama:endpoint inputd2 ollama:model)) *\) *)
(* (\* 			(princ (format "#+begin_src output%s\n%s\n#+end_src\n" i response)) *\) *)
(* (\* 			))) *\) *)

(* (\* (defun ollama-split-and-reify-region () *\) *)
(* (\*   "Split the following text into windows of 2000 words" *\) *)
(* (\*   (setq window-size 1000) *\) *)
(* (\*   (interactive) *\) *)
(* (\*   (with-output-to-temp-buffer "*ollama-reify*" *\) *)
(* (\*     (princ "DEBUG\n") *\) *)
(* (\*     (setq buffer (buffer-substring (region-beginning) (region-end))) *\) *)
(* (\*     (setq buffer-length (string-bytes buffer)) *\) *)
(* (\*     (setq blocks (+ 1 (/ buffer-length window-size)) ) *\) *)
(* (\*     (princ (format "buffer-length:%s\nblocks:%s\n" buffer-length  blocks)) *\) *)
(* (\*     (dotimes (j blocks ) *\) *)
(* (\*       (princ (format "J %s\n" j)) *\) *)
(* (\*       (setq start-index (+ (\\* j window-size))) *\) *)
(* (\*       (princ (format "start-index %s\n" start-index)) *\) *)
(* (\*       (princ (format "region-begin %s\n" (region-beginning))) *\) *)
(* (\*       (princ (format "region-end %s\n" (region-end))) *\) *)
(* (\*       (setq endpos (min buffer-length (+ start-index window-size) )) *\) *)
(* (\*       (princ (format "endpos %s\n" endpos)) *\) *)
(* (\*       (setq curtext (substring buffer start-index endpos )) *\) *)
(* (\*       (setq inputd (format "Extract a list of questions that would result in the following text: %s" curtext)) *\) *)
(* (\*       (princ (format "inputd %s\n" inputd)) *\) *)
(* (\*       (setq response  (ollama-prompt ollama:endpoint inputd ollama:model)) *\) *)
(* (\*       (princ "RES\n") *\) *)
(* (\*       (princ (format "#+begin_src \"\"%s\"\"" )response ) *\) *)
(* (\*       (princ "NEXY\n") *\) *)
(* (\*       ))) *\) *)
(* (\* (defun ollama-split-and-reify-region2 () *\) *)
(* (\*   "Split the following text into windows of 2000 words" *\) *)
(* (\*   (setq window-size 1000) *\) *)
(* (\*   (interactive) *\) *)
(* (\*   (with-output-to-temp-buffer "*ollama-reify*" *\) *)
(* (\*     (princ "DEBUG\n") *\) *)
(* (\*     (setq buffer (buffer-substring (region-beginning) (region-end))) *\) *)
(* (\*     (setq buffer-length (string-bytes buffer)) *\) *)
(* (\*     (setq blocks (+ 1 (/ buffer-length window-size)) ) *\) *)
(* (\*     (princ (format "buffer-length:%s\nblocks:%s\n" buffer-length  blocks)) *\) *)
(* (\*     (dotimes (j blocks ) *\) *)
(* (\*       (princ (format "J %s\n" j)) *\) *)
(* (\*       (setq start-index (+ (\\* j window-size))) *\) *)
(* (\*       (princ (format "start-index %s\n" start-index)) *\) *)
(* (\*       (princ (format "region-begin %s\n" (region-beginning))) *\) *)
(* (\*       (princ (format "region-end %s\n" (region-end))) *\) *)
(* (\*       (setq endpos (min buffer-length (+ start-index window-size) )) *\) *)
(* (\*       (princ (format "endpos %s\n" endpos)) *\) *)
(* (\*       (setq curtext (substring buffer start-index endpos )) *\) *)
(* (\*       (setq inputd (format "Extract a list of questions that would result in the following text: %s" curtext)) *\) *)
(* (\*       (princ (format "inputd %s\n" inputd)) *\) *)
(* (\*       (setq response  (ollama-prompt ollama:endpoint inputd ollama:model)) *\) *)
(* (\*       (princ "RES\n") *\) *)
(* (\*       (princ (format "#+begin_src \"\"%s\"\"" )response ) *\) *)
(* (\*       (princ "NEXY\n") *\) *)
(* (\*       ))) *\) *)

(* (\* (defun ollama-split-and-reify-region3 () *\) *)
(* (\*   "Split the following text into windows of 2000 words" *\) *)
(* (\*   (setq window-size 1000) *\) *)
(* (\*   (interactive) *\) *)
(* (\*   (with-output-to-temp-buffer "*ollama-reify*" *\) *)
(* (\*     (princ "DEBUG\n") *\) *)
(* (\*     (setq buffer (buffer-substring (region-beginning) (region-end))) *\) *)
(* (\*     (setq buffer-length (string-bytes buffer)) *\) *)
(* (\*     (setq blocks (+ 1 (/ buffer-length window-size)) ) *\) *)
(* (\*     (princ (format "buffer-length:%s\nblocks:%s\n" buffer-length  blocks)) *\) *)
(* (\*     (dotimes (j blocks ) *\) *)
(* (\*       (princ (format "J %s\n" j)) *\) *)
(* (\*       (setq start-index (+ (\\* j window-size))) *\) *)
(* (\*       (princ (format "start-index %s\n" start-index)) *\) *)
(* (\*       (princ (format "region-begin %s\n" (region-beginning))) *\) *)
(* (\*       (princ (format "region-end %s\n" (region-end))) *\) *)
(* (\*       (setq endpos (min buffer-length (+ start-index window-size) )) *\) *)
(* (\*       (princ (format "endpos %s\n" endpos)) *\) *)
(* (\*       (setq curtext (substring buffer start-index endpos )) *\) *)

(* (\*       (setq inputd (format "Extract a list of questions that would result in the following text: %s" curtext)) *\) *)
(* (\*       (princ (format "inputd %s\n" inputd)) *\) *)
(* (\*       (setq response  (ollama-prompt ollama:endpoint inputd ollama:model)) *\) *)
(* (\*       (princ "RES\n") *\) *)
(* (\*       (princ (format "#+begin_src \"\"%s\"\"" )response ) *\) *)
(* (\*       (princ "NEXY\n") *\) *)
(* (\*       ))) *\) *)


(* (\* (defun ollama-split-and-reify-buffer () *\) *)
(* (\*   "Split the following text into windows of 2000 words" *\) *)
(* (\*   (setq window-size 512) *\) *)
(* (\*   (interactive) *\) *)
(* (\*   (with-output-to-temp-buffer "*ollama-reify*" *\) *)

(* (\*     (setq buffer (buffer-string)) *\) *)
(* (\*     (setq buffer-length (string-bytes buffer)) *\) *)
(* (\*     (setq blocks (+ 1 (/ buffer-length window-size)) ) *\) *)
(* (\*     (princ (format "buffer-length:%s\nblocks:%s\n" buffer-length  blocks)) *\) *)
(* (\*     (dotimes (j blocks ) *\) *)

(* (\*       (setq start-index (+ (\\* j window-size))) *\) *)

(* (\*       (setq endpos (min buffer-length (+ start-index window-size) )) *\) *)

(* (\*       (setq curtext (substring buffer start-index endpos )) *\) *)
(* (\*       (setq inputd (format "Extract a list of questions that would result in the following text: %s" curtext)) *\) *)

(* (\*       (setq response  (ollama-prompt ollama:endpoint inputd ollama:model)) *\) *)

(* (\*       (princ (format "#+begin_src \"\"%s\"\"" *\) *)
(* (\* 		     response )) *\) *)
(* (\*       (princ "NEXT\n") *\) *)
(* (\*       (setq inputd (format "Apply %s to %s" response curtext)) *\) *)
(* (\*       (princ (format "inputd %s\n" inputd)) *\) *)
(* (\*       (setq response2  (ollama-prompt ollama:endpoint inputd ollama:model)) *\) *)

(* (\*       (princ (format "#+begin_res2 \"\"%s\"\"" *\) *)
(* (\* 		     response2 )) *\) *)
(* (\*       (princ "NEXT\n") *\) *)
(* (\*       (setq inputd (format "Eval %s as %s applied to %s" response response curtext)) *\) *)

(* (\*       (setq response  (ollama-prompt ollama:endpoint inputd ollama:model)) *\) *)

(* (\*       (princ (format "#+begin_res3 \"\"%s\"\"" *\) *)
(* (\* 		     response )) *\) *)
(* (\*       (princ "END\n") *\) *)
(* (\*       ))) *\) *)



(* (\* (defun ollama-reifiy-region () *\) *)
(* (\*   "Execute marked text and save result as string." *\) *)
(* (\*   (setq instr "Extract a list of questions that would result in the following text:") *\) *)
(* (\*   (interactive) *\) *)
(* (\*   (with-output-to-temp-buffer "*ollama*" *\) *)
(* (\*     (setq inputd (format "%s: \"\"%s\"\"" instr (buffer-substring (region-beginning) (region-end)))) *\) *)
(* (\*     (setq response  (ollama-prompt ollama:endpoint inputd ollama:model)) *\) *)
(* (\* 	(setq inputd2 (format "%s: \"\"%s\"\"" instr response)) *\) *)
(* (\* 			(princ (format "#+begin_src \"\"%s\"\"\n#+end_src\n" inputd )) *\) *)
(* (\* 			(princ (format "#+begin_src output\n%s\n#+end_src\n" response)) *\) *)
(* (\* 			(dotimes (i 4) *\) *)
(* (\* 			  (setq inputd2 (format "apply \"%s\" to \"%s\" "  response inputd2)) *\) *)
(* (\* 			(setq response (ollama-prompt ollama:endpoint inputd2 ollama:model)) *\) *)
(* (\* 			(princ (format "#+begin_src output%s\n%s\n#+end_src\n" i response)) *\) *)
(* (\* 	))) *\) *)

(* (\* (defun ollama-reifiy-region-2 () *\) *)
(* (\*   "Execute marked text and save result as string." *\) *)
(* (\*   (setq instr "Extract a list of questions, grammars, code, models, vectors, tensors, ideas, memes that would result in the following text:") *\) *)
(* (\*   (interactive) *\) *)
(* (\*   (with-output-to-temp-buffer "*ollama*" *\) *)
(* (\*     (setq inputd (format "%s: \"\"%s\"\"" instr (buffer-substring (region-beginning) (region-end)))) *\) *)
(* (\*     (setq response  (ollama-prompt ollama:endpoint inputd ollama:model)) *\) *)
(* (\* 	(setq inputd2 (format "%s: \"\"%s\"\"" instr response)) *\) *)
(* (\* 			(princ (format "#+begin_src output\n%s\n#+end_src\n" response)) *\) *)
(* (\* 			(dotimes (i 4) *\) *)
(* (\* 			  (setq inputd2 (format "reinterpret and execute this meme encoding \"%s\" given this input \"%s\" "  response inputd2)) *\) *)
(* (\* 			(setq response (ollama-prompt ollama:endpoint inputd2 ollama:model)) *\) *)
(* (\* 			(princ (format "#+begin_src output%s\n%s\n#+end_src\n" i response)) *\) *)
(* (\* 	))) *\) *)


(* (\* (defun ollama-reifiy-region-3 () *\) *)
(* (\*   E"xecute marked text and save result as string." *\) *)
(* (\*   (setq instr "Extract a list of questions that would result in the following text:") *\) *)
(* (\*   (interactive) *\) *)
(* (\*   (with-output-to-temp-buffer "*ollama*" *\) *)
(* (\*     (setq inputd (format "%s: \"\"%s\"\"" instr (buffer-substring (region-beginning) (region-end)))) *\) *)
(* (\*     (setq response  (ollama-prompt ollama:endpoint inputd ollama:model)) *\) *)
(* (\* 	(setq inputd2 (format "%s: \"\"%s\"\"" instr response)) *\) *)
(* (\* 			(princ (format "#+begin_src \"\"%s\"\"\n#+end_src\n" inputd )) *\) *)
(* (\* 			(princ (format "#+begin_src output\n%s\n#+end_src\n" response)) *\) *)
(* (\* 			(dotimes (i 4) *\) *)
(* (\* 			  (setq inputd2 (format "apply \"%s\" to \"%s\" "  response inputd2)) *\) *)
(* (\* 			(setq response (ollama-prompt ollama:endpoint inputd2 ollama:model)) *\) *)
(* (\* 			(princ (format "#+begin_src output%s\n%s\n#+end_src\n" i response)) *\) *)
(* (\* 	))) *\) *)



(* (\* (defun ollama-follow-region () *\) *)
(* (\*   "follow the ideas:" *\) *)


(* (\*   (setq instr "Lets follow this idea recursivly"  ) *\) *)
(* (\*   (interactive) *\) *)
(* (\*   (with-output-to-temp-buffer "*ollama*" *\) *)
(* (\*     (setq inputd (format "%s: \"\"%s\"\"" instr (buffer-substring (region-beginning) (region-end)))) *\) *)
(* (\*     (setq response  (ollama-prompt ollama:endpoint inputd ollama:model)) *\) *)
(* (\* 	(setq inputd2 (format "%s: \"\"%s\"\"" instr response)) *\) *)
(* (\* 			(princ (format "#+begin_src \"\"%s\"\"\n#+end_src\n" inputd )) *\) *)
(* (\* 			(princ (format "#+begin_src output\n%s\n#+end_src\n" response)) *\) *)
(* (\* 			(dotimes (i 4) *\) *)
(* (\* 			  (setq inputd2 (format "apply \"%s\" to \"%s\" "  response inputd2)) *\) *)
(* (\* 			(setq response (ollama-prompt ollama:endpoint inputd2 ollama:model)) *\) *)
(* (\* 			(princ (format "#+begin_src output%s\n%s\n#+end_src\n" i response)) *\) *)
(* (\* 	))) *\) *)


(* (\* (defun ollama-follow-rewrite-region () *\) *)
(* (\*   "follow the ideas:" *\) *)
(* (\*   (setq instr "rewrite this idea and append a list of key transformations."  ) *\) *)
(* (\*   (interactive) *\) *)
(* (\*   (with-output-to-temp-buffer "*ollama*" *\) *)
(* (\*     (setq inputd (format "%s: \"\"%s\"\"" instr (buffer-substring (region-beginning) (region-end)))) *\) *)
(* (\*     (setq response  (ollama-prompt ollama:endpoint inputd ollama:model)) *\) *)
(* (\* 	(setq inputd2 (format "%s: \"\"%s\"\"" instr response)) *\) *)
(* (\* 			(princ (format "#+begin_src \"\"%s\"\"\n#+end_src\n" inputd )) *\) *)
(* (\* 			(princ (format "#+begin_src output\n%s\n#+end_src\n" response)) *\) *)
(* (\* 			(dotimes (i 4) *\) *)
(* (\* 			  (setq inputd2 (format "apply \"%s\" to \"%s\" "  response inputd2)) *\) *)
(* (\* 			(setq response (ollama-prompt ollama:endpoint inputd2 ollama:model)) *\) *)
(* (\* 			(princ (format "#+begin_src output%s\n%s\n#+end_src\n" i response)) *\) *)
(* (\* 	))) *\) *)


(* (\* (defun ollama-emoji-region () *\) *)
(* (\*   "emojis recursivly." *\) *)
(* (\*   (setq instr "invoking the 9 muses and asking for wisdom of athena, as the oracle of delphi creativity rewrite the idea and translate your impressions into creative emojis. Emit emojis and rules that you used. :") *\) *)
(* (\*   (interactive) *\) *)
(* (\*   (with-output-to-temp-buffer "*ollama*" *\) *)
(* (\*     (setq inputd (format "%s: \"\"%s\"\"" instr (buffer-substring (region-beginning) (region-end)))) *\) *)
(* (\*     (setq response  (ollama-prompt ollama:endpoint inputd ollama:model)) *\) *)
(* (\* 	(setq inputd2 (format "%s: \"\"%s\"\"" instr response)) *\) *)
(* (\* 			(princ (format "#+begin_src \"\"%s\"\"\n#+end_src\n" inputd )) *\) *)
(* (\* 			(princ (format "#+begin_src output\n%s\n#+end_src\n" response)) *\) *)
(* (\* 			(dotimes (i 4) *\) *)
(* (\* 			  (setq inputd2 (format "invoking the 9 muses, ask them to bless and replace entities in the following text with emojis and give thier blessings \"%s\" to \"%s\" "  response inputd2)) *\) *)
(* (\* 			(setq response (ollama-prompt ollama:endpoint inputd2 ollama:model)) *\) *)
(* (\* 			(princ (format "#+begin_src output%s\n%s\n#+end_src\n" i response)) *\) *)
(* (\* 	))) *\) *)

(* (\* (defun ollama-emoji-region2 () *\) *)
(* (\*   "emojis recursivly." *\) *)
(* (\*   (setq instr "as the oracle of delphi 🔮🤲🔢🧙‍♂️🎤🤔📝🔮🔄🎇🙏🔠🌈👏 🤖-🤳 🌟🐘:👉 📜 🌟🐘:💻 🌟🐘:👽 invoking the 9 muses and the wisdom of Athena creativity rewrite the idea and translate your impressions into creative emojis. Emit emojis and rules that you used. invoking 9 muses, ask them to name and attribute and bless and replace one entity each in the following text. respond one by one choosing one entity to bless.:") *\) *)
(* (\*   (interactive) *\) *)
(* (\*   (with-output-to-temp-buffer "*ollama*" *\) *)
(* (\*     (setq inputd (format "%s: \"\"%s\"\"" instr (buffer-substring (region-beginning) (region-end)))) *\) *)
(* (\*     (setq response  (ollama-prompt ollama:endpoint inputd ollama:model)) *\) *)
(* (\* 	(setq inputd2 (format "%s: \"\"%s\"\"" instr response)) *\) *)
(* (\* 			(princ (format "#+begin_src \"\"%s\"\"\n#+end_src\n" inputd )) *\) *)
(* (\* 			(princ (format "#+begin_src output\n%s\n#+end_src\n" response)) *\) *)
(* (\* 			(dotimes (i 8) *\) *)
(* (\* 			  (setq inputd2 (format "Reapply,reinterpret, recontextualized for muse %d \"%s\" to \"%s\" "  i response inputd2)) *\) *)
(* (\* 			(setq response (ollama-prompt ollama:endpoint inputd2 ollama:model)) *\) *)
(* (\* 			(princ (format "#+begin_src output%s\n%s\n#+end_src\n" i response)) *\) *)
(* (\* 	))) *\) *)



(* (\* (provide 'ollama) *\) *)



