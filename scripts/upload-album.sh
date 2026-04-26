#!/bin/bash
# Usage: ./scripts/upload-album.sh <local-webp-dir> <album-name>
# Example: ./scripts/upload-album.sh ~/Pictures/site-photos/2022/web 2022
#
# Credentials sourced from .env at repo root
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ENV_FILE="$SCRIPT_DIR/../.env"
[ -f "$ENV_FILE" ] && set -a && source "$ENV_FILE" && set +a

LOCAL_DIR="${1:?Usage: $0 <local-webp-dir> <album-name>}"
ALBUM="${2:?Usage: $0 <local-webp-dir> <album-name>}"
BUCKET="rohan-photos"

: "${CLOUDFLARE_API_TOKEN:?CLOUDFLARE_API_TOKEN not set}"
: "${CLOUDFLARE_ACCOUNT_ID:?CLOUDFLARE_ACCOUNT_ID not set}"

shopt -s nullglob
files=("$LOCAL_DIR"/*.webp)

if [ ${#files[@]} -eq 0 ]; then
  echo "No .webp files found in $LOCAL_DIR"
  exit 1
fi

echo "Uploading ${#files[@]} files to r2://$BUCKET/$ALBUM/ ..."

for f in "${files[@]}"; do
  filename=$(basename "$f")
  echo "  $filename"
  npx wrangler r2 object put "$BUCKET/$ALBUM/$filename" \
    --file "$f" --remote 2>/dev/null
done

echo ""
echo "Done. Visit https://photos.rohan-joshi.com/$ALBUM/ to verify."
