let
  haskellPackagesOverlay = pkgsNew: pkgsOld: {
    haskellPackages = pkgsOld.haskellPackages.override (old: {
      overrides =
        let
          extension =
            (pkgsNew.haskell.lib.packagesFromDirectory {
              directory = ./nix/haskell-packages;
            });
        in
          pkgsNew.lib.composeExtensions
            (old.overrides or (_: _: {}))
            extension;
    });
  };


  pkgs =
    import ./nix/nixpkgs.nix {
      overlays = [ haskellPackagesOverlay ];
      config = {};
    };


  optics-by-example = pkgs.haskellPackages.optics-by-example;


  executable = pkgs.haskell.lib.justStaticExecutables optics-by-example;


  shell =
    optics-by-example.env.overrideAttrs (old: {
      buildInputs = with pkgs; old.buildInputs ++ [
        cabal-install
        ghcid
        hlint
      ];
    });
in
  { inherit
      optics-by-example
      executable
      shell
    ;
  }
