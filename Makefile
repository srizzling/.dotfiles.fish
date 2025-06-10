# Makefile for linting dotfiles

.PHONY: lint lint-fish lint-yaml lint-json lint-shell

lint: lint-fish lint-yaml lint-json lint-shell

lint-fish:
	@echo "Linting Fish scripts..."
	@find . -name '*.fish' -exec fish --no-execute {} \;
	@find . -name '*.fish' -exec fish_indent -w {} \;

lint-yaml:
	@echo "Linting YAML files..."
	@find . -name '*.yml' -o -name '*.yaml' -exec yamllint {} \;

lint-json:
	@echo "Linting JSON files..."
	@find . -name '*.json' -exec jsonlint -q {} \;

lint-shell:
	@echo "Linting Shell scripts..."
	@find . -path './.devbox' -prune -o -name '*.sh' -exec shellcheck {} \;

