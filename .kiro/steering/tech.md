---
inclusion: always
---

# Technology Stack

## Core Framework

- **Hugo**: Static site generator (v0.126.3)
- **Hugo Blox Builder**: Academic theme framework (formerly Hugo Academic)
- **Go Modules**: Dependency management

## Theme & Styling

- Hugo Blox Bootstrap v5 module
- Hugo Blox Tailwind module
- Custom CSS themes in `assets/css/themes/` (blue, cyan, emerald, green, indigo, purple, red, rose, sky, teal, zinc)

## Deployment

- **Netlify**: Primary hosting platform
- **Pagefind**: Search functionality (added post-build)
- **netlify-plugin-hugo-cache-resources**: Build optimization

## Content Management

- Markdown for content authoring
- YAML for configuration and frontmatter
- BibTeX for publication management
- Support for LaTeX math, diagrams, RMarkdown, and Jupyter notebooks

## Common Commands

### Development

```bash
# Start local development server
hugo server

# Start with drafts and future posts
hugo server -D --buildFuture

# Start with specific language
hugo server --contentDir=content/en
```

### Building

```bash
# Production build
hugo --gc --minify

# Build with specific base URL
hugo --gc --minify -b https://example.com/

# Build with future posts
hugo --gc --minify --buildFuture
```

### Deployment

The site auto-deploys via Netlify on git push. The build command is:
```bash
hugo --gc --minify -b $URL && npx pagefind --source 'public'
```

## Configuration Structure

- `config/_default/`: Main configuration directory
  - `hugo.yaml`: Core Hugo settings
  - `params.yaml`: Theme parameters and site features
  - `languages.yaml`: Bilingual configuration
  - `menus.yaml`: Navigation menus
  - `module.yaml`: Hugo modules configuration
- `hugoblox.yaml`: Hugo Blox specific settings
