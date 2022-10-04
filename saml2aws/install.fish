#!/usr/bin/env fish


# this function gets the latest release of saml2aws from github
# since saml2aws isn't part of the ppa or repos
function get_latest_linux_release
    curl --silent \
        "https://api.github.com/repos/Versent/saml2aws/releases/latest" \
        | string match --regex '"browser_download_url": "\K.*?(?=")' \
        | string match -e "linux_amd64"
end

function install_s2a_for_linux
	mkdir -p ~/.bin
	and wget -q (get_latest_linux_release) -O - | tar -xz -C ~/.bin
	and chmod u+x ~/.bin/saml2aws
	and rm ~/.bin/*.md
	and echo "saml2aws: successfully installed"
	or echo "saml2aws: failed to install"
end

# global configuration for saml2aws
# Always set the sessionduration to be 6 hours
set -Ux SAML2AWS_SESSION_DURATION 21600

# add saml2aws shortcut for logging in without prmopt
alias --save s2a="saml2aws --skip-prompt"

switch (uname -a)
	case 'Darwin*'
        if ! command -qs saml2aws
            brew install saml2aws
        else
            brew upgrade saml2aws
        end
    case '*'
		install_s2a_for_linux
			and echo "saml2aws: successfully installed"
			or echo "saml2aws: failed to install"
end

# extra configuration required for WSL setup
# due to no support for X11 to use gnome keyring
if [ $IS_WSL = 0 ]
	set -Ux SAML2AWS_KEYRING_BACKEND pass
	set -Ux GPG_TTY ( tty )
end



