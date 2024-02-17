set -e

#eval $(opam env --switch=default)
#opam switch 
eval $(opam env --switch=5.1.2+trunk)
 opam install --yes ppx_yojson_conv_lib


 opam install --yes ppx_yojson lwt_ppx containers lambdasoup uri ezcurl ppx_yojson_conv ppx_yojson_conv_lib ezcurl-lwt yojson
 opam install -w --yes --deps-only .
 opam pin add --yes openai https://github.com/meta-introspector/openai-ocaml.git#main --update-invariant
 dune build .
