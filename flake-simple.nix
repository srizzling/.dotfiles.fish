{
  description = "srizzling's macOS dotfiles - simplified for testing";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nix-darwin, ... }: {
    darwinConfigurations."simple-test" = nix-darwin.lib.darwinSystem {
      system = "x86_64-darwin";
      modules = [
        ./darwin/system.nix
        {
          # Enable experimental features
          nix.settings.experimental-features = "nix-command flakes";
          
          # Auto upgrade nix package and the daemon service
          services.nix-daemon.enable = true;

          # Necessary for using flakes on this system
          nix.package = nixpkgs.legacyPackages.x86_64-darwin.nix;

          # Create /etc/zshrc that loads the nix-darwin environment
          programs.zsh.enable = true;
          programs.fish.enable = true;

          # Used for backwards compatibility
          system.stateVersion = 4;

          # System-wide environment variables
          environment.systemPath = [ "/opt/homebrew/bin" ];
          environment.pathsToLink = [ "/Applications" ];
        }
      ];
    };
  };
}