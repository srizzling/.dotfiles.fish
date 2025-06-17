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

function setup_gitconfig
    set managed (git config --global --get dotfiles.managed)
    # if there is no user.email, we'll assume it's a new machine/setup and ask it
    if test -z (git config --global --get user.email)
        user 'What is your github author name?'
        read user_name
        user 'What is your github author email?'
        read user_email

        test -n $user_name
        or echo "please inform the git author name"
        test -n $user_email
        or abort "please inform the git author email"

        git config --global user.name $user_name
        and git config --global user.email $user_email
        or abort 'failed to setup git user name and email'
    else if test '$managed' = true
        # if user.email exists, let's check for dotfiles.managed config. If it is
        # not true, we'll backup the gitconfig file and set previous user.email and
        # user.name in the new one
        set user_name (git config --global --get user.name)
        and set user_email (git config --global --get user.email)
        and mv ~/.gitconfig ~/.gitconfig.backup
        and git config --global user.name $user_name
        and git config --global user.email $user_email
        and success "moved ~/.gitconfig to ~/.gitconfig.backup"
        or abort 'failed to setup git user name and email'
    else
        # otherwise this gitconfig was already made by the dotfiles
        info "already managed by dotfiles"
    end
    # finally make git knows this is a managed config already, preventing later
    # overrides by this script

    # include the gitconfig.local file
    touch ~/.gitconfig.local
    and git config --global include.path ~/.gitconfig.local
    and success "created and linked ~/.gitconfig.local"

    # personal .gitconfig file which wi
    git config --global includeIf.gitdir:~/development/personal/.path ~/.gitconfig.personal
    and git config --global alias.fixup "!git log -n 50 --pretty=format:'%h %s' --no-merges | fzf | cut -c -7 | xargs -o git commit --fixup"
    and git config --global dotfiles.managed true
    and git config --global rebase.autosquash true
    and git config --global push.autoSetupRemote true
    and git config --global push.default simple
    and git config --global pull.rebase true
    and git config --global core.editor "code --wait"
    and git config --global core.pager delta
    and git config --global alias.cob "!git checkout $(git branch | fzf)"
    and git config --global alias.cleanup "!f() { \
        git checkout $(basename $(git symbolic-ref --short refs/remotes/origin/HEAD)); \
        git pull; \
        git fetch -p; \
        git branch -vv | grep 'origin/.*: gone]' | grep -v '^+' | awk '{print $1}' | xargs git branch -D; \
    }; f"
    and git config --global interactive.diffFilter "delta --color-only"
    and git config --global delta.navigate true
    and git config --global merge.conflictstyle diff3
    and git config --global diff.colorMoved default
    and git config --global init.defaultBranch main
    and success "set up git config"
    or abort 'failed to setup git'
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

    for f in $DOTFILES/*/functions
        set -Up fish_function_path $f
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

function get_hostname
    set -l lhostname (hostname)
    echo $lhostname
end

function link_host_specific_files -d "Links host-specific configuration files"
    set -l lhostname (get_hostname)

    for src in $DOTFILES_ROOT/*/*.symlink
        set dir (string split -- / $src)[-2]
        set base (basename $src .symlink)
        set host_specific_file $DOTFILES_ROOT/$dir/$base.$lhostname.symlink

        if test -f $host_specific_file
            link_file $host_specific_file $HOME/.config/$dir/$base backup
        else
            link_file $src $HOME/.config/$dir/$base backup
        end
    end
end

function set_host_specific_aliases -d "Sets host-specific aliases"
    set -l lhostname (get_hostname)
    set -l alias_file "$DOTFILES/aliases.$lhostname.fish"

    if test -f $alias_file
        source $alias_file
        success "aliases for $hostname"
    else
        info "no aliases for $hostname"
    end
end


# create default directories
mkdir -p ~/development
and mkdir -p ~/development/personal
and mkdir -p ~/development/work
and success 'created ~/development directories'
or abort 'failed to create ~/development directories'

is_wsl
and link_winhome
and set -Ux IS_WSL 0

set_universal_vars

curl -sL git.io/fisher | source && fisher install jorgebucaran/fisher
and success fisher
or abort fisher

setup_gitconfig
and success gitconfig
or abort gitconfig

install_dotfiles
and success dotfiles
or abort dotfiles

fisher update
and success plugins
or abort plugins

link_host_specific_files
set_host_specific_aliases

mkdir -p ~/.config/fish/completions/
and success completions
or abort completions

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

test (which fish) = $SHELL
and success 'dotfiles installed/updated!'
and exit 0

# the exit 0 is required for this to run in github actions - since the macos
# runner is passwordless - the assumption is that this should pass locally
chsh -s (which fish)
and success set (fish --version) as the default shell.
and exit 0
