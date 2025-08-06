{ config, pkgs, profile, ... }:

{
  # Fish shell configuration
  programs.fish = {
    enable = true;
    
    # Shell aliases
    shellAliases = {
      # Basic aliases
      ll = "lsd -la";
      la = "lsd -a";
      l = "lsd";
      tree = "lsd --tree";
      
      # Git aliases (basic ones, more complex ones in git config)
      gs = "git status";
      gd = "git diff";
      gl = "git log --oneline";
      
      # Nix/Darwin aliases  
      darwin-switch = "darwin-rebuild switch --flake ~/.dotfiles";
      darwin-rollback = "darwin-rebuild rollback";
    };

    # Fish functions
    functions = {
      # Custom greeting
      fish_greeting = {
        body = ''
          echo "🐟 Welcome to Fish shell!"
          echo "Profile: ${profile}"
          echo "System: $(uname -s) $(uname -m)"
        '';
      };
      
      # Quick git status
      gst = {
        body = "git status --short";
      };
    };

    # Fish plugins via Home Manager (cleaner than fisher)
    plugins = [
      # Essential plugins
      {
        name = "autopair";
        src = pkgs.fetchFromGitHub {
          owner = "jorgebucaran";
          repo = "autopair.fish";
          rev = "4d1752ff5b39819ab58d7337c69220342e9de0e2";
          sha256 = "qt3t1iKRRNuiLWiVoiAYOu+9E7jsyECyIqLJ/dIqI0s=";
        };
      }
      {
        name = "fzf-fish";
        src = pkgs.fetchFromGitHub {
          owner = "PatrickF1";
          repo = "fzf.fish";
          rev = "8920367cf85eee5218cc25a11e209d46e2591e7a";
          sha256 = "T8KYLA/r/gOKvAivKRoeqIwE2pINlxFQtZJHpOy9GMM=";
        };
      }
      {
        name = "bass";
        src = pkgs.fetchFromGitHub {
          owner = "edc";
          repo = "bass";
          rev = "50eba266b0d8a952c7230fca1114cbc9fbbdfbd4";
          sha256 = "+BN0wrA2ZivrtzNl0sD/LFE6OvhOVnEf6mjCRcMr8TQ=";
        };
      }
    ];

    # Catppuccin theme will be set manually via fish_config
    # as it's easier to manage interactively
  };

  # Starship prompt
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      # Basic starship config - can be expanded later
      format = "$all$character";
      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
      };
      directory = {
        truncation_length = 3;
        truncation_symbol = "…/";
      };
      git_branch = {
        symbol = "🌱 ";
      };
    };
  };
}