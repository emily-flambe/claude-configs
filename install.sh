#!/bin/bash
# Install Claude configs by symlinking to ~/.claude/

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="$HOME/.claude"

echo "Installing Claude configs from: $SCRIPT_DIR"
echo "Target directory: $CLAUDE_DIR"
echo

# Create ~/.claude if it doesn't exist
if [ ! -d "$CLAUDE_DIR" ]; then
    echo "Creating $CLAUDE_DIR..."
    mkdir -p "$CLAUDE_DIR"
fi

# Backup existing CLAUDE.md if it exists and is not a symlink
if [ -f "$CLAUDE_DIR/CLAUDE.md" ] && [ ! -L "$CLAUDE_DIR/CLAUDE.md" ]; then
    BACKUP="$CLAUDE_DIR/CLAUDE.md.backup.$(date +%Y%m%d_%H%M%S)"
    echo "Backing up existing CLAUDE.md to: $BACKUP"
    mv "$CLAUDE_DIR/CLAUDE.md" "$BACKUP"
fi

# Remove existing symlinks
for file in CLAUDE.md SECURITY.md SNOWFLAKE.md; do
    if [ -L "$CLAUDE_DIR/$file" ]; then
        echo "Removing existing symlink: $CLAUDE_DIR/$file"
        rm "$CLAUDE_DIR/$file"
    fi
done

# Create symlinks
echo
echo "Creating symlinks..."
for file in CLAUDE.md SECURITY.md SNOWFLAKE.md; do
    if [ -f "$SCRIPT_DIR/$file" ]; then
        ln -sf "$SCRIPT_DIR/$file" "$CLAUDE_DIR/$file"
        echo "  $file -> $SCRIPT_DIR/$file"
    fi
done

echo
echo "Installation complete!"
echo
echo "Your Claude Code configuration is now linked to this repository."
echo "Changes to files here will automatically apply to Claude Code."
