{ config, pkgs, lib, ... }:

{
  # Download and include Catppuccin themes for delta
  home.activation.installDeltaThemes = lib.hm.dag.entryAfter ["writeBoundary"] ''
    DELTA_THEMES_DIR="$HOME/.config/delta/themes"
    mkdir -p "$DELTA_THEMES_DIR"
    
    # Download catppuccin.gitconfig if not already present
    if [ ! -f "$DELTA_THEMES_DIR/catppuccin.gitconfig" ]; then
      echo "Installing Catppuccin themes for delta..."
      ${pkgs.curl}/bin/curl -sL -o "$DELTA_THEMES_DIR/catppuccin.gitconfig" \
        "https://github.com/catppuccin/delta/raw/main/catppuccin.gitconfig"
    fi
  '';
}