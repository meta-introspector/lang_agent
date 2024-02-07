(lang dune 3.7)

(name lang_agent)

(generate_opam_files true)

(source
 (github username/reponame))

(authors "Author Name")

(maintainers "Maintainer Name")

(license GPL)

(documentation https://url/to/documentation)

(package
 (name lang_agent)
 (synopsis "A short synopsis")
 (description "A longer description")
 (depends ocaml dune ppx_yojson lwt_ppx containers lambdasoup uri ezcurl ppx_yojson_conv ppx_yojson_conv_lib ezcurl-lwt yojson
   
  (coq-equations (>= 1.3))
  (coq-metacoq-template (>= 1.0+8.15))
  (coq-metacoq-translations (>= 1.0+8.15))
  (coq-metacoq (>= 1.0+8.15))
   
 )

 (tags
  (topics "to describe" your project)))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/dune-files.html#dune-project
