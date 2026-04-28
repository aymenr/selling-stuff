#!/bin/bash
set -euo pipefail

IMAGES_DIR="$(dirname "$0")/images"
count=0
errors=0

for f in "$IMAGES_DIR"/*.{JPG,jpg,jpeg,JPEG,png,PNG}; do
  [[ -f "$f" ]] || continue
  out="${f%.*}.webp"
  if cwebp -q 82 "$f" -o "$out" 2>/dev/null; then
    rm "$f"
    echo "converted: $(basename "$f") → $(basename "$out")"
    count=$((count + 1))
  else
    echo "ERROR: $(basename "$f")" >&2
    errors=$((errors + 1))
  fi
done

echo ""
echo "Done: $count converted, $errors errors"
