{ config, pkgs, ... }:

{
  # Enable Catppuccin theming with Macchiato flavor
  catppuccin = {
    enable = true;
    flavor = "macchiato";
    
    # Configure individual programs with Catppuccin theme
    bat.enable = true;
    delta.enable = true;
    firefox.enable = true;
    fzf.enable = true;
    starship.enable = true;
    fish.enable = true;
    vscode.profiles.default.enable = true;
    spotify-player.enable = true;
  };
}