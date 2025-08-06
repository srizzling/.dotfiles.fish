{
  description = "srizzling's macOS dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    brew-nix = {
      url = "github:BatteredBunny/brew-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nix-darwin, home-manager, brew-nix, ... }:
  let
    mkDarwinSystem = system: hostName: profile: username: nix-darwin.lib.darwinSystem {
      inherit system;
      specialArgs = { inherit profile; };
      modules = [
        ./darwin
        # Add brew-nix module
        brew-nix.darwinModules.default
        ({pkgs, ...}: {
          # Enable brew-nix
          brew-nix.enable = true;
          
          # Add system-level brew packages
          environment.systemPackages = with pkgs; [
            # brewCasks.whatsapp  # Temporary disabled due to download failure
            brewCasks.orbstack
            # brewCasks.microsoft-teams  # Temporary disabled due to packaging failure
          ];
        })
        # Re-enable home-manager with explicit Darwin configuration  
        home-manager.darwinModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "backup";  # Backup existing files
            extraSpecialArgs = { inherit profile; };
            users.${username} = { pkgs, lib, ... }: {
              imports = [ ./home-manager ];
              # Explicitly set homeDirectory for Darwin, forcing override
              home.homeDirectory = lib.mkForce "/Users/${username}";
              home.username = lib.mkForce username;
            };
          };
        }
      ];
    };
  in
  {
    # Multi-architecture and multi-profile support
    darwinConfigurations = {
      # Intel Mac - Personal
      "personal-intel" = mkDarwinSystem "x86_64-darwin" "personal-intel" "personal" "srizzling";
      # Intel Mac - Work  
      "work-intel" = mkDarwinSystem "x86_64-darwin" "work-intel" "work" "srizzling";
      # Apple Silicon - Personal
      "personal-arm" = mkDarwinSystem "aarch64-darwin" "personal-arm" "personal" "srizzling";
      # Apple Silicon - Work
      "work-arm" = mkDarwinSystem "aarch64-darwin" "work-arm" "work" "srizzling";
    };

    # Development shells for easy access
    devShells.x86_64-darwin.default = nixpkgs.legacyPackages.x86_64-darwin.mkShell {
      buildInputs = with nixpkgs.legacyPackages.x86_64-darwin; [ gnumake ];
    };
    devShells.aarch64-darwin.default = nixpkgs.legacyPackages.aarch64-darwin.mkShell {
      buildInputs = with nixpkgs.legacyPackages.aarch64-darwin; [ gnumake ];
    };
  };
}