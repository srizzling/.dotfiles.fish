{ config, pkgs, profile, ... }:

{
  # User packages - migrated from devbox global
  home.packages = with pkgs; [
    # Core utilities (from devbox global)
    bat
    curl
    direnv
    fd
    fzf
    git
    git-absorb
    delta
    grc
    gum
    lsd
    starship
    wget
    python310
    zoxide

    # Additional useful packages
    jq
    ripgrep
    tree
    htop
    
    # Development tools
    gh  # GitHub CLI
    just  # Command runner
  ];

  # Enable direnv integration
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # Configure zoxide (better z)
  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  # Configure fzf
  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
  };

  # Configure bat
  programs.bat = {
    enable = true;
    config = {
      theme = "base16";  # Use a standard theme for now
      style = "numbers,changes,header";
    };
  };
}