#!/usr/bin/env fish
#
# bootstrap installs things.

set -gx DOTFILES_ROOT (pwd -P)
set -gx DOTFILES (pwd -P)


. ./fish/functions/_logging_functions.fish

function on_exit -p %self
    if not contains $argv[3] 0
        echo [(set_color --bold red) FAIL (set_color normal)] "Couldn't setup dotfiles"
    end
end

function link_winhome -d "links the windows home directory back to wsl"
    set -l USERPROFILE_DIRTY /mnt/(cmd.exe /c "echo %USERPROFILE%" 2>/dev/null | tr -d '\r')
    set -l USERPROFILE_DIRTY2 (string replace -a "\\" "/" $USERPROFILE_DIRTY)
    set -l USERPROFILE_DIRTY3 (string replace ":" "" $USERPROFILE_DIRTY2)
    set -Ux WINHOME (string lower $USERPROFILE_DIRTY3)
    ln -sf $WINHOME "$HOME/winhome"
end

function link_file -d "links a file keeping a backup"
    echo $argv | read -l old new backup
    if test -e $new
        set newf (readlink $new)
        if test "$newf" = "$old"
            success "skipped $old"
            return
        else
            mv $new $new.$backup
            and success moved $new to $new.$backup
            or abort "failed to backup $new to $new.$backup"
        end
    end
    mkdir -p (dirname $new)
    and ln -sf $old $new
    and success "linked $old to $new"
    or abort "could not link $old to $new"
end

function set_universal_vars
    set -Ux EDITOR vim
    set -Ux VISUAL $EDITOR
    set -Ux WEDITOR code

    set -Ux DOTFILES ~/.dotfiles.fish
    set -Ua fish_user_paths $DOTFILES/bin $HOME/.bin
end

function install_dotfiles
    # config files typically sit in .config/<>

    for src in $DOTFILES_ROOT/*/*.symlink
	set dir (string split -- / $src)[-2]
	mkdir -p $dir
        link_file $src $HOME/.config/$dir/(basename $src .symlink) backup
        or abort 'failed to link config file'
    end

    for src in $DOTFILES_ROOT/*/.*.symlink
	link_file $src $HOME/.(basename $src .symlink) backup
    end

    for f in $DOTFILES/*/conf.d/*.fish
        ln -sf $f ~/.config/fish/conf.d/(basename $f)
    end

    # link up config files
    link_file $DOTFILES_ROOT/fisher/plugins $__fish_config_dir/fish_plugins backup
    or abort plugins
end

function is_wsl
    switch (uname -a)
        case '*WSL*'
            return 0
        case '*Microsoft*'
            return 0
        case '*'
            return 1
    end
end

is_wsl
and link_winhome
and set -Ux IS_WSL 0

set_universal_vars

curl -sL git.io/fisher | source && fisher install jorgebucaran/fisher
and success 'fisher'
or abort 'fisher'

install_dotfiles
and success 'dotfiles'
or abort 'dotfiles'

fisher update
and success 'plugins'
or abort 'plugins'

mkdir -p ~/.config/fish/completions/
and success 'completions'
or abort 'completions'

for installer in */install.fish
    $installer
    and success $installer
    or abort $installer
end

if ! grep (command -v fish) /etc/shells
    command -v fish | sudo tee -a /etc/shells
    and success 'added fish to /etc/shells'
    or abort 'setup /etc/shells'
end