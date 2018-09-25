{ project-name }:

with import ../nixpkgs-pinned {};

stdenv.mkDerivation rec {
  name = "change-project-name";

  project-root = import ../project-root.nix;

  buildInputs = [
    haskellPackages.hpack
    cabal2nix
  ];

  shellHook = ''
    set -eu

    paths="app
    config
    ChangeLog.md
    nix
    package.yaml
    README.md
    src
    static
    templates
    test
    "

    for path in $paths; do
      echo "Update ${project-root}/$path"
      find "${project-root}/$path" \
        -type f \
        ! -name "change-project-name.nix" \
        | xargs -r sed -i -e "s/nix-yesod-postgres/${project-name}/g"
    done

    rm -f ${project-root}/nix-yesod-postgres.cabal

    nix-shell --pure ${project-root}/nix/scripts/generate-cabal-and-nix-file.nix

    exit
  '';
}
