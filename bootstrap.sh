#!/bin/sh

# Install mise (polyglot tool version manager) if missing.
# mise is preferred over asdf for the reasons outlined in the README.
if ! command -v mise >/dev/null 2>&1; then
    echo "Installing mise via Homebrew..."
    if command -v brew >/dev/null 2>&1; then
        brew install mise
    else
        echo "Error: mise is required but Homebrew is not installed."
        echo "Install Homebrew first (https://brew.sh) and re-run this script."
        exit 1
    fi
fi

ln -sFfi "$(PWD)"/.tmux.conf ~/.tmux.conf
ln -sFfi "$(PWD)"/config.fish ~/.config/fish/config.fish

# Hardlink for kitty config
ln -Ffi "$(PWD)"/kitty.conf ~/.config/kitty/kitty.conf
ln -sFfi "$(PWD)"/starship.toml ~/.config/starship.toml

# Link Claude Configs
ln -sFfi "$(PWD)"/claude/CLAUDE.md ~/.claude/CLAUDE.md
# Merge claude config.json into settings.json (overwrites existing keys)
if ! command -v claude >/dev/null 2>&1; then
    echo "Error: Claude Code is required but not installed"
    exit 1
fi
if ! command -v jq >/dev/null 2>&1; then
    echo "Error: jq is required but not installed"
    exit 1
fi
mkdir -p ~/.claude
tmpfile="$HOME/.claude/settings.json.tmp"
if jq -s '.[1] * .[0]' ~/.claude/settings.json "$(PWD)"/claude/config.json > "$tmpfile" 2>/dev/null; then
    mv "$tmpfile" ~/.claude/settings.json
else
    rm -f "$tmpfile"
    echo "Error: Failed to merge Claude settings"
    exit 1
fi
