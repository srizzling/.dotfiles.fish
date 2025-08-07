# 🧪 Nix Package Testing

Simple testing for validating that Nix packages are properly installed and working.

## 📁 Files

- `test-packages.sh` - Shell script that validates all Nix packages
- `Makefile` - Simple test runner
- `README.md` - This documentation

## 🚀 Quick Start

### Prerequisites

- Nix with flakes enabled
- The dotfiles applied with `make switch`

### Running Tests

```bash
# Run the test script directly
./test-packages.sh

# Or via make
make test-packages
```

## 🧩 What Gets Tested

### Core Utilities
- `bat` - Syntax highlighting cat clone
- `curl` - HTTP client
- `fd` - Fast find alternative
- `fzf` - Fuzzy finder
- `direnv` - Environment management

### Git Tools
- `git` - Version control
- `git-absorb` - Auto-fixup commits
- `delta` - Git diff viewer
- `gh` - GitHub CLI

### Shell Tools
- `lsd` - Modern ls replacement
- `starship` - Cross-shell prompt
- `zoxide` - Smart cd replacement
- `grc` - Generic colorizer
- `gum` - Glamorous shell scripts

### Development Tools
- `wget` - HTTP downloader
- `python3` - Python interpreter
- `jq` - JSON processor
- `ripgrep` - Fast grep alternative
- `tree` - Directory tree viewer
- `htop` - Process viewer
- `just` - Command runner

### Container Tools
- `podman` - Daemonless container engine (Docker alternative)
- `podman-compose` - Multi-container applications
- `docker` - Fallback Docker CLI (if available)

## 🏗️ Architecture Support

### Intel/AMD64 (`x86_64-linux`)
- Tests Podman container engine
- Validates all command-line tools
- Simulates `personal-intel` and `work-intel` configurations

### Apple Silicon/ARM64 (`aarch64-linux`)
- Tests ARM64 package availability
- Validates cross-platform compatibility
- Simulates `personal-arm` and `work-arm` configurations

## 🤖 GitHub Actions

The test suite automatically runs on:

- **Push** to `main`, `feat/*`, `fix/*` branches
- **Pull requests** to `main`
- **Weekly schedule** (Sundays at 2 AM UTC) to catch nixpkgs updates

### Test Matrix
- Multi-architecture testing (Intel + ARM64)
- Flake evaluation validation
- Docker Compose configuration testing
- Package availability verification

## 📊 Test Output

The test script provides colored output:
- 🟢 **PASS** - Test succeeded
- 🔴 **FAIL** - Test failed with details
- 🟡 **INFO** - Informational messages
- 🔵 **TEST** - Currently running test

Example output:
```
🐳 Starting Nix Dotfiles Test Suite
Architecture: amd64
Build Platform: linux/amd64
================================

📊 Testing Intel/AMD64 configuration
🔧 System: x86_64-linux
🎯 Config: personal-intel

=== Core Utilities Tests ===
Testing bat... ✓ PASS
Testing curl... ✓ PASS
Testing fd... ✓ PASS
...

=== Test Summary ===
📊 Total tests: 25
✅ Passed: 25
❌ Failed: 0

🎉 All tests passed! Nix configuration is working correctly.
```

## 🛠️ Troubleshooting

### Docker Issues
```bash
# Ensure Docker is running
docker info

# Check multi-arch support
docker buildx ls
```

### Nix Issues
```bash
# Check flake evaluation locally
nix flake check --no-build

# Test individual packages
nix-shell -p bat --run 'bat --version'
```

### Testing Without Docker
```bash
# Run test script directly (requires Nix)
./test-packages.sh
```

## 🔄 Development

To add new packages to test:

1. Add the package to `home-manager/packages.nix`
2. Add a test case to `test-packages.sh` in the appropriate section
3. Update this README with the new package
4. Run tests to verify functionality

## 🐟 Fish Testing with Fishtape

For more comprehensive Fish shell testing, consider using **Fishtape** - the Fish equivalent of Bats:

```bash
# Install fishtape
fisher install jorgebucaran/fishtape

# Example test file: functions.test.fish
@test "custom function works" (my_function arg) = "expected output"
@test "PATH includes nix bins" (echo $PATH | string match -q "*nix*")

# Run tests
fishtape functions.test.fish
```

### Fishtape Features
- **TAP compliant** - Standard test output format
- **Test isolation** - Each test runs in clean shell
- **Easy assertions** - Simple syntax for common checks
- **CI/CD friendly** - Works great in GitHub Actions

## 📝 Notes

- Current script tests package availability and versions
- For Fish function testing, use Fishtape framework
- Tests focus on CLI tool functionality