# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Architecture

Plain static HTML site (Patrick Collison style):
- Root-level `.html` files
- Single CSS file at `/static/style.css`
- Right-floated nav menu, left-floated content
- No build step, no framework

Pages:
- `index.html` - About page
- `blog.html` - Blog listing with dates
- `photos.html` - Photos index
- `photos_2022.html` - 2022 photo gallery with lightbox
- Essay files: `people.html`, `poli.html`, `momdad.html`, `spring.html`, `frankl.html`, `emerson.html`

## Commands

```bash
python -m http.server 8000  # Serve at localhost:8000
```

## Deployment

Push to `master` triggers GitHub Actions (`.github/workflows/deploy.yml`) which deploys static files to GitHub Pages.

## Adding Content

New essay:
1. Create `essay-name.html` using existing essay as template
2. Add entry to `blog.html` with date

New photos:
1. Add images to year folder (e.g., `/2023/`)
2. Create `photos_2023.html` with gallery
3. Add link to `photos.html`

## Style

- Helvetica 13px, blue links (#0864c7)
- HTML: 2-space indent
- Filenames: lowercase with underscores
