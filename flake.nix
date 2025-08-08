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
    catppuccin.url = "github:catppuccin/nix";
  };

  outputs = { self, nixpkgs, nix-darwin, home-manager, brew-nix, catppuccin, ... }:
  let
    mkDarwinSystem = system: hostName: profile: username: nix-darwin.lib.darwinSystem {
      inherit system;
      specialArgs = { inherit profile system; };
      modules = [
        ./darwin
        # Add brew-nix module
        brew-nix.darwinModules.default
        ({pkgs, lib, system, ...}: {
          # Enable brew-nix  
          brew-nix.enable = true;
          
          # Add system-level packages (prefer nixpkgs, fallback to brew-nix)
          environment.systemPackages = with pkgs; [
            # Terminal emulator - using brew-nix due to build issues in nixpkgs
            brewCasks.ghostty
          ] ++ lib.optionals (system == "x86_64-darwin") [
            # Podman for Intel Macs (daemonless Docker alternative)
            podman
            podman-compose
          ] ++ lib.optionals (system == "aarch64-darwin") [
            # OrbStack for Apple Silicon Macs (only available via brew-nix)
            brewCasks.orbstack
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
              imports = [ 
                ./home-manager 
                catppuccin.homeModules.catppuccin
              ];
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