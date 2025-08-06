{ config, pkgs, ... }:

{
  # Work profile configuration
  
  # Git configuration for work projects  
  programs.git = {
    userName = "Work Name";  # TODO: Replace with actual work name
    userEmail = "work@company.com";  # TODO: Replace with actual work email
  };

  # Work-specific environment variables
  home.sessionVariables = {
    # Add work-specific variables here
  };

  # Work-specific packages
  home.packages = with pkgs; [
    # Add work-only packages here
    # Example: kubectl, aws-cli, terraform, etc.
  ];
  
  # Create work development directory
  home.activation.createWorkDirs = config.lib.dag.entryAfter ["writeBoundary"] ''
    mkdir -p ~/development/work
  '';
}