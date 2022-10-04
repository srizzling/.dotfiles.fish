#!/usr/bin/env fish

# ensure the most update to version of asdf exists
switch (uname)
    case 'Darwin'
        brew install asdf
        set -Ux ASDF_HOME (brew --prefix asdf)
    case '*'
        git clone https://github.com/asdf-vm/asdf.git ~/.asdf
        pushd ~/.asdf
        set -l latesttag (git describe --abbrev=0 --tags)
        git checkout $latesttag
        popd
        set -Ux ASDF_HOME $HOME/.asdf
end

# # this is probably not great - but helps the first install work pretty nice
# exec fish

# install plugins
asdf plugin add nodejs
asdf plugin add golang
asdf plugin add python
asdf plugin add java
asdf plugin add direnv

# direnv
asdf direnv setup --shell fish --version latest

# golang
set -l golang_versions_to_install 1.14 1.15 1.16 1.17 1.18
for v in $golang_versions_to_install
    asdf install golang $v
end

# node
set -l node_versions_to_install lts 14.15.0 15.14.0 16.3.0
for v in $node_versions_to_install
    asdf install nodejs $v
end

