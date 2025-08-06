{ config, pkgs, profile, ... }:

{
  # Homebrew configuration
  homebrew = {
    enable = true;
    
    # Automatically run cleanup on activation
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
    };

    # Essential GUI applications not available in nixpkgs
    casks = [
      # Essential apps
      "1password"
      "raycast"
      
      # Development
      "visual-studio-code"
      "docker"
      
      # Communication
      "slack"
      "zoom"
      
      # Utilities
      "cleanmymac"
      "the-unarchiver"
    ];

    # Mac App Store apps
    masApps = {
      # Common Mac App Store applications
      # "Xcode" = 497799835;
    };

    # Homebrew taps
    taps = [
      "homebrew/cask"
      "homebrew/core"
      "homebrew/services"
    ];

    # Essential CLI tools that work better via Homebrew
    brews = [
      # Only include tools that aren't available or work better via Homebrew
      # Most CLI tools should be managed via Nix in home-manager
    ];
  };
}