#!/usr/bin/env fish

# ensure the most update to version of asdf exists
switch (uname)
    case Darwin
        brew install asdf
    case '*'
        git clone https://github.com/asdf-vm/asdf.git ~/.asdf
        pushd ~/.asdf
        set -l latesttag (git describe --abbrev=0 --tags)
        git checkout $latesttag
        popd
        set -Ux ASDF_HOME $HOME/.asdf
end

# unforently asdf doesn't support m1/m2 for awscli - so we are just skiping
# for mac altogeather it is installed via brew instead


# plugins to install
set -l asdf_plugins nodejs golang python direnv saml2aws
for p in $asdf_plugins
    asdf plugin add $p
end

# set globals for all plugins to latest
for p in $asdf_plugins
    asdf global $p latest
end

# direnv requires special setup
asdf direnv setup --shell fish --version latest
