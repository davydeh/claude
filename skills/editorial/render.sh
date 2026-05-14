#!/usr/bin/env bash
# editorial — render an HTML doc to PDF via Chrome headless.
#
# Usage:
#   render.sh <input.html> <output.pdf>
#
# Notes:
#   - Loads Google Fonts at render time, so the machine needs network access.
#   - Uses --virtual-time-budget=10000 so webfonts finish loading before printing.
#   - Use @page { background: ... } in your CSS to fill the PDF margins.

set -euo pipefail

INPUT="${1:-}"
OUTPUT="${2:-}"

if [[ -z "$INPUT" || -z "$OUTPUT" ]]; then
  echo "usage: $(basename "$0") <input.html> <output.pdf>" >&2
  exit 64
fi

if [[ ! -f "$INPUT" ]]; then
  echo "render: input file not found: $INPUT" >&2
  exit 66
fi

# Resolve absolute input path so Chrome can open it via file://
abs_input="$(cd "$(dirname "$INPUT")" && pwd)/$(basename "$INPUT")"

CHROME_CANDIDATES=(
  "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
  "/Applications/Chromium.app/Contents/MacOS/Chromium"
  "/Applications/Brave Browser.app/Contents/MacOS/Brave Browser"
  "$(command -v google-chrome 2>/dev/null || true)"
  "$(command -v chromium 2>/dev/null || true)"
)

CHROME=""
for c in "${CHROME_CANDIDATES[@]}"; do
  if [[ -n "$c" && -x "$c" ]]; then
    CHROME="$c"
    break
  fi
done

if [[ -z "$CHROME" ]]; then
  echo "render: no Chromium-family browser found." >&2
  echo "       install Google Chrome, Chromium, or Brave, or edit render.sh." >&2
  exit 69
fi

"$CHROME" \
  --headless=new \
  --disable-gpu \
  --no-pdf-header-footer \
  --print-to-pdf="$OUTPUT" \
  --virtual-time-budget=10000 \
  "file://$abs_input" 2>/dev/null

if [[ ! -f "$OUTPUT" ]]; then
  echo "render: PDF was not produced." >&2
  exit 1
fi

bytes=$(stat -f%z "$OUTPUT" 2>/dev/null || stat -c%s "$OUTPUT" 2>/dev/null || echo "?")
echo "render: wrote $OUTPUT ($bytes bytes)"
