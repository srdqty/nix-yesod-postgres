#!/usr/bin/env bash

set -eu

nix-shell --pure nix/scripts/generate-cabal-and-nix-file.nix
nix-shell --pure nix/development.nix \
  --run \
  "ghcid \
    --command 'cabal new-repl -f dev lib:nix-yesod-postgres' \
    --test DevelMain.update"
