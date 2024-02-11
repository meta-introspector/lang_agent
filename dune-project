(lang dune 3.8)
(using coq 0.8)
(name lang_agent)

(generate_opam_files true)

(source
 (github meta-introspector/lang_agent))

(authors "James Michael DuPont")

(maintainers "James Michael DuPont")

(license AGPL-3.0-or-later)

(documentation https://github.com/meta-introspector/lang_agent)

(package
 (name lang_agent)
 (synopsis "functional access to llm via ollama and openai")
 (description "command line tools for processing text with llms")
 (depends ocaml dune ppx_yojson lwt_ppx containers lambdasoup uri ezcurl ppx_yojson_conv ppx_yojson_conv_lib ezcurl-lwt yojson
   
  (coq-equations (>= 1.3))
  (coq-metacoq-template (>= 1.0+8.15))
  (coq-metacoq-translations (>= 1.0+8.15))
  (coq-metacoq (>= 1.0+8.15))
   
 )

 (tags
  (topics "ollama" "llm" "openai" "llama.cpp")))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/dune-files.html#dune-project
