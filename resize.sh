#!/bin/bash
set -e
cd "$(dirname "$0")"
mkdir -p images
count=0
for f in *.JPG; do
  out="images/${f}"
  if [ -f "$out" ]; then
    continue
  fi
  sips -Z 1600 -s format jpeg -s formatOptions 80 "$f" --out "$out" >/dev/null
  count=$((count + 1))
  printf "."
done
echo ""
echo "Resized $count new image(s). Total in images/: $(ls images | wc -l | tr -d ' ')"
