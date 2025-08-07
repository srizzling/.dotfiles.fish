# Nix-based macOS Dotfiles

Modern, declarative macOS configuration using Nix Darwin + Home Manager with Fish shell, comprehensive package management, and beautiful Catppuccin theming.

## Quick Start

### Bootstrap
```bash
# Install Nix
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install

# Clone and setup
git clone https://github.com/srizzling/.dotfiles.fish.git ~/.dotfiles && cd ~/.dotfiles

# Bootstrap (auto-detects architecture)
make bootstrap-personal    # or make bootstrap-work
```

### Daily Commands
```bash
make switch      # Apply configuration changes
make update      # Update all packages  
make rollback    # Rollback to previous generation
make test        # Run all tests
make release     # Create new release
```

## Tools Included

### Development
- **Languages**: Python, Node.js, Go, Rust toolchains via devbox
- **CLI Tools**: git, gh, ripgrep, fd, fzf, jq, curl, wget, just
- **Development**: docker (podman), devbox, claude-code

### Terminal
- **Shell**: Fish with plugins, autosuggestions, git-emoji functions  
- **Terminal**: Ghostty (GPU-accelerated)
- **Prompt**: Starship with Git integration
- **Theme**: Catppuccin Macchiato everywhere
- **Tools**: bat, lsd, htop, tree, zoxide, direnv

### Applications  
- **Browser**: Firefox
- **Productivity**: Raycast (Spotlight replacement)

### System
- **Package Manager**: Nix (50+ tools) + brew-nix (GUI apps)
- **Configuration**: Declarative Nix files + Home Manager
- **Testing**: Comprehensive Fishtape test suite (51 tests)
- **Architecture**: Multi-profile support (Intel/Apple Silicon, work/personal)

## Architecture

- **Nix Darwin**: System-level macOS configuration
- **Home Manager**: User-level package and dotfile management  
- **Flakes**: Pin dependencies for reproducible builds
- **Multi-profile**: `personal-{intel,arm}`, `work-{intel,arm}` configurations
- **Testing**: All packages tested with Fish-based test runners

## Development

See [CLAUDE.md](./CLAUDE.md) for git-emoji commit conventions, release workflows, and development guidelines.