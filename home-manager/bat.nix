{ config, pkgs, ... }:

{
  # Bat configuration with Catppuccin Macchiato theme
  programs.bat = {
    enable = true;
    
    # Configuration file content
    config = {
      theme = "Catppuccin Macchiato";
    };
  };
  
  # Install Catppuccin theme for bat
  home.activation.installBatTheme = config.lib.dag.entryAfter ["writeBoundary"] ''
    BAT_CONFIG_DIR="$(${pkgs.bat}/bin/bat --config-dir)"
    THEME_DIR="$BAT_CONFIG_DIR/themes"
    
    # Create themes directory if it doesn't exist
    mkdir -p "$THEME_DIR"
    
    # Download Catppuccin Macchiato theme if not already present
    if [ ! -f "$THEME_DIR/Catppuccin Macchiato.tmTheme" ]; then
      echo "Installing Catppuccin Macchiato theme for bat..."
      ${pkgs.curl}/bin/curl -sL -o "$THEME_DIR/Catppuccin Macchiato.tmTheme" \
        "https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Macchiato.tmTheme"
      
      # Rebuild bat cache
      ${pkgs.bat}/bin/bat cache --build
    fi
  '';
}