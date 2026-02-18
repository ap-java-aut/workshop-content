# Beamer Slideshow Template for Persian Content

This directory contains a LaTeX Beamer template designed for converting Persian markdown files into professional slideshow presentations.

## Features

- **Persian Text Support**: Full support for Persian (Farsi) text using XePersian and Estedad font family
- **Code Block Styling**: Syntax-highlighted code blocks with line numbers using minted package
- **Beamer Theme**: Professional Madrid theme with customized colors
- **Header/Footer Support**: Automatic handling of document metadata (title, authors, professors, institution)
- **Image Support**: Automatic resizing and positioning of images to fit slide dimensions
- **Table of Contents**: Automatic generation of outline slide
- **Presentation Notes**: Support for speaker notes (can be enabled manually)

## Directory Structure

```
latex-slideshow-automated-usage/
├── fonts/              # Estedad font family (all weights)
├── images/             # Logo files (logo-fa.png, logo-en.png)
├── settings.tex        # Beamer theme, packages, and styling configurations
└── template.tex        # Main template with metadata handling and structure
```

## Usage with Pandoc

To convert a markdown file to a Beamer PDF slideshow:

```bash
pandoc input.md \
  -o output.pdf \
  --pdf-engine=xelatex \
  --template=config/templates/latex-slideshow-automated-usage/template.tex \
  --lua-filter=config/latex-slideshow-automated-filter.lua \
  --resource-path=config/templates/latex-slideshow-automated-usage
```

## Markdown Structure

### YAML Metadata

Your markdown file should include metadata at the beginning:

```yaml
---
title: شروع برنامه‌نویسی جاوا
writers:
  - آرمان حسینی
semester: بهار ۱۴۰۴
course: برنامه‌سازی پیشرفته و کارگاه
professor: دکتر مهدی قطعی
professor_2: بهنام یوسفی‌مهر
department: دانشکده ریاضی و علوم کامپیوتر
institution: دانشگاه صنعتی امیرکبیر
---
```

### Content Structure

- **Level 1 Headers (`#`)**: Sections (appear in TOC, no slide created)
- **Level 2 Headers (`##`)**: Subsections + New slide with that title
- **Level 3 Headers (`###`)**: New slide with that title
- **Level 4+ Headers**: Bold text within current slide

Example:

```markdown
# مقدمه

## اولین برنامه

این محتوا در اسلاید "اولین برنامه" قرار می‌گیرد.

### کدی که اجرا کردیم

این یک اسلاید جدید با عنوان "کدی که اجرا کردیم" ایجاد می‌کند.
```

### Code Blocks

Code blocks are automatically styled with syntax highlighting:

```markdown
```java
public class HelloWorld {
    public static void main(String[] args) {
        System.out.println("Hello, World!");
    }
}
```‌```

### Images

Images are automatically resized to fit slides:

```markdown
![](images/screenshot.png)
```

## Customization

### Colors

Edit `settings.tex` to customize theme colors:

```latex
\definecolor{primarycolor}{RGB}{0,51,102}
\definecolor{secondarycolor}{RGB}{0,102,204}
\definecolor{accentcolor}{RGB}{204,0,0}
```

### Aspect Ratio

The default aspect ratio is 16:9. To change it, edit the first line of `settings.tex`:

```latex
\documentclass[aspectratio=43,xcolor={dvipsnames}]{beamer}  % For 4:3
```

### Presentation Notes

To enable speaker notes during presentation, uncomment the line in `settings.tex`:

```latex
\setbeameroption{show notes on second screen}
```

You can then add notes manually in the generated LaTeX file:

```latex
\begin{frame}{Slide Title}
  Content here...
  \note{These are speaker notes that will appear on the second screen}
\end{frame}
```

## Requirements

- XeLaTeX (for Persian text support)
- Python with Pygments (for code syntax highlighting via minted)
- Required LaTeX packages: beamer, xepersian, minted, tcolorbox, etc.

## Troubleshooting

### Shell Escape Error

If you get a minted error about shell escape, make sure to compile with:

```bash
xelatex -shell-escape document.tex
```

Or when using pandoc, the `--pdf-engine-opt=-shell-escape` might be needed.

### Font Not Found

Ensure all Estedad font files are in the `fonts/` directory.

### Images Not Found

Use `--resource-path` option with pandoc to specify the template directory, or use absolute/relative paths from your markdown location.
