let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-23.11";
  pkgs = import nixpkgs { config = {}; overlays = []; };
in

pkgs.mkShellNoCC {
  packages = with pkgs; [
  emacs
  opam
  coq
  niv	
];
}
;; nixpkgs.emacsPackages.proofgeneral
;; nixpkgs.emacsPackages.magit
;; nixpkgs.emacsPackages.straight_HEAD

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
