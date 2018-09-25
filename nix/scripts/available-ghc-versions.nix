let
  pkgs = import ../nixpkgs-pinned {};

  compilers = builtins.attrNames pkgs.haskell.packages;
in

pkgs.stdenv.mkDerivation rec {
  name = "available-ghc-versions";

  shellHook = ''
    set -eu

    echo "Available ghc compiler versions:"
    echo -e "${builtins.concatStringsSep "\n" compilers}"

    exit
  '';
}
