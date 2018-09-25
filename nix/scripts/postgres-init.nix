{ dev-database ? "nix-yesod-postgres"
, test-database ? "nix-yesod-postgres_test"
, user ? "nix-yesod-postgres"
, pass ? "nix-yesod-postgres"
, host ? "127.0.0.1"
, port ? "5432"
}:

let
  pkgs = import ../nixpkgs-pinned {};
in

pkgs.stdenv.mkDerivation rec {
  name = "postgres-init";

  project-root = import ../project-root.nix;

  buildInputs = [
    pkgs.postgresql
    pkgs.glibcLocales
  ];

  LANG="en_US.UTF-8";

  shellHook = ''
    set -eu

    export PGDATA=${project-root}/tmp/pgdata

    initdb

    pg_ctl start

    sleep 5

    psql \
      -e \
      -d postgres \
      -c "CREATE ROLE \"${user}\" SUPERUSER CREATEDB CREATEROLE LOGIN PASSWORD '${pass}'";

    PGPASS=${pass} createdb -e -h ${host} -p ${port} -U ${user} ${dev-database}
    PGPASS=${pass} createdb -e -h ${host} -p ${port} -U ${user} ${test-database}

    pg_ctl stop

    exit
  '';
}
