with import <nixpkgs> {};
let
  ocaml = ocaml-ng.ocamlPackages_4_13.ocaml;
  opam2nix = import ./opam2nix.nix {};
  selection = opam2nix.build {
    inherit ocaml;
    selection = ./opam-selection.nix;
    src = ./.;
  };
in
selection.lang_agent
