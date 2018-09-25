{ compiler ? import ./ghc.nix
, extraHaskellOverride ? (pkgs: new: old: {})
}:
let
  haskellOverlay = (self: super: {
    haskellPackages = super.haskell.packages."${compiler}".override {
      overrides = (new: old: {
        # Avoid haddock internal error when compiling this package
        classy-prelude-yesod =
          super.haskell.lib.dontHaddock old.classy-prelude-yesod;
      } // extraHaskellOverride self new old);
    };
  });

  nonHaskellOverlay = (self: super: {
  });
in
  [nonHaskellOverlay haskellOverlay]
