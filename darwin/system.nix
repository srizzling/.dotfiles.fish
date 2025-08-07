{ config, pkgs, profile, ... }:

{
  # System preferences
  system.defaults = {
    # Dock settings
    dock = {
      tilesize = 32;                    # Smaller dock icons
      autohide = true;                  # Auto-hide dock
      autohide-delay = 0.0;            # No delay when showing
      autohide-time-modifier = 0.2;    # Faster animation
      persistent-apps = [];             # Clean dock - let user customize
      show-recents = false;            # Don't show recent applications
    };

    # Global system settings
    NSGlobalDomain = {
      # Disable natural scrolling
      "com.apple.swipescrolldirection" = false;
      
      # Key repeat settings
      KeyRepeat = 2;
      InitialKeyRepeat = 15;
      
      # Other useful defaults
      "com.apple.trackpad.scaling" = 1.0;
      "com.apple.mouse.tapBehavior" = 1;
    };

    # Finder settings
    finder = {
      ShowPathbar = true;
      ShowStatusBar = true;
      FXEnableExtensionChangeWarning = false;
      FXPreferredViewStyle = "Nlsv";    # List view
      AppleShowAllExtensions = true;
    };

    # Trackpad settings
    trackpad = {
      Clicking = true;                  # Tap to click
      TrackpadThreeFingerDrag = true;   # Three finger drag
    };

    # Menu bar settings
    menuExtraClock = {
      ShowSeconds = true;
      ShowDate = 1;                     # Show date
    };

    # Custom system preferences for settings not available as direct options
    CustomUserPreferences = {
      # Disable Spotlight keyboard shortcut (Cmd+Space) to allow Raycast to take over
      "com.apple.symbolichotkeys" = {
        AppleSymbolicHotKeys = {
          # Spotlight search shortcut (Cmd+Space)
          "64" = {
            enabled = false;
          };
          # Spotlight search shortcut (alternative key)  
          "65" = {
            enabled = false;
          };
        };
      };
    };
  };

  # System-wide environment variables
  environment.systemPath = [ "/opt/homebrew/bin" ];
  environment.pathsToLink = [ "/Applications" ];
}