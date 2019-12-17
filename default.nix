{ pkgs ? import ./nixpkgs.nix {} }:

pkgs.haskellPackages.callCabal2nix "optics-by-example" ./. {}
