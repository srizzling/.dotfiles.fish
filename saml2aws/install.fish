#!/usr/bin/env fish


# this function gets the latest release of saml2aws from github
# since saml2aws isn't part of the ppa or repos
function get_latest_linux_release
    curl --silent \
        "https://api.github.com/repos/Versent/saml2aws/releases/latest" \
        | string match --regex '"browser_download_url": "\K.*?(?=")' \
        | string match -e "linux_amd64"
end

switch (uname -a)
    case 'Darwin*'
        if ! command -qs code
            brew install saml2aws
        else
            brew upgrade saml2aws
        end
    case '*'
        mkdir -p ~/.bin
        and wget -q (get_latest_linux_release) -O - | tar -xz -C ~/.bin
        and chmod u+x ~/.bin/saml2aws
        and rm ~/.bin/*.md
        and echo "saml2aws: successfully installed"
        or echo "saml2aws: failed to install"
end




