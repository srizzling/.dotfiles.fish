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
  };

  outputs = { self, nixpkgs, nix-darwin, home-manager, ... }:
  let
    mkDarwinSystem = system: hostName: profile: username: nix-darwin.lib.darwinSystem {
      inherit system;
      specialArgs = { inherit profile; };
      modules = [
        ./darwin
        # TODO: Re-enable home-manager after basic darwin setup works
        # home-manager.darwinModules.home-manager
        # {
        #   home-manager = {
        #     useGlobalPkgs = true;
        #     useUserPackages = true;
        #     extraSpecialArgs = { inherit profile; };
        #     users.${username} = { config, pkgs, profile, ... }: {
        #       home.username = "srizzling";
        #       home.homeDirectory = "/Users/srizzling";
        #       home.stateVersion = "25.05";
        #       programs.home-manager.enable = true;
        #       home.packages = with pkgs; [ bat ];
        #     };
        #   };
        # }
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