{ pkgs ? import ./nixpkgs.nix {} }:

let
  optics-by-example = import ./default.nix {};
in
  pkgs.lib.overrideDerivation optics-by-example.env (old: {
    buildInputs = with pkgs; old.buildInputs ++ [ cabal-install ghcid hlint ];
  })
