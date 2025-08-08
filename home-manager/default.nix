{ config, pkgs, profile, ... }:

{
  imports = [
    ./packages.nix
    ./shell.nix
    ./git.nix
    ./bat.nix
    ./delta.nix
    ./aerospace.nix
    ./raycast.nix
    ./ghostty.nix
    ./lsd.nix
    ../profiles/${profile}.nix
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage  
  # Note: username and homeDirectory are set in flake.nix

  # This value determines the Home Manager release that your
  # configuration is compatible with
  home.stateVersion = "25.05";

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;

  # Basic shell setup
  home.sessionVariables = {
    EDITOR = "vim";
    VISUAL = "code";
    WEDITOR = "code";
    BAT_THEME = "Catppuccin Macchiato";
  };

  # XDG directories
  xdg.enable = true;
}