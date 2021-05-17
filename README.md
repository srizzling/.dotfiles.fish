#
function info
	echo [(set_color --bold) ' .. ' (set_color normal)] $argv
end

function success
	echo [(set_color --bold green) ' OK ' (set_color normal)] $argv
end

function fail
	echo [(set_color --bold red) ' FAIL ' (set_color normal)] $argv
end