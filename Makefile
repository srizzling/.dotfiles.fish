# Nix Darwin Dotfiles Makefile
# Usage: make bootstrap-personal-intel (or bootstrap-work-arm, etc.)

# Detect architecture
ARCH := $(shell uname -m)
ifeq ($(ARCH),arm64)
    NIX_ARCH = aarch64-darwin
    ARCH_SUFFIX = arm
else
    NIX_ARCH = x86_64-darwin  
    ARCH_SUFFIX = intel
endif

# Configuration names
PERSONAL_INTEL_CONFIG = personal-intel
PERSONAL_ARM_CONFIG = personal-arm
WORK_INTEL_CONFIG = work-intel
WORK_ARM_CONFIG = work-arm

# Default target
.PHONY: help
help:
	@echo "Nix Darwin Dotfiles Management"
	@echo ""
	@echo "Bootstrap commands:"
	@echo "  make bootstrap-personal-intel  - Setup personal config on Intel Mac"
	@echo "  make bootstrap-personal-arm    - Setup personal config on Apple Silicon Mac"  
	@echo "  make bootstrap-work-intel      - Setup work config on Intel Mac"
	@echo "  make bootstrap-work-arm        - Setup work config on Apple Silicon Mac"
	@echo "  make bootstrap-personal        - Auto-detect arch, setup personal config"
	@echo "  make bootstrap-work           - Auto-detect arch, setup work config"
	@echo ""
	@echo "Management commands:"
	@echo "  make switch                   - Apply current configuration"
	@echo "  make update                   - Update flake inputs and apply"
	@echo "  make rollback                 - Rollback to previous generation"
	@echo "  make clean                    - Clean old generations (keep last 5)"
	@echo "  make rebuild                  - Rebuild without switching"
	@echo ""
	@echo "Installation commands:"
	@echo "  make install-nix              - Install Nix with flakes support"
	@echo "  make install-darwin           - Install nix-darwin"

# Check if Nix is installed
.PHONY: check-nix
check-nix:
	@command -v nix >/dev/null 2>&1 || { echo "Nix not found. Run 'make install-nix' first."; exit 1; }

# Install Nix with flakes support
.PHONY: install-nix
install-nix:
	@echo "Installing Nix with flakes support..."
	@curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
	@echo "Nix installed! Please restart your shell and run the bootstrap command again."

# Install nix-darwin
.PHONY: install-darwin
install-darwin: check-nix
	@echo "Installing nix-darwin..."
	@nix run nix-darwin -- switch --flake .
	@echo "nix-darwin installed!"

# Auto-detecting bootstrap commands
.PHONY: bootstrap-personal
bootstrap-personal: 
ifeq ($(ARCH_SUFFIX),arm)
	$(MAKE) bootstrap-personal-arm
else
	$(MAKE) bootstrap-personal-intel
endif

.PHONY: bootstrap-work
bootstrap-work:
ifeq ($(ARCH_SUFFIX),arm) 
	$(MAKE) bootstrap-work-arm
else
	$(MAKE) bootstrap-work-intel
endif

# Specific bootstrap commands
.PHONY: bootstrap-personal-intel
bootstrap-personal-intel:
	@echo "Bootstrapping personal configuration on Intel Mac..."
	@$(MAKE) _bootstrap CONFIG=$(PERSONAL_INTEL_CONFIG)

.PHONY: bootstrap-personal-arm  
bootstrap-personal-arm:
	@echo "Bootstrapping personal configuration on Apple Silicon Mac..."
	@$(MAKE) _bootstrap CONFIG=$(PERSONAL_ARM_CONFIG)

.PHONY: bootstrap-work-intel
bootstrap-work-intel:
	@echo "Bootstrapping work configuration on Intel Mac..."
	@$(MAKE) _bootstrap CONFIG=$(WORK_INTEL_CONFIG)

.PHONY: bootstrap-work-arm
bootstrap-work-arm:
	@echo "Bootstrapping work configuration on Apple Silicon Mac..."  
	@$(MAKE) _bootstrap CONFIG=$(WORK_ARM_CONFIG)

# Internal bootstrap implementation
.PHONY: _bootstrap
_bootstrap: check-nix
	@echo "Setting up $(CONFIG) configuration..."
	@# Install nix-darwin if not already installed
	@if ! command -v darwin-rebuild >/dev/null 2>&1; then \
		echo "Installing nix-darwin..."; \
		nix run nix-darwin -- switch --flake .#$(CONFIG); \
	else \
		echo "Applying $(CONFIG) configuration..."; \
		darwin-rebuild switch --flake .#$(CONFIG); \
	fi
	@echo "Bootstrap complete! Configuration $(CONFIG) is now active."
	@echo "You may need to restart your terminal for all changes to take effect."

# Apply current configuration (requires darwin-rebuild to be available)
.PHONY: switch
switch:
	@echo "Applying current configuration..."
	@darwin-rebuild switch --flake .

# Update flake inputs and apply
.PHONY: update
update:
	@echo "Updating flake inputs..."
	@nix flake update
	@echo "Applying updated configuration..."
	@darwin-rebuild switch --flake .

# Rollback to previous generation
.PHONY: rollback
rollback:
	@echo "Rolling back to previous generation..."
	@darwin-rebuild rollback

# Rebuild without switching
.PHONY: rebuild
rebuild:
	@echo "Building configuration..."
	@darwin-rebuild build --flake .

# Clean old generations (keep last 5)
.PHONY: clean
clean:
	@echo "Cleaning old generations (keeping last 5)..."
	@sudo nix-collect-garbage --delete-older-than 30d
	@nix-collect-garbage --delete-older-than 30d

# Show current generation and available rollback options
.PHONY: generations
generations:
	@echo "Current generation and rollback options:"
	@sudo nix-env --list-generations --profile /nix/var/nix/profiles/system

# Show flake info
.PHONY: info
info:
	@echo "Flake information:"
	@nix flake show

# Validate configuration without building
.PHONY: check
check:
	@echo "Checking flake configuration..."
	@nix flake check