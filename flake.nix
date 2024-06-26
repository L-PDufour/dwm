{
  description = "DWM flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    utils,
  }:
    utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          (final: prev: {
            dwm = prev.dwm.overrideAttrs (old: {
              src = ./.;
              buildInputs = with prev; old.buildInputs ++ [fira-code-nerdfont];
            });
          })
        ];
      };
    in {
      packages = {
        default = pkgs.dwm;
      };
    });
}
