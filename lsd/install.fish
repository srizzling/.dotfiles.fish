#!/usr/bin/env fish

if command -qa lsd
    abbr -a ls 'lsd'
    abbr -a l 'ls -l'
    abbr -a la 'ls -a'
    abbr -a lt 'ls --tree'
end
