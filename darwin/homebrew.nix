{ config, pkgs, profile, ... }:

{
  # Homebrew configuration
  homebrew = {
    enable = true;
    
    # Conservative settings to avoid timeouts
    onActivation = {
      autoUpdate = false;    # Don't auto-update during activation
      upgrade = false;       # Don't upgrade during activation  
      cleanup = "none";      # Don't cleanup during activation
    };

    # Essential GUI applications not available in nixpkgs
    casks = [
      # Essential apps
      "raycast"
      
      # Development
      "visual-studio-code"
      "orbstack"  # Docker replacement
      
      # Communication  
      "slack"
      
      # Window management and terminal
      "nikitabobko/tap/aerospace"  # Window manager
      "ghostty"  # Terminal emulator
    ];

    # Mac App Store apps
    masApps = {
      # Add Mac App Store apps as needed
      # "Xcode" = 497799835;
    };

    # Required taps for specific packages
    taps = [
      "nikitabobko/tap"  # For aerospace window manager
    ];

    # Essential CLI tools that work better via Homebrew
    # Most CLI tools should be managed via Nix in home-manager
    brews = [];
  };
}