@_default:
    just --list --unsorted

# Run all recipes.
run-all: check-commits check-spelling reset-local-bin executable install build-readme

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

# Run checks on commits with non-main branches
check-commits:
  #!/bin/zsh
  branch_name=$(git rev-parse --abbrev-ref HEAD)
  number_of_commits=$(git rev-list --count HEAD ^main)
  if [[ ${branch_name} != "main" && ${number_of_commits} -gt 0 ]]
  then
    uv run cz check --rev-range main..HEAD
  else
    echo "Can't either be on ${branch_name} or have more than ${number_of_commits}."
  fi

# Check for spelling errors in files
check-spelling:
  uv run typos
