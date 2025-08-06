# Nix Darwin Dotfiles

Modern macOS dotfiles using Nix flakes, nix-darwin, and home-manager.

## Quick Start

### Fresh Machine Setup

1. **Clone the repository:**
   ```bash
   git clone https://github.com/srizzling/dotfiles-nix.git ~/.dotfiles
   cd ~/.dotfiles
   ```

2. **Bootstrap your configuration:**
   ```bash
   # Personal Intel Mac
   make bootstrap-personal-intel
   
   # Work Intel Mac  
   make bootstrap-work-intel
   
   # Personal Apple Silicon Mac
   make bootstrap-personal-arm
   
   # Work Apple Silicon Mac
   make bootstrap-work-arm
   
   # Or auto-detect architecture:
   make bootstrap-personal  # Auto-detects Intel vs ARM
   make bootstrap-work      # Auto-detects Intel vs ARM
   ```

3. **Restart your terminal** for all changes to take effect.

## Configuration Profiles

- **Personal Profile**: Personal git email, ~/development/personal directory
- **Work Profile**: Work git email, ~/development/work directory

## Management Commands

- `make switch` - Apply configuration changes
- `make update` - Update flake inputs and apply
- `make rollback` - Rollback to previous generation
- `make clean` - Clean old generations (keep last 5)
- `make help` - Show all available commands

## Architecture

This setup provides:

- **Multi-architecture support**: Intel (`x86_64-darwin`) + Apple Silicon (`aarch64-darwin`)
- **Profile-based configuration**: Work vs Personal contexts
- **System-level management**: macOS system preferences via nix-darwin
- **User-level management**: Applications and dotfiles via home-manager
- **Reproducible environments**: Declarative configuration with rollback capability

## System Settings

Automatically configures:
- **Dock**: Smaller size (32px), auto-hide, clean persistent apps
- **Scrolling**: Natural scrolling disabled
- **Finder**: Show path bar, status bar, file extensions
- **Trackpad**: Tap to click, three-finger drag

## Included Packages

Core CLI tools (migrated from devbox global):
- bat, curl, direnv, fd, fzf, git, git-absorb, delta, grc, gum, lsd, starship, wget, python3.10, zoxide

Additional tools:
- jq, ripgrep, tree, htop, gh (GitHub CLI), just

## Shell Configuration

- **Fish shell** with modern plugins and Catppuccin theme
- **Zoxide** for smart directory jumping (replaces z)
- **Starship** prompt with git integration
- **FZF** for fuzzy finding
- **Delta** for beautiful git diffs

## Git Configuration

- Profile-based user configuration (work vs personal email)
- Directory-based includes (`~/development/personal/` vs `~/development/work/`)
- Modern aliases and delta integration
- Conventional commit support

## Troubleshooting

- **Fish theme**: Run `fish_config theme save "Catppuccin Macchiato"` to set the theme
- **Rollback**: Use `make rollback` if something breaks
- **Clean slate**: Use `make clean` to remove old generations
- **Validation**: Use `make check` to validate configuration

## TODOs

- [ ] Update personal git name/email in `profiles/personal.nix`
- [ ] Update work git name/email in `profiles/work.nix`  
- [ ] Customize Homebrew apps in `darwin/homebrew.nix`
- [ ] Add application configurations (ghostty, aerospace, etc.)
- [ ] Set up testing framework