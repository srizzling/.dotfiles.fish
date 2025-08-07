{ config, pkgs, lib, profile, system, ... }:

{
  # Homebrew is disabled - using brew-nix instead for better integration
  homebrew = {
    enable = false;
  };
}