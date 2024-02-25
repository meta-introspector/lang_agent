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
