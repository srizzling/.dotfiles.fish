{ config, pkgs, profile, ... }:

{
  # Git configuration
  programs.git = {
    enable = true;
    
    # Basic configuration (profile-specific user info comes from profiles/)
    extraConfig = {
      init.defaultBranch = "main";
      push.default = "simple";
      push.autoSetupRemote = true;
      pull.rebase = true;
      rebase.autosquash = true;
      
      # Delta configuration for better diffs
      core = {
        editor = "code --wait";
        pager = "delta";
      };
      
      interactive.diffFilter = "delta --color-only";
      
      delta = {
        navigate = true;
        light = false;
        line-numbers = true;
        features = "catppuccin-macchiato";
      };
      
      merge.conflictstyle = "diff3";
      diff.colorMoved = "default";

      # Include files for different contexts
      include.path = [
        "~/.gitconfig.local"
        "~/.config/delta/themes/catppuccin.gitconfig"
      ];
      
      # Directory-based configuration
      "includeIf \"gitdir:~/development/personal/\"".path = "~/.gitconfig.personal";
      "includeIf \"gitdir:~/development/work/\"".path = "~/.gitconfig.work";
    };

    # Git aliases
    aliases = {
      st = "status";
      co = "checkout";
      br = "branch";
      ci = "commit";
      ca = "commit --amend";
      unstage = "reset HEAD --";
      last = "log -1 HEAD";
      visual = "!gitk";
      
      # More advanced aliases
      lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
      fixup = "!git log -n 50 --pretty=format:'%h %s' --no-merges | fzf | cut -c -7 | xargs -o git commit --fixup";
      
      # Workflow aliases
      sweep = "!git branch --merged | grep -v '\\*\\|main\\|master' | xargs -n 1 git branch -d";
      recent = "branch --sort=-committerdate";
    };
  };

  # Delta package for better git diffs
  home.packages = with pkgs; [ delta ];
}