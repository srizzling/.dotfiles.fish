{ config, pkgs, profile, ... }:

{
  # Fish shell configuration
  programs.fish = {
    enable = true;
    
    # Set PATH early before aliases are loaded (for both login and non-login shells)
    shellInit = ''
      # Add Nix system-wide packages to PATH
      fish_add_path --prepend /run/current-system/sw/bin
      fish_add_path --prepend /nix/var/nix/profiles/default/bin
      fish_add_path --prepend /etc/profiles/per-user/srizzling/bin
    '';
    
    # Also set PATH for login shells
    loginShellInit = ''
      # Add Nix system-wide packages to PATH
      fish_add_path --prepend /run/current-system/sw/bin
      fish_add_path --prepend /nix/var/nix/profiles/default/bin
      fish_add_path --prepend /etc/profiles/per-user/srizzling/bin
    '';
    
    # Additional interactive shell configuration
    interactiveShellInit = ''
      # Add vendor functions for fzf and other tools
      set -p fish_function_path /etc/profiles/per-user/srizzling/share/fish/vendor_functions.d
      set -p fish_function_path ${pkgs.fzf}/share/fish/vendor_functions.d
      
      # Set Catppuccin Macchiato theme (only if not already set)
      if not test -f ~/.config/fish/themes/current_theme
        fish_config theme save "Catppuccin Macchiato" >/dev/null 2>&1 || true
        echo "Catppuccin Macchiato" > ~/.config/fish/themes/current_theme
      end
      
      # Configure fzf.fish to use delta for diff highlighting
      set -gx fzf_diff_highlighter delta --paging=never --width=20
    '';
    
    # Shell aliases
    shellAliases = {
      # Basic aliases
      ls = "lsd";
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
      
      # Container aliases for Docker compatibility
      docker = "podman";
      docker-compose = "podman-compose";
    };

    # Fish functions (removed greeting and gst as requested)
    functions = {};

    # Fish plugins via Home Manager (minimal essential plugins only)
    plugins = [
      # Catppuccin theme for Fish
      {
        name = "catppuccin-fish";
        src = pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "fish";
          rev = "0ce27b518e8ead555dec34dd8be3df5bd75cff8e";
          sha256 = "sha256-Dc/zdxfzAUM5NX8PxzfljRbYvO9f9syuLO8yBr+R3qg=";
        };
      }
      # fish-git-emojis - Git commit emojis
      {
        name = "fish-git-emojis";
        src = pkgs.fetchFromGitHub {
          owner = "srizzling";
          repo = "fish-git-emojis";
          rev = "d2625158356bd03a94f9c32b022225412c37fe60";
          sha256 = "sha256-KuV5oGRbC4Enry2Al1EP4X38bH9qIUSWPND7gRwkpUo=";
        };
      }
      # fzf.fish - Better fzf integration
      {
        name = "fzf.fish";
        src = pkgs.fetchFromGitHub {
          owner = "patrickf1";
          repo = "fzf.fish";
          rev = "8920367cf85eee5218cc25a11e209d46e2591e7a";
          sha256 = "sha256-T8KYLA/r/gOKvAivKRoeqIwE2pINlxFQtZJHpOy9GMM=";
        };
      }
    ];

    # Catppuccin theme will be set manually via fish_config
    # as it's easier to manage interactively
  };

  # Starship prompt - full configuration from dotfiles repo
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      character = {
        error_symbol = "[λ](red)";
        success_symbol = "[λ](purple)";
      };
      aws = {
        format = " [$symbol($profile )(\\($region\\) )(\\[$duration\\])]($style)";
        style = "242";
        region_aliases = {
          "ap-southeast-2" = "ase2";
          "us-east-1" = "use1";
          "us-west-2" = "usw2";
        };
      };
      azure = {
        disabled = false;
        format = "[$symbol($subscription)]($style) ";
        style = "242";
        symbol = "󰠅 ";
      };
      hostname = {
        style = "242";
      };
      cmake.disabled = true;
      cmd_duration = {
        format = " [$duration]($style)";
        min_time = 500;
      };
      conda.disabled = true;
      crystal.disabled = true;
      dart.disabled = true;
      directory = {
        read_only = " 🔒";
        style = "blue";
        truncate_to_repo = true;
        truncation_length = 0;
      };
      docker_context.disabled = true;
      dotnet.disabled = true;
      elixir.disabled = true;
      elm.disabled = true;
      env_var.disabled = true;
      erlang.disabled = true;
      gcloud.disabled = true;
      git_branch = {
        format = "[$symbol](red)[($branch)]($style)";
        style = "242";
        symbol = "";
      };
      git_status = {
        ahead = "[⇡](cyan)";
        behind = "[⇣](cyan)";
        diverged = "[⇡⇣](cyan)";
        format = "([$modified $ahead_behind]($style))";
        modified = "[*](218)";
        stashed = "[≡](cyan)";
      };
      golang.disabled = true;
      helm.disabled = true;
      java.disabled = true;
      jobs.disabled = true;
      julia.disabled = true;
      kotlin.disabled = true;
      kubernetes.disabled = true;
      lua.disabled = true;
      nim.disabled = true;
      nix_shell.disabled = true;
      nodejs.disabled = true;
      ocaml.disabled = true;
      openstack.disabled = true;
      package.disabled = true;
      perl.disabled = true;
      php.disabled = true;
      purescript.disabled = true;
      python.disabled = true;
      ruby.disabled = true;
      rust.disabled = true;
      scala.disabled = true;
      shlvl.disabled = true;
      singularity.disabled = true;
      swift.disabled = true;
      terraform.disabled = true;
      vagrant.disabled = true;
      zig.disabled = true;
    };
  };
}