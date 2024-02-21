(lang dune 3.7)

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
 (synopsis "Functional access to llm via ollama and openai")
 (description "Command line tools for processing text with language models")
 (depends ocaml dune ppx_yojson lwt_ppx containers lambdasoup uri ezcurl ppx_yojson_conv ppx_yojson_conv_lib ezcurl-lwt yojson stdio 
 )

 (tags
  (topics "ollama" "llm" "openai" "llama.cpp")))

