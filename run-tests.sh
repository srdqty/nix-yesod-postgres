#!/usr/bin/env bash

set -eu

nix-shell --pure nix/scripts/generate-cabal-and-nix-file.nix
nix-shell --pure nix/development.nix --run "cabal new-test -f dev"
