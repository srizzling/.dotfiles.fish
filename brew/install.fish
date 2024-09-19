#!/usr/bin/env fish

# # brew should already be installed as part of the root install.sh script
# # so this just autoconfigures and autoupdates the Brewfile depending on the
# # pkgs

# https://gist.github.com/ChristopherA/a579274536aab36ea9966f301ff14f3f

# (
# 	crontab -l | grep -v "brew-update"
# 	echo "0 12 * * 4 $HOME/.dotfiles/brew/brew-update > ${TMPDIR:-/tmp}/brew_update.log 2>&1"
# ) | crontab -

if command -q brew
    brew bundle --force cleanup --file=$DOTFILES/brew/Brewfile
end
