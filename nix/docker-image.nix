{ compiler ? import ./ghc.nix
, image-name
, image-tag
}:

let
  pkgs = import ./nixpkgs-pinned {};

  release = import ./release.nix { inherit compiler; };

  executable = pkgs.haskell.lib.justStaticExecutables release;
in
  pkgs.dockerTools.buildImage {
    name = image-name;
    tag = image-tag;

    contents = [
      executable
    ];

    config = {
      Entrypoint = [
        "nix-yesod-postgres"
      ];

      Env = [
        "VAR1=var1"
        "VAR2=var2"
      ];
    };
  }
