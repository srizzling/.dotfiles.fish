{
  description = "Test minimal nix-darwin config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nix-darwin, ... }: {
    darwinConfigurations."test" = nix-darwin.lib.darwinSystem {
      system = "x86_64-darwin";
      modules = [
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
        }
      ];
    };
  };
}