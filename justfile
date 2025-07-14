@_default:
    just --list --unsorted

# Run all recipes.
run-all: reset-local-bin executable install build-readme

# Install the pre-commit hooks
install-precommit:
  # Install pre-commit hooks
  uvx pre-commit install
  # Run pre-commit hooks on all files
  uvx pre-commit run --all-files
  # Update versions of pre-commit hooks
  uvx pre-commit autoupdate

# Set all files in `bin/` as executable
executable:
    chmod +x bin/*

# Install all scripts in `bin/` to `~/.local/bin/`.
install:
    mkdir -p ~/.local/bin
    ln -sf $(pwd)/bin/* ~/.local/bin

# Re-build the README Markdown file.
build-readme:
    quarto render README.qmd

# Clean up the 'local/bin' by removing the spaid commands.
reset-local-bin:
  find ~/.local/bin/* -name "spaid_" -delete
