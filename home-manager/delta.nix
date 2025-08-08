{ config, pkgs, lib, ... }:

{
  # Configure delta with Catppuccin Macchiato theme
  programs.git.delta = {
    enable = true;
    options = {
      # Use Catppuccin Macchiato theme
      features = "catppuccin-macchiato";
      # Additional delta options for better display
      navigate = true;
      light = false;
      side-by-side = true;
      line-numbers = true;
    };
  };

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

  # Include the Catppuccin themes in git configuration
  programs.git.includes = [
    {
      path = "~/.config/delta/themes/catppuccin.gitconfig";
    }
  ];
}