#!/usr/bin/env bash

set -eu

nix-shell --pure nix/scripts/generate-cabal-and-nix-file.nix
nix-shell nix/development.nix
