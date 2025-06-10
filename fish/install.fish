#!/usr/bin/env fish

if not grep -q "set fish_greeting" ~/.config/fish/config.fish
    echo "set fish_greeting" >>~/.config/fish/config.fish
end
