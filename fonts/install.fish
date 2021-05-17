#!/usr/bin/env fish

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
