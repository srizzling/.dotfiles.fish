{ config, pkgs, profile, ... }:

{
  # Homebrew configuration - simplified for testing
  homebrew = {
    enable = false;  # Disable Homebrew for now to avoid timeout issues
    
    # When re-enabled, use these settings:
    # onActivation = {
    #   autoUpdate = false;
    #   upgrade = false; 
    #   cleanup = "none";
    # };
    # 
    # casks = [
    #   "raycast"
    # ];
    #
    # taps = [];
    # brews = [];
    # masApps = {};
  };
}