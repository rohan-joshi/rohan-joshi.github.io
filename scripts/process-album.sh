#!/bin/bash
# Usage: ./scripts/process-album.sh <source-dir> <output-dir>
# Example: ./scripts/process-album.sh 2022 ~/Pictures/site-photos/2022/web
set -e

SOURCE_DIR="${1:?Usage: $0 <source-dir> <output-dir>}"
OUTPUT_DIR="${2:?Usage: $0 <source-dir> <output-dir>}"

mkdir -p "$OUTPUT_DIR"

shopt -s nullglob
files=("$SOURCE_DIR"/*.{jpg,jpeg,tif,tiff,JPG,JPEG,TIF,TIFF,png,PNG})

if [ ${#files[@]} -eq 0 ]; then
  echo "No image files found in $SOURCE_DIR"
  exit 1
fi

for f in "${files[@]}"; do
  base=$(basename "$f")
  name="${base%.*}"

  echo "Processing $base..."

  cwebp -q 82 -resize 600 0 -metadata none -quiet "$f" -o "$OUTPUT_DIR/${name}_thumb.webp"
  cwebp -q 88 -resize 2000 0 -metadata none -quiet "$f" -o "$OUTPUT_DIR/${name}_full.webp"

  echo "  → ${name}_thumb.webp  ${name}_full.webp"
done

echo ""
echo "Done. ${#files[@]} photos → $OUTPUT_DIR"
