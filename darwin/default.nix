{ config, pkgs, profile, ... }:

{
  imports = [
    ./homebrew.nix
    ./system.nix
  ];

  # Enable experimental features
  nix.settings.experimental-features = "nix-command flakes";
  
  # Auto upgrade nix package and the daemon service
  services.nix-daemon.enable = true;

  # Necessary for using flakes on this system
  nix.package = pkgs.nix;

  # Create /etc/zshrc that loads the nix-darwin environment
  programs.zsh.enable = true;
  programs.fish.enable = true;

  # Set Git commit hash for darwin-version
  system.configurationRevision = config.rev or config.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  # The platform the configuration will be used on
  # This will be set by the flake based on the system parameter
}