# Astro Migration Guide

Your personal website has been successfully migrated to Astro + Tailwind CSS!

## What's New

### Modern Stack
- **Astro**: Fast, content-focused static site generator
- **Tailwind CSS**: Utility-first CSS framework for rapid styling
- **TypeScript**: Type-safe development
- **Component-based architecture**: Reusable layouts and components

### Improvements
1. **Performance**: Zero JavaScript by default, optimal loading times
2. **Photo Gallery**: Dynamic, responsive grid with improved lightbox
3. **Content Management**: Essays stored as Markdown with frontmatter
4. **Responsive Design**: Mobile-first with Tailwind's responsive utilities
5. **Developer Experience**: Hot reload, modern tooling

## Project Structure

```
astro-site/
├── src/
│   ├── layouts/
│   │   └── BaseLayout.astro       # Main layout with navigation
│   ├── components/
│   │   └── PhotoGallery.astro     # Reusable photo gallery component
│   ├── pages/
│   │   ├── index.astro            # Home page
│   │   ├── [essay].astro          # Dynamic essay pages
│   │   └── photos/
│   │       └── 2022.astro         # Photo gallery page
│   ├── content/
│   │   ├── config.ts              # Content collections config
│   │   └── essays/                # Markdown essay files
│   └── styles/
│       └── global.css             # Tailwind imports
├── public/                        # Static assets
│   ├── 2022/                      # Photo directory
│   ├── rohan_0.png
│   └── rohan_1.png
└── astro.config.mjs               # Astro configuration
```

## Local Development

```bash
cd astro-site
npm install          # Install dependencies
npm run dev          # Start dev server at http://localhost:4321
npm run build        # Build for production
npm run preview      # Preview production build
```

## Deployment to GitHub Pages

### Option 1: Using GitHub Actions (Recommended)

The project includes a GitHub Actions workflow at `.github/workflows/deploy.yml`.

**Setup Steps:**
1. Go to your repository settings on GitHub
2. Navigate to Pages → Source
3. Select "GitHub Actions" as the source
4. Push your changes to the `master` branch
5. The site will automatically build and deploy

### Option 2: Manual Deployment

```bash
cd astro-site
npm run build
# Copy the contents of dist/ to your GitHub Pages repository root
```

## Adding New Content

### Add a New Essay
1. Create a new `.md` file in `src/content/essays/`
2. Add frontmatter:
   ```md
   ---
   title: "Your Title"
   description: "Brief description"
   ---

   Your content here...
   ```
3. Update the navigation in `src/layouts/BaseLayout.astro` if needed
4. The page will be available at `/your-filename`

### Add New Photos
1. Create a folder in `public/` (e.g., `public/2023/`)
2. Add your photos
3. Create a new page in `src/pages/photos/2023.astro`
4. Import and use the `PhotoGallery` component with your photo data

## Customization

### Styling
- Tailwind classes are used throughout
- Modify `src/styles/global.css` for global styles
- Component-specific styles can be added in `<style>` blocks

### Navigation
- Update `src/layouts/BaseLayout.astro` to modify the sidebar navigation
- Change colors, spacing, or structure using Tailwind classes

### Layout
- Adjust the sidebar width, content max-width, or spacing in `BaseLayout.astro`
- All pages inherit from this layout for consistency

## Next Steps

1. **Test Locally**: Run `npm run dev` and visit http://localhost:4321
2. **Fill in Placeholder Content**: Complete the essays (emerson, poli, momdad, spring)
3. **Deploy**: Push to GitHub and enable GitHub Pages
4. **Enhance**: Add dark mode, more galleries, or blog functionality

## Notes

- The original HTML files are preserved in the repository root
- Google Analytics is configured in each page
- Profile images randomly select between rohan_0.png and rohan_1.png
- Lightbox keyboard navigation: Arrow keys, Escape to close
