# Personal Website Development Guide

## Serving the Site
- Test locally: `python -m http.server 8000` (view at http://localhost:8000)
- Deploy: Push changes to main branch (GitHub Pages will auto-deploy)

## Code Style Guidelines

### HTML
- Indent with 2 spaces
- Keep HTML files in root directory
- Use lowercase for tag names and attributes
- Close all tags properly (including self-closing tags)
- Use semantic HTML elements where appropriate

### CSS
- Store CSS files in the `/css` directory
- Use consistent class/ID naming (descriptive, lowercase with hyphens)
- Indent with 4 spaces in CSS files
- Group related properties together
- Use grid/flex layouts for modern page structure

### JavaScript
- Inline JS only for small functionality (like randomization)
- External analytics scripts at end of body
- Avoid excessive DOM manipulation

### Media
- Store images in year-based directories (e.g., `/2022`)
- Use appropriate image formats (JPG for photos, PNG for UI elements)
- Optimize images for web before uploading

### General
- Keep file names descriptive and lowercase with underscores
- Test across browsers before deploying changes