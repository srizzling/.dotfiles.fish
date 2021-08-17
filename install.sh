#!/bin/bash
IFS=$'\n\t'

info() {
	# shellcheck disable=SC2059
	printf "\r  [ \033[00;34m..\033[0m ] $1\n"
}

user() {
	# shellcheck disable=SC2059
	printf "\r  [ \033[0;33m??\033[0m ] $1\n"
}

success() {
	# shellcheck disable=SC2059
	printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail() {
	# shellcheck disable=SC2059
	printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
	echo ''
	exit
}

if [[ $(uname) == "Darwin" ]]; then
	IS_MAC=true
else
	IS_MAC=false
fi

# # at some point, I'll convert these for a linux based distros..
# # but for now I only use macos - so if anything else is used we will just kill
# # it
# if [ "$IS_MAC" = false ]; then
#  	## sh -c "$(curl -fsSL https://starship.rs/install.sh)"
# 	#sudo apt-get install -y fish git grc fzf
# fi

# if is mac
if [ "$IS_MAC" = true ]; then
	# brew needs to be installed and configured before anything else
	if ! [ -f "/usr/local/bin/brew" ]; then
		info "Installing homebrew"
		brew_script_location=$(mktemp)
		curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install --output "$brew_script_location"
		/usr/bin/ruby "$brew_script_location"
	fi

	# these pkgs are required for the bootstrap - after this we can run
	# most other pkgs are managed by brew/Brewfile
	brew install fish git starship
fi


SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
# run bootstrap - from now on the only shell we run is fish
$SCRIPT_DIR/bootstrap.fish
