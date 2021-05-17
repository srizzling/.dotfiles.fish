#!/usr/bin/env fish

switch (uname)
case Darwin
	# https://github.com/koekeishiya/yabai
    # MacOS window manager
    brew install koekeishiya/formulae/yabai

    # https://github.com/stedolan/jq
    # Lightweight and flexible command-line JSON processor
    brew install jq

    # https://github.com/koekeishiya/skhd
    # Simple hotkey daemon for macOS
    brew install koekeishiya/formulae/skhd
end
