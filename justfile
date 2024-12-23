@_default:
    just --list --unsorted

# Run all recipes
run-all: reset-local-bin install build-readme

# Install all scripts in `bin/` to `~/.local/bin/`
install:
    mkdir -p ~/.local/bin
    ln -sf $(pwd)/bin/* ~/.local/bin

# Re-build the README Markdown file.
build-readme:
    quarto render README.qmd

reset-local-bin:
  find ~/.local/bin/* -name "spaid_" -delete
