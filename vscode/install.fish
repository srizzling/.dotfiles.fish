#!/usr/bin/env fish

if ! command -qs code
    exit 0
end


switch (uname -a)
    case 'Darwin*'
        set vscode_home "$HOME/Library/Application Support/Code"
        mkdir -p $vscode_home
        and ln -sf "$DOTFILES/vscode/settings.json" "$vscode_home/User/settings.json"
    case '*WSL*'
        # this may seem like a gross hack and it is but since
        # windows doesn't support symlinks we need to copy the settings files
        # so just run ./bootstrap.sh each time this file updates
        set vscode_home "$WINHOME/AppData/Roaming/Code/"
        mkdir -p $vscode_home
        and cp "$DOTFILES/vscode/settings.json" "$vscode_home/User/settings.json"
    case '*Microsoft*'
        # this may seem like a gross hack and it is but since
        # windows doesn't support symlinks we need to copy the settings files
        # so just run ./bootstrap.sh each time this file updates
        set vscode_home "$WINHOME/AppData/Roaming/Code/"
        mkdir -p $vscode_home
        and cp "$DOTFILES/vscode/settings.json" "$vscode_home/User/settings.json"
    case 'Linux*'
        set vscode_home "$HOME/.config/Code"
        mkdir -p $vscode_home
        and ln -sf "$DOTFILES/vscode/settings.json" "$vscode_home/User/settings.json"
end

set -l extensions (code --list-extensions)
cat $DOTFILES/vscode/extensions.txt | while read module
	echo $extensions | grep -qw "$module"
		or code --install-extension "$module"
end
