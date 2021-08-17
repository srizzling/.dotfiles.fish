#!/usr/bin/env bash
set -e

cd "$(dirname "${BASH_SOURCE[0]}")"
git pull --rebase origin main
brew bundle dump --force --describe
git add "$(dirname "${BASH_SOURCE[0]}")/Brewfile"
git commit -sm '⬆️(brew): update pkgs' || true
git push origin HEAD
