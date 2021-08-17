#!/usr/bin/env fish
set -l node_versions_to_install v12 v14 v15 v16

for v in $node_versions_to_install
	nvm install $v
end

