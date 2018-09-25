{ dev-database ? "nix-yesod-postgres"
, test-database ? "nix-yesod-postgres_test"
, password ? "nix-yesod-postgres"
, user ? "nix-yesod-postgres"
}:

let
  pkgs = import ../nixpkgs-pinned {};
in

pkgs.stdenv.mkDerivation rec {
  name = "postgres-start";

  project-root = import ../project-root.nix;

  buildInputs = [
    pkgs.postgresql
    pkgs.glibcLocales
  ];

  LANG="en_US.UTF-8";

  shellHook = ''
    set -eu

    export PGDATA=${project-root}/tmp/pgdata

    pg_ctl start

    exit
  '';
}
