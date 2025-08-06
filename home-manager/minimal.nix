{ config, pkgs, profile, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage
  home.username = "srizzling";
  home.homeDirectory = "/Users/srizzling";

  # This value determines the Home Manager release that your
  # configuration is compatible with
  home.stateVersion = "25.05";

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;

  # Just a basic package to test
  home.packages = with pkgs; [
    bat
  ];
}