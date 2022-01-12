#!/usr/bin/env bash
set -e

cd "$(dirname "${BASH_SOURCE[0]}")"
git pull --rebase origin main
code --list-extensions >"$DOTFILES"/vscode/extensions.txt
git add "$DOTFILES/vscode/extensions.txt"
git commit -sm '⬆️(vscode): update pkgs' || true
git push origin HEAD
