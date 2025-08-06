{ config, pkgs, profile, ... }:

{
  # Note: allowUnfree is configured at system level when using useGlobalPkgs
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
    
    # GUI Applications (official packages from nixpkgs)
    raycast
    aerospace
    # ghostty  # Temporarily disabled due to build issues
    discord
    vscode
    slack
    spotify
    # whatsapp-for-linux  # Removed - Linux only package causing build issues
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