# Nix Migration Plan for Dotfiles

## Overview
This plan outlines the migration from the current Fish-based dotfiles to a Nix flakes + home-manager setup for macOS. The goal is to use proper Nix idioms while removing unused components and improving maintainability.

## Components Analysis

### ✅ Components to Keep (macOS-compatible)
- **aerospace** - macOS tiling window manager
- **brew** - Package management (via nix-darwin homebrew module)  
- **devbox** - Development environments (replaced by Nix dev-shells per project)
- **editorconfig** - Cross-platform editor configuration
- **fish** - Shell configuration (managed by home-manager)
- **fonts** - Font installation (via home-manager fonts module)
- **ghostty** - Terminal emulator configuration
- **git** - Git configuration (via home-manager git module)
- **lsd** - Modern ls replacement
- **starship** - Cross-shell prompt
- **vim** - Text editor configuration

### ❌ Components to Remove
- **alacritty** - Replaced by ghostty
- **sway** - Wayland compositor (Linux-specific)
- **kanshi** - Wayland display configuration  
- **waybar** - Wayland status bar
- **wofi** - Wayland launcher
- **vscode-custom** - VS Code extensions now managed by settings sync
- **wallpaper** - macOS manages wallpapers natively
- **WSL-specific code** in bootstrap.fish

### 📦 Package Migration from Devbox Global
Current devbox global packages to migrate to Nix:
- bat, curl, direnv, fd, fzf, git, git-absorb, delta, grc, gum, lsd, starship, wget, python3.10, zoxide

### 🐠 Fish Plugin Cleanup
Remove unused plugins:
- `dracula/fish` - Switching to Catppuccin theme
- `jorgebucaran/nvm.fish` - Not needed with Nix
- `srizzling/taxi-fish` - Unused
- `paldepind/projectdo` - Unused

Keep essential plugins (with changes):
- ~~`jethrokuan/z`~~ → **zoxide** (managed by home-manager, better performance)
- `jorgebucaran/autopair.fish`, `oh-my-fish/plugin-grc`, `srizzling/fish-git-emojis`, `edc/bass`, `catppuccin/fish`, `patrickf1/fzf.fish`, `halostatue/fish-direnv`

## Proposed Nix Structure

```
.
├── flake.nix                 # Main flake configuration
├── flake.lock               # Locked dependencies
├── Makefile                 # Bootstrap and management commands
├── darwin/                  # nix-darwin system configuration
│   ├── default.nix
│   ├── homebrew.nix        # Homebrew packages
│   ├── system.nix          # macOS system settings (dock, scrolling, etc.)
│   └── defaults.nix        # Additional system defaults
├── home-manager/           # User environment configuration
│   ├── default.nix
│   ├── packages.nix        # User packages
│   ├── fish.nix           # Fish shell configuration  
│   ├── git.nix            # Git configuration (with profile support)
│   ├── ghostty.nix        # Ghostty terminal config
│   └── starship.nix       # Starship prompt config
├── profiles/               # Work vs Personal configuration
│   ├── personal.nix       # Personal-specific settings
│   └── work.nix           # Work-specific settings  
├── modules/                # Reusable Nix modules
│   ├── aerospace.nix      # AeroSpace window manager
│   └── fonts.nix          # Font configuration
└── tests/                  # Testing configuration
    ├── test.nix           # Test suite
    └── ci.nix             # CI configuration
```

## Nix Flake Design

### Main flake.nix Structure
```nix
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

  outputs = { nixpkgs, nix-darwin, home-manager, ... }:
  let
    mkDarwinSystem = system: hostName: profile: nix-darwin.lib.darwinSystem {
      inherit system;
      specialArgs = { inherit profile; };
      modules = [
        ./darwin
        home-manager.darwinModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit profile; };
          home-manager.users.username = import ./home-manager;
        }
      ];
    };
  in {
    # Multi-architecture and multi-profile support
    darwinConfigurations = {
      # Intel Mac - Personal
      "personal-intel" = mkDarwinSystem "x86_64-darwin" "personal-intel" "personal";
      # Intel Mac - Work  
      "work-intel" = mkDarwinSystem "x86_64-darwin" "work-intel" "work";
      # Apple Silicon - Personal
      "personal-arm" = mkDarwinSystem "aarch64-darwin" "personal-arm" "personal";
      # Apple Silicon - Work
      "work-arm" = mkDarwinSystem "aarch64-darwin" "work-arm" "work";
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
```

## Configuration Strategy

### 1. Package Management
- **System packages**: via nix-darwin (system-wide tools)
- **User packages**: via home-manager (user-specific tools)  
- **Homebrew**: Only for packages not available in nixpkgs (GUI apps)
- **Development tools**: Project-specific via `devbox` or nix develop shells

### 2. Fish Shell Configuration
- Shell managed by home-manager's `programs.fish` module
- **Zoxide** enabled via home-manager instead of z plugin
- Plugins managed via home-manager instead of fisher
- Custom functions migrated to Nix configuration
- Theme set to "Catppuccin Macchiato" via `fish_config theme save`

### 3. Git Configuration  
- Use home-manager's `programs.git` module
- **Profile-based configuration**: work vs personal email addresses
- Include current git aliases and configuration
- Conditional git config based on profile parameter

### 4. Application Configurations
- **Ghostty**: Direct config file via home-manager
- **AeroSpace**: Custom Nix module for configuration
- **Starship**: home-manager's `programs.starship` module
- **Fonts**: home-manager's `fonts.fontconfig` module

### 5. macOS System Settings
- **Natural Scrolling**: Disable via `system.defaults.NSGlobalDomain."com.apple.swipescrolldirection" = false`
- **Dock**: Configure smaller size and auto-hide via nix-darwin system defaults:
  - `system.defaults.dock.tilesize = 32` (smaller dock icons)
  - `system.defaults.dock.autohide = true` (hide dock by default)
  - `system.defaults.dock.autohide-delay = 0.0` (no delay when showing)
  - `system.defaults.dock.autohide-time-modifier = 0.2` (faster animation)

## Testing Strategy

### 1. Automated Tests
- **Nix evaluation tests**: Ensure all configurations evaluate without errors
- **Build tests**: Test that all packages can be built
- **Integration tests**: Test that configurations apply correctly
- **CI/CD**: GitHub Actions to test on push/PR

### 2. Manual Testing Checklist
- [ ] Shell functions work correctly
- [ ] Git configuration applied properly
- [ ] Terminal appearance matches expected theme
- [ ] Window management (AeroSpace) functions
- [ ] All CLI tools accessible and working
- [ ] Font rendering correct

### 3. Rollback Strategy
- Keep current dotfiles as backup branch
- Use nix-darwin generations for easy rollback
- Document manual rollback procedures

## Bootstrap Process

### Fresh Machine Setup
Simple git clone and make approach:

```bash
# Clone repository
git clone https://github.com/srizzling/dotfiles-nix.git ~/.dotfiles
cd ~/.dotfiles

# Bootstrap based on your setup
make bootstrap-personal-intel    # Intel Mac - Personal
make bootstrap-work-intel        # Intel Mac - Work  
make bootstrap-personal-arm      # Apple Silicon - Personal
make bootstrap-work-arm          # Apple Silicon - Work

# Or auto-detect architecture
make bootstrap-personal          # Auto-detects Intel vs ARM
make bootstrap-work             # Auto-detects Intel vs ARM
```

### Makefile Targets
**Bootstrap commands:**
- `make bootstrap-personal-intel` - Setup personal config on Intel Mac
- `make bootstrap-personal-arm` - Setup personal config on Apple Silicon Mac  
- `make bootstrap-work-intel` - Setup work config on Intel Mac
- `make bootstrap-work-arm` - Setup work config on Apple Silicon Mac
- `make bootstrap-personal` - Auto-detect architecture, setup personal config
- `make bootstrap-work` - Auto-detect architecture, setup work config

**Management commands:**
- `make switch` - Apply current configuration (darwin-rebuild switch)
- `make update` - Update flake inputs and apply
- `make rollback` - Rollback to previous generation
- `make clean` - Clean old generations (keep last 5)
- `make rebuild` - Build configuration without switching
- `make generations` - Show current generation and rollback options
- `make check` - Validate flake configuration
- `make info` - Show flake information

**Installation commands:**
- `make install-nix` - Install Nix with flakes support (Determinate Systems installer)
- `make install-darwin` - Install and configure nix-darwin

### Profile Configuration

**Personal Profile (`profiles/personal.nix`):**
- Git user email: personal email
- Development directories: ~/development/personal
- Personal SSH keys and configurations

**Work Profile (`profiles/work.nix`):** 
- Git user email: work email
- Development directories: ~/development/work  
- Work-specific SSH keys and configurations
- Additional work tools if needed

## Migration Steps

### Phase 1: Setup Nix Infrastructure
1. Install Nix with flakes support
2. Install nix-darwin
3. Create basic flake.nix structure
4. Set up home-manager integration

### Phase 2: Package Migration
1. Migrate devbox global packages to Nix
2. Set up Homebrew integration for GUI apps
3. Test package availability and functionality

### Phase 3: Configuration Migration
1. Migrate Fish shell configuration
2. Migrate Git configuration  
3. Migrate terminal (Ghostty) configuration
4. Migrate prompt (Starship) configuration
5. Set up AeroSpace window manager

### Phase 4: Cleanup & Optimization
1. Remove unused components and files
2. Clean up Fish plugins
3. Remove WSL-specific code
4. Set up automated testing

### Phase 5: Documentation & Maintenance
1. Create usage documentation
2. Set up update procedures
3. Document troubleshooting steps

## Profile-Based Configuration Details

### Git Configuration Example
```nix
# profiles/personal.nix
{
  git = {
    userEmail = "personal@example.com";
    userName = "Personal Name";
    extraConfig = {
      "includeIf \"~/development/personal/**\"".path = "~/.gitconfig.personal";
    };
  };
}

# profiles/work.nix  
{
  git = {
    userEmail = "work@company.com";
    userName = "Work Name";
    extraConfig = {
      "includeIf \"~/development/work/**\"".path = "~/.gitconfig.work";
    };
  };
}
```

### Profile Selection
- Configuration selected based on `profile` parameter passed to `mkDarwinSystem`
- Profiles can override any home-manager or darwin configuration
- Easy switching between work/personal contexts
- Maintains current directory-based git config pattern

## Multi-Architecture Support

### Architecture Detection
- Automatic architecture detection in bootstrap script
- Separate configurations for `x86_64-darwin` (Intel) and `aarch64-darwin` (Apple Silicon)
- Same configuration logic, different binary packages when needed
- Unified codebase supports both architectures

### Current Machine Setup
- Your current Intel machine: use `work-intel` or `personal-intel` configuration
- Future Apple Silicon machines: use `work-arm` or `personal-arm` configuration

## Benefits of Nix Migration

1. **Reproducible Environment**: Exact same environment across machines
2. **Atomic Updates**: Safe updates with automatic rollback capability
3. **Multi-Architecture**: Single codebase supports Intel + Apple Silicon
4. **Profile-Based**: Easy work/personal context switching
5. **One-Command Setup**: Bootstrap fresh machines with single command
6. **Dependency Management**: Proper handling of tool dependencies
7. **Version Pinning**: Control exact versions of all tools
8. **Declarative Configuration**: Infrastructure as code approach
9. **Cross-Machine Consistency**: Same configuration across different Macs
10. **Easier Maintenance**: Single source of truth for all configurations

## Considerations

1. **Learning Curve**: Nix has a steep learning curve
2. **Flake Experimental Status**: Flakes are still experimental
3. **Package Availability**: Some packages might not be in nixpkgs
4. **Binary Cache**: Some packages might need to build from source
5. **Integration Complexity**: Some applications might need special handling

## Success Criteria

- [ ] All current functionality preserved
- [ ] Environment reproducible on fresh macOS install
- [ ] Update process simpler than current setup
- [ ] All unused components removed
- [ ] Automated testing in place
- [ ] Documentation complete
- [ ] Performance equal or better than current setup

This migration will result in a modern, maintainable, and reproducible dotfiles setup using Nix best practices while preserving all essential functionality for macOS development.