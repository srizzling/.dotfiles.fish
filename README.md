# srizzling's Nix Darwin Dotfiles

A modern, declarative macOS configuration using Nix Darwin, Home Manager, and Fish shell with comprehensive package management and beautiful terminal theming.

## Features

- 🐟 **Fish Shell** - Fast, user-friendly shell with rich auto-suggestions
- ❄️ **Nix Package Management** - Declarative, reproducible system configuration
- 🎨 **Catppuccin Theming** - Beautiful, consistent theming across all tools
- 🚀 **48+ Pre-configured Tools** - Development tools, CLI utilities, and GUI applications
- ✅ **Comprehensive Testing** - Fishtape tests ensure everything works
- 🔧 **Multi-profile Support** - Personal and work configurations for Intel/Apple Silicon

## Quick Start

### Prerequisites

- macOS (Intel or Apple Silicon)
- Internet connection
- Administrator access

### Installation

1. **Install Nix with Determinate Systems installer** (includes flakes support):
```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

2. **Clone this repository**:
```bash
git clone https://github.com/srizzling/.dotfiles.fish.git ~/.dotfiles
cd ~/.dotfiles
```

3. **Bootstrap your system** (auto-detects architecture):
```bash
# For personal setup
make bootstrap-personal

# For work setup  
make bootstrap-work
```

That's it! The bootstrap process will:
- Install nix-darwin
- Configure your shell environment
- Install all packages
- Set up themes and configurations
- Configure Fish as your default shell

## Daily Usage

### Apply Configuration Changes
```bash
make switch
```

### Update All Packages
```bash
make update
```

### Rollback Changes
```bash
make rollback
```

### Run Tests
```bash
make test
```

## What's Included

### Terminal & Shell
- **Fish Shell** - Modern shell with autosuggestions
- **Starship Prompt** - Minimal, fast prompt with Git integration
- **Ghostty** - GPU-accelerated terminal emulator
- **Catppuccin Macchiato** - Beautiful dark theme

### Development Tools
- **Git** - Version control with delta diff viewer
- **GitHub CLI** - GitHub from the terminal
- **Devbox** - Isolated development environments
- **Just** - Command runner
- **Direnv** - Per-directory environment variables

### CLI Utilities
- **lsd** - Modern ls with icons and colors
- **bat** - Cat with syntax highlighting
- **fzf** - Fuzzy finder
- **ripgrep** - Fast grep alternative
- **fd** - Fast find alternative
- **zoxide** - Smart cd that learns
- **gum** - Glamorous shell scripts
- **jq** - JSON processor

### GUI Applications
- **Raycast** - Spotlight replacement
- **Aerospace** - Window manager
- **VSCode** - Code editor
- **Discord** - Communication
- **Spotify** - Music

### Container Tools (Intel)
- **Podman** - Docker alternative
- **Podman Compose** - Docker Compose alternative

## Configuration Structure

```
.
├── flake.nix           # Main Nix flake configuration
├── darwin/             # macOS system configuration
│   ├── default.nix     # System settings
│   ├── homebrew.nix    # Homebrew integration (disabled)
│   └── system.nix      # System defaults
├── home-manager/       # User configuration
│   ├── default.nix     # Home manager setup
│   ├── packages.nix    # Package list and configs
│   ├── shell.nix       # Fish shell configuration
│   └── git.nix         # Git configuration
├── profiles/           # Multi-profile support
│   ├── personal.nix    # Personal settings
│   └── work.nix        # Work settings
└── test/               # Fishtape tests
    ├── packages.test.fish
    └── fish-config.test.fish
```

## Profiles

The configuration supports multiple profiles for different machines:

- **personal-intel** - Personal Intel Mac
- **personal-arm** - Personal Apple Silicon Mac
- **work-intel** - Work Intel Mac
- **work-arm** - Work Apple Silicon Mac

Each profile can have:
- Different Git user configurations
- Profile-specific packages
- Custom environment variables

## Testing

Run comprehensive tests with:
```bash
make test
```

This runs 48+ Fishtape tests that verify:
- All packages are installed and working
- Fish configuration is correct
- PATH is properly configured
- Aliases and functions work
- Theme files are in place

## Troubleshooting

### Commands not found on first terminal open
This should be fixed, but if it happens:
```bash
# The PATH is now set at system level in /etc/fish/config.fish
# Try opening a completely new terminal window
```

### Ghostty font issues
The Iosevka Nerd Font is automatically installed. If you have issues:
```bash
# Check if font is installed
ls ~/Library/Fonts/*osevka*
```

### Permission issues
```bash
# Fix Nix store permissions if needed
sudo chown -R $(whoami) /nix
```

## Architecture Notes

- **Nix Darwin** manages system-level configuration
- **Home Manager** manages user-level configuration  
- **brew-nix** provides access to Homebrew casks without Homebrew
- **Profiles** allow for machine-specific configurations
- **System PATH** is set early in Fish initialization to avoid command not found errors

## Contributing

Feel free to fork and customize! The modular structure makes it easy to:
- Add/remove packages in `home-manager/packages.nix`
- Customize Fish in `home-manager/shell.nix`
- Add new profiles in `profiles/`
- Extend tests in `test/`

## Credits

Inspired by:
- [caarlos0/dotfiles.fish](https://github.com/caarlos0/dotfiles.fish) - Fish shell configuration
- [LnL7/nix-darwin](https://github.com/LnL7/nix-darwin) - Nix modules for Darwin
- [nix-community/home-manager](https://github.com/nix-community/home-manager) - User environment management
- [BatteredBunny/brew-nix](https://github.com/BatteredBunny/brew-nix) - Homebrew casks in Nix

## License

MIT