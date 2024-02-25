{
  inputs = {
  openai.owner = "meta-introspector";
    openai.repo = "openai-ocaml";
    openai.rev = "da27c7644812ac6faed480b8a295830f920fcd3e";
    openai.type = "github";
	  
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";	
    opam-nix.url = "github:tweag/opam-nix";
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.follows = "opam-nix/nixpkgs";
    
  };
  outputs = { self, flake-utils, opam-nix, nixpkgs, openai }@inputs:
    # Don't forget to put the package name instead of `throw':
    let package = "lang_agent";
    in flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        on = opam-nix.lib.${system};
        scope =
          on.buildDuneProject { } package ./. { ocaml-base-compiler = "*"; };
        overlay = final: prev:
          {
            # Your overrides go here
          };
      in {
        legacyPackages = scope.overrideScope' overlay;

        packages.default = self.legacyPackages.${system}.${package};
      });
}
