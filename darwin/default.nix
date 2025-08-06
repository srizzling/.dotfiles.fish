{ config, pkgs, profile, ... }:

{
  imports = [
    ./homebrew.nix
    ./system.nix
  ];

  # Enable experimental features
  nix.settings.experimental-features = "nix-command flakes";
  
  # Nix daemon is now managed unconditionally when nix.enable is on

  # Necessary for using flakes on this system
  nix.package = pkgs.nix;

  # Create /etc/zshrc that loads the nix-darwin environment
  programs.zsh.enable = true;
  programs.fish.enable = true;

  # Set Git commit hash for darwin-version
  system.configurationRevision = config.rev or config.dirtyRev or null;

  # Set the primary user for system defaults
  system.primaryUser = "srizzling";
  
  # Fix for nix build user group ID mismatch
  ids.gids.nixbld = 350;

  # Used for backwards compatibility, please read the changelog before changing
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  # The platform the configuration will be used on
  # This will be set by the flake based on the system parameter
}