#!/usr/bin/env fish
if command -q devbox
    devbox global shellenv --init-hook | source
end

