#!/usr/bin/env fish

if not type -q devbox
    curl -fsSL https://get.jetify.com/devbox | bash
    devbox global pull git@github.com:srizzling/devbox-global.git
end
