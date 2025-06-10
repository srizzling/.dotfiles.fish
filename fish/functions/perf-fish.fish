#!/usr/bin/env fish

function perf-fish --description "time how long it takes for each shell invoke"
    for i in (seq 1 10)
        /usr/bin/time $SHELL -i -c exit
    end
end
