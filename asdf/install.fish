#!/usr/bin/env fish

# ensure the most update to version of asdf exists
switch (uname)
    case Darwin
        brew install asdf
    case '*'
        git clone https://github.com/asdf-vm/asdf.git ~/.asdf
        # pushd ~/.asdf
        # set -l latesttag (git describe --abbrev=0 --tags)
        # git checkout $latesttag
        # popd
        set -Ux ASDF_HOME $HOME/.asdf

        if not grep -q "source ~/.asdf/asdf.fish" ~/.config/fish/config.fish
            echo "source ~/.asdf/asdf.fish" >>~/.config/fish/config.fish
        end
end


# plugins to install
set -l asdf_plugins nodejs golang direnv saml2aws awscli exa starship jq gum rust
for p in $asdf_plugins
    asdf plugin add $p
    asdf install $p latest
    asdf global $p latest
end

# direnv requires special setup
asdf direnv setup --shell fish --version latest

# https://github.com/asdf-vm/asdf-nodejs#nvmrc-and-node-version-support
ln -sf $DOTFILES/asdf/.asdfrc $HOME/.asdfrc
ln -sf $DOTFILES/asdf/.default-npm-packages $HOME/.default-npm-packages
ln -sf $DOTFILES/asdf/.tool-versions $HOME/.tool-versions

# https://github.com/asdf-community/asdf-golang#goroot
. ~/.asdf/plugins/golang/set-env.fish
