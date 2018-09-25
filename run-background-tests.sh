#!/usr/bin/env bash

set -eu

nix-shell --pure nix/scripts/generate-cabal-and-nix-file.nix
nix-shell --pure nix/development.nix \
  --run \
  "ghcid \
    --reload=src \
    --command 'cabal new-repl -f dev nix-yesod-postgres-test' \
    --test Main.main"
