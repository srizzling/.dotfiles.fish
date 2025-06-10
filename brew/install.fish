#!/usr/bin/env fish

# # brew should already be installed as part of the root install.sh script
# # so this just autoconfigures and autoupdates the Brewfile depending on the
# # pkgs

# https://gist.github.com/ChristopherA/a579274536aab36ea9966f301ff14f3f

# (
# 	crontab -l | grep -v "brew-update"
# 	echo "0 12 * * 4 $HOME/.dotfiles/brew/brew-update > ${TMPDIR:-/tmp}/brew_update.log 2>&1"
# ) | crontab -

if string match -q "Darwin" (uname)
    if not command -q brew
        echo "Homebrew is not installed. Would you like to install it? (y/n)"
        read -l response
        if string match -q "y" $response
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            and echo "Homebrew installed successfully."
            or echo "Failed to install Homebrew."
        else
            echo "Skipping Homebrew installation."
        end
    end

    # Link the plist file and load it with launchctl
    set plist_path "$HOME/Library/LaunchAgents/com.user.brewupdate.plist"
    if not test -f $plist_path
        echo "Linking and loading launchd job for brew-update.sh"
        ln -sf $DOTFILES/brew/com.user.brewupdate.plist.symlink $plist_path
        launchctl load $plist_path
        and echo "Launchd job linked and loaded successfully."
        or echo "Failed to link or load launchd job."
    else
        echo "Launchd job for brew-update.sh already exists."
    end
end

# Run brew update before cleanup to ensure the system's current state is reflected
echo "Updating Homebrew to reflect the current system state..."
brew update

# Proceed with cleanup only after updating
brew bundle --force cleanup --file=$DOTFILES/brew/Brewfile
