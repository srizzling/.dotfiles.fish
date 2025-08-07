# Fishtape test runner for Nix packages
.PHONY: help test test-packages test-fish-config test-all test-legacy

help: ## Show available commands
	@echo "🐟 Fishtape Testing Suite"
	@echo "========================"
	@echo ""
	@echo "Available commands:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

test: ## Run all Fishtape tests (recommended)
	@echo "🐟 Running Fishtape tests..."
	fish -i -c "fishtape packages.test.fish fish-config.test.fish; exit"

test-packages: ## Run package availability tests  
	@echo "🏠 Testing Nix packages with Fishtape..."
	fish -i -c "fishtape packages.test.fish; exit"

test-fish-config: ## Run Fish configuration tests
	@echo "🐚 Testing Fish shell configuration..."
	fish -i -c "fishtape fish-config.test.fish; exit"

test-all: ## Run all tests (Fishtape + legacy)
	@echo "🌟 Running all tests..."
	$(MAKE) test
	@echo ""
	@echo "📜 Running legacy test script for comparison..."
	$(MAKE) test-legacy

test-legacy: ## Run the legacy test-packages.sh script
	@echo "📜 Testing with legacy script..."
	./test-packages.sh