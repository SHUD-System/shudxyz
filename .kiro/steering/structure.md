---
inclusion: always
---

# Project Structure

## Content Organization

The site uses a **bilingual structure** with separate content directories:

```
content/
├── en/          # English content
└── zh/          # Chinese content (default language)
```

Both language directories mirror the same structure:

### Main Content Sections

- `home/`: Homepage widgets (hero, featured, publications, people, contact, etc.)
- `team/`: Team member profiles
- `authors/`: Author profiles for publications
- `publication/`: Academic publications with BibTeX support
- `project/` & `project0/`: Research projects
- `post/`: Blog posts and news
- `talk/`: Conference talks and presentations
- `course/` & `xcourse/`: Course materials
- `shud/`: SHUD model documentation
- `gallery/` & `gallery3d/`: Visual galleries
- `opp/`: Opportunities (postdoc, student positions, collaborations)
- `app/`: Applications section

### Static Assets

```
static/
├── Book_CN/          # Chinese SHUD book
├── Book_EN/          # English SHUD book
├── Book_Lab/         # Lab manual
├── Book_nme/         # Numerical methods book
├── BookR/            # R in Geoscience book
├── ghdc_CN/          # Global Hydro Data Cloud docs (Chinese)
├── ghdc_EN/          # Global Hydro Data Cloud docs (English)
├── openfunding/      # Open funding documentation
├── media/            # Images, PDFs, and media files
└── uploads/          # User uploads
```

### Configuration

```
config/_default/
├── hugo.yaml         # Core Hugo configuration
├── params.yaml       # Theme parameters
├── languages.yaml    # Bilingual setup
├── menus.yaml        # Navigation menus
└── module.yaml       # Hugo modules
```

### Assets

```
assets/
├── css/themes/       # Color theme CSS files
├── media/            # Source media files
└── jsconfig.json     # JavaScript configuration
```

## Content Conventions

### Frontmatter

Content files use YAML frontmatter (some legacy files use TOML with `+++`):

```yaml
---
title: "Page Title"
type: widget_page
headless: true/false
---
```

### Widget Pages

Homepage and section pages use the `widget_page` type with individual widget files in the directory.

### Bilingual Content

- Default language: Chinese (`zh`)
- Content must be duplicated in both `content/en/` and `content/zh/`
- Language switcher enabled in navigation
- Separate menus defined in `languages.yaml`

## Build Output

```
public/              # Generated site (gitignored)
resources/_gen/      # Generated resources (images, CSS)
```
