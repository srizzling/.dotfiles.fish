#!/usr/bin/env fish

switch (uname)
case Darwin
	defaults write com.googlecode.iterm2 PrefsCustomFolder -string $DOTFILES_ROOT/iterm
	defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true
end
