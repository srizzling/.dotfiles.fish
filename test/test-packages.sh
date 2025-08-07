#!/bin/sh

# Test script to validate all Nix packages work correctly
# Supports both Intel (amd64) and Apple Silicon (arm64)

set -e

echo "🐳 Starting Nix Dotfiles Test Suite"
echo "Architecture: ${ARCH:-unknown}"
echo "Build Platform: ${BUILD_PLATFORM:-unknown}"
echo "================================"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Test result counters
PASSED=0
FAILED=0
TOTAL=0

# Function to run a test
run_test() {
    local test_name="$1"
    local test_command="$2"
    local expected_pattern="$3"
    
    TOTAL=$((TOTAL + 1))
    printf "${BLUE}Testing ${test_name}...${NC} "
    
    if output=$(eval "$test_command" 2>&1); then
        if [ -n "$expected_pattern" ] && ! echo "$output" | grep -q "$expected_pattern"; then
            printf "${RED}FAIL${NC} (unexpected output)\n"
            echo "  Expected pattern: $expected_pattern"
            echo "  Got: $output"
            FAILED=$((FAILED + 1))
        else
            printf "${GREEN}PASS${NC}\n"
            PASSED=$((PASSED + 1))
        fi
    else
        printf "${RED}FAIL${NC} (command failed)\n"
        echo "  Error: $output"
        FAILED=$((FAILED + 1))
    fi
}

# Determine architecture-specific configuration
case "${ARCH}" in
    "amd64")
        SYSTEM="x86_64-linux"
        CONFIG_NAME="personal-intel"
        echo "📊 Testing Intel/AMD64 configuration"
        ;;
    "arm64")
        SYSTEM="aarch64-linux" 
        CONFIG_NAME="personal-arm"
        echo "📊 Testing ARM64/Apple Silicon configuration"
        ;;
    *)
        echo "⚠️  Unknown architecture: ${ARCH}, defaulting to AMD64"
        SYSTEM="x86_64-linux"
        CONFIG_NAME="personal-intel"
        ;;
esac

echo "🔧 System: $SYSTEM"
echo "🎯 Config: $CONFIG_NAME"
echo ""

# Test Nix installation and flake evaluation
echo "${YELLOW}=== Nix Setup Tests ===${NC}"
run_test "Nix installation" "nix --version" "nix"
run_test "Flake evaluation" "cd /Users/srizzling/dev/.dotfiles.fish && nix flake check --no-build" ""

# Install fish shell for testing (since we can't test Darwin modules in Linux)
echo ""
echo "${YELLOW}=== Installing Fish Shell ===${NC}"
run_test "Fish installation" "nix-shell -p fish --run 'fish --version'" "fish"

# Test individual packages that should work on Linux
echo ""
echo "${YELLOW}=== Core Utilities Tests ===${NC}"
run_test "bat" "nix-shell -p bat --run 'bat --version'" "bat"
run_test "curl" "nix-shell -p curl --run 'curl --version'" "curl"
run_test "fd" "nix-shell -p fd --run 'fd --version'" "fd"
run_test "fzf" "nix-shell -p fzf --run 'fzf --version'" "0."
run_test "direnv" "nix-shell -p direnv --run 'direnv --version'" "2."

echo ""
echo "${YELLOW}=== Git Tools Tests ===${NC}"
run_test "git" "nix-shell -p git --run 'git --version'" "git version"
run_test "git-absorb" "nix-shell -p git-absorb --run 'git-absorb --version'" "git-absorb"
run_test "delta" "nix-shell -p delta --run 'delta --version'" "delta"
run_test "gh (GitHub CLI)" "nix-shell -p gh --run 'gh --version'" "gh version"

echo ""
echo "${YELLOW}=== Shell Tools Tests ===${NC}"
run_test "lsd" "nix-shell -p lsd --run 'lsd --version'" "lsd"
run_test "starship" "nix-shell -p starship --run 'starship --version'" "starship"
run_test "zoxide" "nix-shell -p zoxide --run 'zoxide --version'" "zoxide"
run_test "grc" "nix-shell -p grc --run 'grc --version'" "Generic Colouriser"
run_test "gum" "nix-shell -p gum --run 'gum --version'" "gum"

echo ""
echo "${YELLOW}=== Development Tools Tests ===${NC}"
run_test "wget" "nix-shell -p wget --run 'wget --version'" "GNU Wget"
run_test "python3" "nix-shell -p python310 --run 'python --version'" "Python 3"
run_test "jq" "nix-shell -p jq --run 'jq --version'" "jq-"
run_test "ripgrep" "nix-shell -p ripgrep --run 'rg --version'" "ripgrep"
run_test "tree" "nix-shell -p tree --run 'tree --version'" "tree v"
run_test "htop" "nix-shell -p htop --run 'htop --version'" "htop"
run_test "just" "nix-shell -p just --run 'just --version'" "just"

# Test Container Tools (Docker/Podman)
echo ""
echo "${YELLOW}=== Container Tools Tests ===${NC}"
run_test "podman" "nix-shell -p podman --run 'podman --version'" "podman version"
run_test "podman-compose" "nix-shell -p podman podman-compose --run 'podman-compose version'" "podman-compose"
run_test "docker (fallback)" "nix-shell -p docker --run 'docker --version'" "Docker version"

# Test fish configuration (simulate)
echo ""
echo "${YELLOW}=== Fish Configuration Test ===${NC}"
FISH_CONFIG_TEST='fish -c "
    # Simulate our PATH additions
    fish_add_path --prepend /nix/var/nix/profiles/default/bin
    echo \"Fish PATH test successful\"
"'
run_test "Fish PATH configuration" "nix-shell -p fish --run '$FISH_CONFIG_TEST'" "Fish PATH test successful"

# Architecture-specific tests
echo ""
echo "${YELLOW}=== Architecture-Specific Tests ===${NC}"
if [ "$ARCH" = "amd64" ]; then
    echo "🖥️  Testing Intel-specific packages..."
    run_test "Podman for Intel" "nix-shell -p podman --run 'podman --help'" "Usage:"
elif [ "$ARCH" = "arm64" ]; then
    echo "🍎 Testing ARM64-specific packages..."
    # Note: OrbStack is macOS-only, so we can't test it in Linux containers
    echo "   ℹ️  OrbStack testing skipped (macOS-only)"
fi

# Summary
echo ""
echo "${YELLOW}=== Test Summary ===${NC}"
echo "📊 Total tests: $TOTAL"
echo "✅ Passed: $PASSED"
echo "❌ Failed: $FAILED"

if [ $FAILED -eq 0 ]; then
    echo ""
    echo "${GREEN}🎉 All tests passed! Nix configuration is working correctly.${NC}"
    exit 0
else
    echo ""
    echo "${RED}💥 $FAILED test(s) failed. Please check the configuration.${NC}"
    exit 1
fi