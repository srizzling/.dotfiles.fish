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

    # Fish plugins via Home Manager - simplified for now
    plugins = [
      # Will add plugins back after testing basic functionality
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