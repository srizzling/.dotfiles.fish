{ config, pkgs, ... }:

{
  # Work profile configuration
  
  # Git configuration for work projects  
  programs.git = {
    userName = "Sriram Venkatesh";
    userEmail = "sriram.venkatesh@versent.com.au";  # Placeholder - update with actual work email
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