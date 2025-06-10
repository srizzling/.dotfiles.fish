#!/usr/bin/env fish
if test -e ~/.local/share/fonts/Inconsolata[wdth,wght].ttf ||
        test -e ~/Library/Fonts/Inconsolata[wdth,wght].ttf
    exit 0
end

function install
    curl -Lso $argv[1]/Inconsolata[wdth,wght].ttf https://github.com/google/fonts/raw/master/ofl/inconsolata/Inconsolata%5Bwdth%2Cwght%5D.ttf
end

switch (uname)
    case Darwin
        if brew list --cask font-iosevka >/dev/null 2>&1
            echo "font: isoevka already installed"
        else
            brew tap -q homebrew/cask-fonts
            and brew install --cask font-iosevka
        end

        if brew list --cask font-iosevka-nerd-font >/dev/null 2>&1
            echo "font: isoevka-nerd-font already installed"
        else
            brew tap -q homebrew/cask-fonts
            and brew install --cask font-iosevka-nerd-font
        end

    case '*'
        mkdir -p ~/.local/share/fonts/
        and install ~/.local/share/fonts/
        if command -qs fc-cache
            fc-cache -fv
        end
end
