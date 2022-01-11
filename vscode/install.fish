#!/usr/bin/env fish

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
    case '*fedora*'
        set vscode_home "$HOME/.var/app/com.visualstudio.code/config/Code"
        mkdir -p "$vscode_home/User"
        and ln -sf "$DOTFILES/vscode/settings.json" "$vscode_home/User/settings.json"
    case 'Linux*'
        set vscode_home "$HOME/.config/Code"
        mkdir -p "$vscode_home/User"
        and ln -sf "$DOTFILES/vscode/settings.json" "$vscode_home/User/settings.json"
end


cat $DOTFILES/vscode/extensions.txt | while read module
    switch (uname -a)
        case '*fedora*'
            flatpak run com.visualstudio.code --list-extensions | grep -qw "$module"
            or flatpak run com.visualstudio.code --install-extension "$module"
        case '*'
            code --list-extensions | grep -qw "$module"
            or code --install-extension "$module"
    end
end
