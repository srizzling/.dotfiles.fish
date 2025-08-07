# Changelog

All notable changes to this project will be documented in this file.

## [v3.0.0] - 2025-08-07

### Added
- **Complete Nix Darwin Migration**: Full transition from traditional Fish shell setup to Nix Darwin + Home Manager
- **Manual Release Control**: Added Cocogitto for manual release management replacing GitHub Actions auto-tagging
- **Claude Code Integration**: Added Claude Code CLI and Firefox browser packages
- **Comprehensive Testing**: 51 Fishtape tests ensuring all packages and configurations work properly
- **Multi-Architecture Support**: Intel/Apple Silicon configurations with architecture-specific packages
- **Git-Emoji Conventions**: Fish functions for consistent conventional commit messages
- **Development Guidelines**: Complete CLAUDE.md with workflow documentation

### Changed  
- **Simplified README**: Reduced from 206 to 62 lines, focusing on bootstrap, daily usage, tools, and architecture
- **Manual Release Process**: Use `make release` instead of automatic tagging
- **Package Management**: Prefer nixpkgs over brew-nix, with comprehensive testing for all packages

### Fixed
- **Plugin Hash Issues**: Resolved Fish plugin hash mismatches with proper nix-prefetch-github usage
- **Configuration Issues**: Fixed Fish PATH initialization and plugin conflicts
- **Release Workflows**: Proper GoReleaser configuration without discussion requirements

## [v2.0.0] - 2025-08-07

### Added
- **Automated GoReleaser Workflow**: Professional release management with changelogs
- **GitHub Actions Integration**: Automated tag creation and release publishing

### Fixed
- **Workflow Configuration**: Removed discussion requirements that were blocking releases
- **CI Pipeline**: Added workflow_dispatch trigger for manual release control

## [v1.2.0] - 2024-06-18

### Added
- **Git Configuration**: Global git settings management

### Fixed
- **Ghostty Configuration**: Fixed macOS-specific setup issues

## [v1.1.1] - 2024-06-11

### Fixed
- **Window Management**: Fixed Aerospace and Ghostty window rendering issues
- **Terminal Styling**: Added proper window padding for better visual experience

## [v1.1.0] - 2024-06-11

### Added
- **Aerospace Integration**: Window management with Ghostty workspace assignment
- **Documentation**: Bootstrap instructions in README

### Fixed
- **Ghostty Configuration**: Resolved font loading and configuration issues

## [v1.0.0] - 2024-06-04

### Added
- **Aerospace Window Manager**: Tiling window manager for macOS
- **Fish Shell Plugins**: Project management and productivity plugins
- **Homebrew Management**: Automated package management and cask installation
- **Multi-Architecture Support**: Configurations for both Intel and Apple Silicon Macs
- **Development Tools**: Git configuration, aliases, and productivity tools

### Fixed
- **Package Management**: Resolved multiple package installation and configuration issues
- **Shell Configuration**: Fixed Fish shell PATH and plugin loading issues
- **Cross-Platform Compatibility**: Ensured proper functionality across different Mac architectures

---

For detailed commit history and technical changes, see the [GitHub releases](https://github.com/srizzling/.dotfiles.fish/releases).