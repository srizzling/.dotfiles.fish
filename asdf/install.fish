#!/usr/bin/env fish

# ensure the most update to version of asdf exists
switch (uname)
    case 'Darwin'
        set -Ux ASDF_HOME (brew --prefix asdf)
    case '*fedora*'
        # do no thing - its assumed this is a siliverblue instance
    case '*'
        set -Ux ASDF_HOME $HOME/.asdf
end

# ensure its sourced right now
source $ASDF_HOME/asdf.fish

# install plugins
asdf plugin add nodejs
asdf plugin add golang
asdf plugin add python
asdf plugin add java

# golang
set -l golang_versions_to_install 1.14 1.15 1.16
for v in $golang_versions_to_install
    asdf install golang $v
end

# node
set -l node_versions_to_install 14.15.0 lts 15.14.0 16.3.0
for v in $node_versions_to_install
    asdf install nodejs $v
end

