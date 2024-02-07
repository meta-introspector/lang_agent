 opam install --yes --deps-only .
 opam install --yes ppx_yojson_conv_lib

 opam install --yes ppx_yojson lwt_ppx containers lambdasoup uri ezcurl ppx_yojson_conv ppx_yojson_conv_lib ezcurl-lwt yojson
 dune build .
