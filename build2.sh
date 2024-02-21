set -e

eval $(opam env --switch=4.1.13)
 opam repo add coq-released https://coq.inria.fr/opam/released
 opam repo add coq-extra-dev https://coq.inria.fr/opam/extra-dev

 opam install --yes ppx_yojson_conv_lib
 opam install --yes ppx_yojson lwt_ppx containers lambdasoup uri ezcurl ppx_yojson_conv ppx_yojson_conv_lib ezcurl-lwt yojson stdio
 opam install -w --yes --deps-only .
 opam pin add --yes openai https://github.com/meta-introspector/openai-ocaml.git#main --update-invariant
 dune build .
 echo the following are optional and may take a long time
 opam install --yes coq
  opam install --yes serlib
