#!/usr/bin/env fish

if ! command -qs vim
    exit 0
end

if test -e ~/.vim/bundle/Vundle.vim
    exit 0
end

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
