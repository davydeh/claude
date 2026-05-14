#!/usr/bin/env bash
# Install this repo's config into ~/.claude/ by symlinking.
# Existing files are backed up with a timestamp suffix before being replaced.
#
# Usage: ./install.sh

set -euo pipefail

REPO="$(cd "$(dirname "$0")" && pwd)"
TARGET="$HOME/.claude"
STAMP="$(date +%Y%m%d-%H%M%S)"

mkdir -p "$TARGET" "$TARGET/agents" "$TARGET/skills" "$TARGET/memory"

link() {
  local src="$1" dst="$2"
  if [ -L "$dst" ]; then
    local current
    current="$(readlink "$dst")"
    if [ "$current" = "$src" ]; then
      echo "  ok    $dst (already linked)"
      return
    fi
    echo "  relink $dst (was -> $current)"
    rm "$dst"
  elif [ -e "$dst" ]; then
    echo "  backup $dst -> $dst.backup-$STAMP"
    mv "$dst" "$dst.backup-$STAMP"
  fi
  ln -s "$src" "$dst"
  echo "  link  $dst -> $src"
}

echo "Installing claude-config from $REPO into $TARGET"
echo

echo "Top-level files:"
link "$REPO/CLAUDE.md"      "$TARGET/CLAUDE.md"
link "$REPO/settings.json"  "$TARGET/settings.json"
link "$REPO/statusline.sh"  "$TARGET/statusline.sh"

echo
echo "Memory:"
for f in "$REPO"/memory/*.md; do
  [ -e "$f" ] || continue
  link "$f" "$TARGET/memory/$(basename "$f")"
done

echo
echo "Agents:"
for f in "$REPO"/agents/*.md; do
  [ -e "$f" ] || continue
  link "$f" "$TARGET/agents/$(basename "$f")"
done

echo
echo "Skills:"
for d in "$REPO"/skills/*/; do
  [ -e "$d" ] || continue
  name="$(basename "$d")"
  link "${d%/}" "$TARGET/skills/$name"
done

echo
echo "Done. Restart Claude Code to pick up changes."
