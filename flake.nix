{
  inputs = {
#     openai = {
#     owner = "meta-introspector";
#     repo = "openai-ocaml";
#     rev = "da27c7644812ac6faed480b8a295830f920fcd3e";
#     type = "github";
# #    opamInputs = 
# #      {
# #        inherit ppx_yojson_conv ppx_yojson ocaml lwt_ppx
# #        ezcurl-lwt dune conf-openssl;
# #      };
# #      opamSrc = "openai.opam";
#     };
    openai.url = "github:meta-introspector/openai-ocaml/0.0.2";	
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
#        pkgs = nixpkgs.legacyPackages.${system};
        pkgs = import nixpkgs { inherit system; overlays = [ openai ]; };
        on = opam-nix.lib.${system};
        scope =
          on.buildDuneProject { } package  ./. { ocaml-base-compiler = "*"; };
        overlay = final: prev:
          {
            # Your overrides go here
          };
      in {
        legacyPackages = scope.overrideScope' overlay;

        packages.default = self.legacyPackages.${system}.${package};
      });
}
