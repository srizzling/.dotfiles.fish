{ config, pkgs, lib, ... }:

{
  # Configure Raycast as Spotlight replacement
  
  # Create launch agent to start Raycast with system (alternative to login items)
  launchd.agents.raycast = {
    enable = true;
    config = {
      ProgramArguments = [ "/Applications/Nix Apps/Raycast.app/Contents/MacOS/Raycast" ];
      RunAtLoad = true;
      KeepAlive = true;
      ProcessType = "Interactive";
      Label = "com.raycast.macos";
    };
  };

  # Note: Raycast hotkey configuration is typically done through the app's preferences
  # The default Cmd+Space hotkey will be available once Spotlight is disabled via system preferences
  # Users should configure this in Raycast preferences: Raycast > Preferences > General > Raycast Hotkey
}