#!/bin/bash
# Dotfiles manager
# Usage: ./setup.sh [diff|apply|save]

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Define mappings: "local_path:target_path" (relative to script dir)
FILES=(
  ".bash_profile:$HOME/.bash_profile"
  ".bashrc:$HOME/.bashrc"
  ".gitconfig:$HOME/.gitconfig"
  ".gitignore_global:$HOME/.gitignore_global"
  ".wezterm.lua:$HOME/.wezterm.lua"
  "vscode/settings.json:$APPDATA/Code/User/settings.json"
  "vscode/keybindings.json:$APPDATA/Code/User/keybindings.json"
  "claude/settings.json:$HOME/.claude/settings.json"
)

cmd_diff() {
  for mapping in "${FILES[@]}"; do
    local="${mapping%%:*}"
    target="${mapping##*:}"
    src="$SCRIPT_DIR/$local"
    if [[ -f "$target" ]]; then
      if ! diff -q "$src" "$target" > /dev/null 2>&1; then
        echo "=== $local <-> $target ==="
        diff --color=auto "$src" "$target" || true
        echo
      fi
    else
      echo "=== $target (missing) ==="
      echo
    fi
  done
}

cmd_apply() {
  for mapping in "${FILES[@]}"; do
    local="${mapping%%:*}"
    target="${mapping##*:}"
    src="$SCRIPT_DIR/$local"
    mkdir -p "$(dirname "$target")"
    cp -vf "$src" "$target"
  done
  echo
  echo "Done. Run 'source ~/.bashrc' to reload."
}

cmd_save() {
  for mapping in "${FILES[@]}"; do
    local="${mapping%%:*}"
    target="${mapping##*:}"
    src="$SCRIPT_DIR/$local"
    if [[ -f "$target" ]]; then
      cp -vf "$target" "$src"
    else
      echo "skip: $target (not found)"
    fi
  done
}

case "${1:-diff}" in
  diff)  cmd_diff ;;
  apply) cmd_apply ;;
  save)  cmd_save ;;
  *)
    echo "Usage: $0 [diff|apply|save]"
    echo "  diff  - show differences (default)"
    echo "  apply - copy dotfiles to system"
    echo "  save  - copy system configs back to dotfiles"
    exit 1
    ;;
esac
