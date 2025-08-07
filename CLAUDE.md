# Development Guidelines

This file contains conventions and guidelines for contributing to this Nix-based dotfiles repository.

## Git Commit Conventions

This repository uses git-emoji conventions for commit messages with the format:

```
g<type> <scope>: <message>
```

### Available Types

- **feat**: New features or functionality
- **fix**: Bug fixes  
- **docs**: Documentation changes
- **style**: Code style changes (formatting, missing semicolons, etc.)
- **refactor**: Code refactoring without functionality changes
- **test**: Adding or modifying tests
- **chore**: Build process, tooling, or maintenance tasks
- **perf**: Performance improvements
- **ci**: Continuous integration changes
- **build**: Build system or external dependency changes
- **revert**: Reverting previous commits

### Example Commit Messages

```bash
gfeat nix: add Claude Code and Firefox packages
gfix fish: resolve plugin hash mismatches  
gdocs readme: update installation instructions
gtest packages: add tests for new GUI applications
gchore migration: remove temporary migration files
grefactor shell: consolidate Fish plugin configuration
```

## Package Management Guidelines

### Package Source Priority

1. **nixpkgs** (preferred) - Official Nix package repository
2. **brew-nix** (fallback) - When packages aren't available in nixpkgs
3. **fail** - Don't add packages that aren't available through either source

Before adding any package, always check nixpkgs availability:
```bash
nix search nixpkgs <package-name>
```

### Package Testing Requirements

All new packages must include comprehensive tests in the appropriate test file:

- System packages: `test/packages.test.fish`
- Fish configuration: `test/fish-config.test.fish`

Test format:
```fish
@test "<package> is available and working" (<command> --version | string match -q "<expected-output>")
```

## File Organization

### Core Configuration Files

- `flake.nix` - Main Nix flake configuration
- `darwin/` - macOS system-level configuration  
- `home-manager/` - User-level package and configuration management
- `test/` - Fishtape test suites

### Configuration Modules

- `home-manager/packages.nix` - User packages and CLI tools
- `home-manager/shell.nix` - Fish shell configuration and plugins
- `home-manager/default.nix` - Home Manager entry point and environment variables

## Testing

### Running Tests

```bash
make test          # Run all tests
make test-quick    # Run tests without slow container checks
```

### Test Categories

1. **Package Tests** - Verify installed packages work correctly
2. **Configuration Tests** - Verify Fish shell aliases, functions, and environment
3. **Integration Tests** - Verify complete system functionality

## Development Workflow

### Making Changes

1. Make your changes to the appropriate Nix files
2. Run tests to ensure everything works: `make test`
3. Build the configuration: `darwin-rebuild switch --flake .`
4. Write tests for any new packages or functionality
5. Commit using git-emoji conventions

### Adding New Packages

1. Check if available in nixpkgs: `nix search nixpkgs <package>`
2. Add to appropriate packages list in `home-manager/packages.nix` or `flake.nix`
3. Write tests in `test/packages.test.fish`
4. Run `make test` to verify
5. Commit with appropriate git-emoji message

### Plugin Management

Fish plugins are managed declaratively in `home-manager/shell.nix`. When adding plugins:

1. Use `nix-prefetch-github` to get correct hash
2. Add minimal, essential plugins only
3. Remove redundant plugins (prefer home-manager modules when available)
4. Test plugin functionality

## Architecture Decisions

### Why Nix Darwin + Home Manager?

- **Declarative Configuration** - All system state defined in code
- **Reproducible Environments** - Same configuration across machines  
- **Atomic Updates** - Changes are applied all-or-nothing
- **Multi-Profile Support** - Different configurations for work/personal

### Multi-Architecture Support

Configurations support both Intel and Apple Silicon Macs with architecture-specific packages:

```nix
] ++ lib.optionals (system == "x86_64-darwin") [
  # Intel Mac specific packages
  podman
  podman-compose
] ++ lib.optionals (system == "aarch64-darwin") [
  # Apple Silicon specific packages  
  brewCasks.orbstack
];
```

## Troubleshooting

### Common Issues

- **Hash Mismatches**: Use `nix-prefetch-github owner repo --rev <revision>` to get correct hash
- **Build Failures**: Check if package is available for your architecture
- **Plugin Conflicts**: Remove redundant plugins that conflict with home-manager modules

### Getting Help

1. Check existing issues and documentation
2. Run tests to isolate the problem
3. Verify configuration syntax with `nix flake check`
4. Review recent commit history for similar fixes

## Code Style

### Nix Code

- Use consistent indentation (2 spaces)
- Group related configuration logically  
- Add comments for complex or non-obvious configurations
- Use descriptive variable names

### Fish Code

- Follow Fish shell best practices
- Use functions over aliases for complex operations
- Keep configuration minimal and focused

## Security Considerations  

- Never commit secrets or API keys
- Use environment variables for sensitive configuration
- Regularly update package pins for security fixes
- Review package sources before adding dependencies