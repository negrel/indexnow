{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { flake-utils, nixpkgs, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        lib = pkgs.lib;
      in
      {
        devShells = {
          default = pkgs.mkShell {
            buildInputs = with pkgs; [ nodejs_18 ];
          };
        };
        packages = {
          default = pkgs.buildNpmPackage {
            pname = "indexnow";
            version = "1.1.1";

            src = ./.;

            npmDepsHash = "sha256-OKzIN4yZ2PCoxHsp6QOXMojDAGKSYLsdcVHa6WcfobA=";

            meta = {
              description = "CLI tool for submitting website URLs using IndexNow to search engines.";
              homepage = "https://github.com/robogeek/indexnow";
              license = lib.licenses.mit;
            };
          };
        };
      }
    );
}

