sudo apt install -y opam
opam init --shell-setup -y
eval $(opam env --switch=default)
 opam repo add coq-released https://coq.inria.fr/opam/released
 opam repo add coq-extra-dev https://coq.inria.fr/opam/extra-dev


 opam install --yes ppx_yojson_conv_lib

 opam install --yes coq
 opam install --yes ppx_yojson lwt_ppx containers lambdasoup uri ezcurl ppx_yojson_conv ppx_yojson_conv_lib ezcurl-lwt yojson
opam install --yes --deps-only .
 dune build .
