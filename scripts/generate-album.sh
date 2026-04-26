#!/bin/bash
# Usage: ./scripts/generate-album.sh <album.json>
# Example: ./scripts/generate-album.sh ~/Pictures/site-photos/japan-hong-kong/album.json
set -e

ALBUM_JSON="${1:?Usage: $0 <album.json>}"
CDN_BASE="https://photos.rohan-joshi.com"
REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"

slug=$(jq -r '.slug' "$ALBUM_JSON")
title=$(jq -r '.title' "$ALBUM_JSON")
date=$(jq -r '.date' "$ALBUM_JSON")

OUT="$REPO_DIR/photos/${slug}.html"

# Build grid items
grid=""
while IFS= read -r row; do
  file=$(echo "$row" | jq -r '.file')
  caption=$(echo "$row" | jq -r '.caption')
  grid+="  <div class=\"photo-grid-item\" data-full=\"$CDN_BASE/$slug/${file}_full.webp\" data-caption=\"$caption\">\n"
  grid+="    <img src=\"$CDN_BASE/$slug/${file}_thumb.webp\" alt=\"$caption\" loading=\"lazy\">\n"
  grid+="  </div>\n"
done < <(jq -c '.photos[]' "$ALBUM_JSON")

cat > "$OUT" <<HEREDOC
<html data-theme="light">
<head>
  <meta charset="utf-8">
  <title>${title} · Photos · Rohan Joshi</title>
  <script>
  (function() {
    const theme = localStorage.getItem('theme') || 'light';
    document.documentElement.setAttribute('data-theme', theme);
  })();
  </script>
  <link rel="stylesheet" href="/static/style.css">
</head>
<body>
<div id="menu">
<span class="title">Rohan Joshi</span>
<ul>
  <li><a href="/">About</a></li>
  <li><a href="/blog.html">Blog</a></li>
  <li><a href="/projects.html">Projects</a></li>
  <li><a href="/photos.html">Photos</a></li>
</ul>
<button id="theme-toggle" aria-label="Toggle dark mode">
  <span class="theme-icon">☾</span>
</button>
</div>
<div id="left">&nbsp;</div>
<div id="content" class="photos-wide">

<p class="byline"><a href="/photos.html">&larr; photos</a></p>
<h1>${title}</h1>
<p class="byline">${date}</p>

<div class="photo-grid">
$(echo -e "$grid")
</div>

</div>

<div class="lightbox" id="lightbox">
  <button class="lb-close" id="lb-close">&times;</button>
  <button class="lb-prev" id="lb-prev">&#8592;</button>
  <div class="lb-content">
    <img src="" alt="" id="lb-img">
    <div class="lb-caption" id="lb-caption"></div>
  </div>
  <button class="lb-next" id="lb-next">&#8594;</button>
</div>

<script src="/static/theme.js"></script>
<script>
(function() {
  const items = Array.from(document.querySelectorAll('.photo-grid-item'));
  const lb = document.getElementById('lightbox');
  const lbImg = document.getElementById('lb-img');
  const lbCaption = document.getElementById('lb-caption');
  let current = 0;

  function open(i) {
    current = i;
    const el = items[i];
    lbImg.src = el.dataset.full;
    lbImg.alt = el.dataset.caption;
    lbCaption.textContent = el.dataset.caption;
    lb.classList.add('open');
    document.body.style.overflow = 'hidden';
  }

  function close() {
    lb.classList.remove('open');
    document.body.style.overflow = '';
    lbImg.src = '';
  }

  function prev() { open((current - 1 + items.length) % items.length); }
  function next() { open((current + 1) % items.length); }

  items.forEach((el, i) => el.addEventListener('click', () => open(i)));
  lb.addEventListener('click', function(e) { if (e.target === lb) close(); });
  document.getElementById('lb-close').addEventListener('click', close);
  document.getElementById('lb-prev').addEventListener('click', function(e) { e.stopPropagation(); prev(); });
  document.getElementById('lb-next').addEventListener('click', function(e) { e.stopPropagation(); next(); });
  document.addEventListener('keydown', function(e) {
    if (!lb.classList.contains('open')) return;
    if (e.key === 'Escape') close();
    if (e.key === 'ArrowLeft') prev();
    if (e.key === 'ArrowRight') next();
  });
})();
</script>
</body>
</html>
HEREDOC

echo "Generated $OUT"

# Update photos.html listing if entry doesn't exist
PHOTOS_HTML="$REPO_DIR/photos.html"
if ! grep -q "$slug" "$PHOTOS_HTML"; then
  sed -i '' "s|<ul class=\"blog-list\">|<ul class=\"blog-list\">\n  <li>\n    <span class=\"date\">${date}<\/span>\n    <a href=\"\/photos\/${slug}.html\">${title}<\/a>\n  <\/li>|" "$PHOTOS_HTML"
  echo "Added entry to photos.html"
fi
