{ compiler ? import ./ghc.nix }:

let
  haskellOverrides = pkgs: new: old: {
    nix-yesod-postgres =
      pkgs.haskell.lib.dontHaddock (old.callPackage ./.. {});
  };

  overlays = import ./overlays.nix {
    compiler = compiler;
    extraHaskellOverride = haskellOverrides;
  };

  pkgs = import ./nixpkgs-pinned {
    overlays = overlays;
  };
in
  pkgs.haskellPackages.nix-yesod-postgres
