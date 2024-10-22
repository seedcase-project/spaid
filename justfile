@_default:
    just --list --unsorted

# Install all scripts in `bin/` to `~/.local/bin/`
install:
    mkdir -p ~/.local/bin
    ln -s $(pwd)/bin/* ~/.local/bin