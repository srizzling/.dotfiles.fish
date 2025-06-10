#!/usr/bin/env fish

# Install script for ghostty

# Check and delete the config file if it exists
set config_file "$HOME/Library/Application Support/com.mitchellh.ghostty/config"
if test -f $config_file
    echo "Deleting existing ghostty config file: $config_file"
    rm $config_file
    and echo "Deleted default ghostty config successfully."
    or echo "Failed to delete the config file."
end
