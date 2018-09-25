{ database ? "nix-yesod-postgres"
, user ? "nix-yesod-postgres"
, pass ? "nix-yesod-postgres"
, host ? "127.0.0.1"
, port ? "5432"
}:

let
  pkgs = import ../nixpkgs-pinned {};
in

pkgs.stdenv.mkDerivation rec {
  name = "run-psql";

  project-root = import ../project-root.nix;

  buildInputs = [
    pkgs.postgresql
    pkgs.glibcLocales
  ];

  LANG="en_US.UTF-8";

  shellHook = ''
    set -eu

    export PGDATA=${project-root}/tmp/pgdata

    PGPASS=${pass} psql -h ${host} -U ${user} -p ${port} -d ${database}

    exit
  '';
}
