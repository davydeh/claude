#!/usr/bin/env bash
# editorial — scaffold a new document from the template.
#
# Usage:
#   new-doc.sh <"Title"> [palette] [output-dir]
#
# Palettes: coral (default), forest, indigo, plum, slateteal
#
# Produces:
#   <output-dir>/<slug>.html  + a sibling style.css
#
# The HTML links to style.css relatively, so they must live in the same
# directory. Edit the .html, then run render.sh to produce a PDF.

set -euo pipefail

TITLE="${1:-}"
PALETTE="${2:-coral}"
OUTDIR="${3:-.}"

if [[ -z "$TITLE" ]]; then
  echo 'usage: new-doc.sh "<Title>" [palette] [output-dir]'      >&2
  echo "palettes: coral, forest, indigo, plum, slateteal"        >&2
  exit 64
fi

case "$PALETTE" in
  coral|forest|indigo|plum|slateteal) ;;
  *) echo "unknown palette: $PALETTE" >&2; exit 64 ;;
esac

SKILL_DIR="$(cd "$(dirname "$0")" && pwd)"
TEMPLATE="$SKILL_DIR/template.html"
STYLE="$SKILL_DIR/style.css"

mkdir -p "$OUTDIR"

slug="$(echo "$TITLE" | tr '[:upper:]' '[:lower:]' | tr -c 'a-z0-9' '-' | sed -E 's/-+/-/g; s/^-//; s/-$//')"
OUT="$OUTDIR/$slug.html"

cp "$TEMPLATE" "$OUT"
cp "$STYLE"   "$OUTDIR/style.css"

# Patch the palette class on <html> and the <title>
sed -i.bak \
  -e "s|class=\"palette-[a-z]*\"|class=\"palette-${PALETTE}\"|" \
  -e "s|<title>Untitled Document</title>|<title>${TITLE}</title>|" \
  "$OUT"
rm -f "$OUT.bak"

echo "scaffolded: $OUT  (palette: $PALETTE)"
echo "stylesheet: $OUTDIR/style.css"
echo "next:       \$EDITOR \"$OUT\""
echo "snippets:   $SKILL_DIR/components.html"
echo "render:     $SKILL_DIR/render.sh \"$OUT\" \"${OUT%.html}.pdf\""
