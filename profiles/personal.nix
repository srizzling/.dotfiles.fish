{ config, pkgs, ... }:

{
  # Personal profile configuration
  
  # Git configuration for personal projects
  programs.git = {
    userName = "Personal Name";  # TODO: Replace with actual name
    userEmail = "personal@example.com";  # TODO: Replace with actual email
  };

  # Personal-specific environment variables
  home.sessionVariables = {
    # Add personal-specific variables here
  };

  # Personal-specific packages (if any)
  home.packages = with pkgs; [
    # Add personal-only packages here
  ];
  
  # Create personal development directory
  home.activation.createPersonalDirs = config.lib.dag.entryAfter ["writeBoundary"] ''
    mkdir -p ~/development/personal
  '';
}