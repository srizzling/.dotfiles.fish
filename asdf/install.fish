#!/usr/bin/env fish

# plugin defintions
set -l asdf_plugins python nodejs golang direnv saml2aws awscli starship jq gum rust

# ensure the most update to version of asdf exists
switch (uname)
    case Darwin
        brew install asdf
        set -a asdf_plugins exa
    case '*'
        # Check if the ~/.asdf directory exists
        if test -d ~/.asdf
            # If exists, navigate and pull the latest code
            cd ~/.asdf
            git pull origin master
        else
            # Otherwise, clone the repository
            git clone https://github.com/asdf-vm/asdf.git ~/.asdf
        end

        set -Ux ASDF_HOME $HOME/.asdf

        if not grep -q "source ~/.asdf/asdf.fish" ~/.config/fish/config.fish
            echo "source ~/.asdf/asdf.fish" >>~/.config/fish/config.fish
        end

        # when we are in ubuntu to install python we need build essitionals
        if test (cat /etc/os-release | grep '^ID=ubuntu' -c) -gt 0
            sudo apt-get install -y build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev curl libbz2-dev
        end
end


# plugins to install
set -l asdf_plugins python nodejs golang direnv saml2aws awscli starship jq gum rust

for p in $asdf_plugins
    begin
        asdf plugin add $p
        asdf install $p latest
        and asdf global $p latest
    end &
end

# Wait for all jobs to complete
wait

# direnv requires special setup
asdf direnv setup --shell fish --version latest

set -Ux ASDF_NODEJS_LEGACY_FILE_DYNAMIC_STRATEGY latest_available

# https://github.com/asdf-vm/asdf-nodejs#nvmrc-and-node-version-support
ln -sf $DOTFILES/asdf/.asdfrc $HOME/.asdfrc
ln -sf $DOTFILES/asdf/.default-npm-packages $HOME/.default-npm-packages
ln -sf $DOTFILES/asdf/.tool-versions $HOME/.tool-versions

# https://github.com/asdf-community/asdf-golang#goroot
. ~/.asdf/plugins/golang/set-env.fish
