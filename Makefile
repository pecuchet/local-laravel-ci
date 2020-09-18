
# Use Bash syntax
SHELL:= /bin/bash

.PHONY: install
install:
	@# Use the git hooks in the repository instead of the default ones in .git
	@echo "Linking local .githooks directory..."
	@find .git/hooks -type l -exec rm {} \;
	@find ci/.githooks -type f -exec ln -sf ../../{} .git/hooks/ \;
	@chmod +x ci/.githooks/*

.PHONY: feature
feature:
	@# Create a feature branch
	@echo "Creating '$(name)' branch..."
	@git branch feature-$(name); git checkout feature-$(name)

.PHONY: fix
fix:
	@# Create a bug fix branch
	@echo "Creating '$(name)' branch..."
	@git branch fix-$(name); git checkout fix-$(name)

.PHONY: style
style:
	@# Fix code style issues
	@source ci/helpers.sh && echo_flag "Code styling"
	@./vendor/bin/php-cs-fixer -n fix --allow-risky=yes $(path)

.PHONY: test
test:
	@# Run the tests
	@source ci/helpers.sh && echo_flag "Running tests..."
	@./vendor/bin/phpunit --no-interaction tests

.PHONY: stan
stan:
	@# Run static code analysis
	@source ci/helpers.sh && echo_flag "Analysing code statically..."
	@./vendor/bin/phpstan analyse app/ --level=5

.PHONY: help
help:
	@echo "make init                   : Install new git hooks"
	@echo "make feature <feature-name> : Create a new feature branch and check it out"
	@echo "make fix <bug-name>         : Create a new bug fix branch and check it out"
	@echo "make style <path>           : Check and fix the code styling"
	@echo "make test                   : Run all tests"
	@echo "make stan                   : Run static analysis"
