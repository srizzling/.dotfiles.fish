#!/usr/bin/env bash
set -e

# Navigate to the directory containing the Brewfile
cd "$DOTFILES_ROOT/brew" || exit 1

# Refresh the Brewfile with the current state of installed packages
brew bundle dump --force --file=Brewfile

# Update Homebrew and upgrade installed packages
brew update && brew upgrade

# Check if there are changes to the Brewfile
if git diff --quiet -- Brewfile; then
    echo "No changes to the Brewfile."
else
    echo "Changes detected in the Brewfile. Preparing commit."
    git add Brewfile

    # Parse the diff and extract the first added line for the commit subject
    added_line=$(git diff --cached -- Brewfile | grep '^+' | grep -v '+++' | head -n 1 | sed 's/^+//')
    commit_subject="feat(brew): ✨ Added $added_line"

    git commit -m "$commit_subject"
    git push origin main
fi
