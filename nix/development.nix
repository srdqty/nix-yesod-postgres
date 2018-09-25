{ compiler ? import ./ghc.nix }:

let
  pkgs = import ./nixpkgs-pinned {};

  project-root = import ./project-root.nix;

  hlib = pkgs.haskell.lib;

  withTestAndBench = drv: hlib.doCheck (hlib.doBenchmark drv);

  release = import ./release.nix { inherit compiler; };

  development = withTestAndBench release;
in
  development.env.overrideAttrs (old: rec {
    name = compiler + "-" + old.name;

    buildInputs = [
      pkgs.ncurses # Needed by the bash-prompt.sh script
      pkgs.haskellPackages.cabal-install
      pkgs.haskellPackages.ghcid
    ];

    shellHook = old.shellHook + builtins.readFile ./bash-prompt.sh + ''
      source ${pkgs.git}/etc/bash_completion.d/git-prompt.sh
      source ${pkgs.git}/etc/bash_completion.d/git-completion.bash
    '';
  })
