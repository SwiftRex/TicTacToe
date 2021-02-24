.PHONY: all prebuild mint lint-check lint-check-ci lint-autocorrect code-gen unit-tests
.DEFAULT_GOAL := help

prebuild: code-gen lint-autocorrect lint-check
all: mint prebuild unit-tests

# Mint bootstrap

mint:
	command -v mint || brew install mint
	mint bootstrap

# Lint

lint-check:
	mint run swiftlint --config ./.swiftlint.yml

lint-check-ci:
	mint run -s swiftlint lint --config ./.swiftlint.yml --strict --reporter 'json' --quiet > 'swiftlint.result.json'

lint-autocorrect:
	mint run swiftlint autocorrect --config ./.swiftlint.yml

# Code Generation

code-gen:
	mint run sourcery --config GameLogic/.sourcery.yml

# Unit Test

unit-tests:
	swift test
