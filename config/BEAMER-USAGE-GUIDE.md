# Beamer Slideshow Template Usage Guide

## Overview

This guide explains how to convert Persian markdown files into professional LaTeX Beamer slideshow presentations using the provided template and filters.

## Prerequisites

Before using the template, ensure you have the following installed:

1. **Pandoc** (version 2.0 or higher)
   ```bash
   # Ubuntu/Debian
   sudo apt-get install pandoc
   
   # macOS
   brew install pandoc
   
   # Or download from: https://pandoc.org/installing.html
   ```

2. **XeLaTeX** (for Persian text support)
   ```bash
   # Ubuntu/Debian
   sudo apt-get install texlive-xetex texlive-fonts-extra
   
   # macOS
   brew install --cask mactex
   ```

3. **Pygments** (for code syntax highlighting)
   ```bash
   pip install Pygments
   ```

## Quick Start

### Basic Conversion

To convert a markdown file to a beamer presentation:

```bash
cd /path/to/workshop-content

pandoc documents/markdown-source-files/introduction/introduction-to-java.md \
  -o output-slideshow.pdf \
  --pdf-engine=xelatex \
  --pdf-engine-opt=-shell-escape \
  --template=config/templates/latex-slideshow-automated-usage/template.tex \
  --lua-filter=config/latex-slideshow-automated-filter.lua \
  --resource-path=config/templates/latex-slideshow-automated-usage
```

### Using the Test Script

A helper script is provided for easy conversion:

```bash
# Convert default file (introduction-to-java.md)
./config/test-beamer-conversion.sh

# Convert specific file
./config/test-beamer-conversion.sh documents/markdown-source-files/oop/oop-1-introduction.md my-slides.pdf
```

## Markdown Structure for Slides

### Document Metadata

Every markdown file should start with YAML metadata:

```yaml
---
title: عنوان ارائه
writers:
  - نویسنده اول
  - نویسنده دوم
semester: بهار ۱۴۰۴
course: نام درس
professor: نام استاد
professor_2: نام استاد دوم (اختیاری)
department: نام دانشکده
institution: نام دانشگاه
---
```

### Header Hierarchy and Slides

The filter automatically converts headers into slides:

- **Level 1 (`#`)**: Creates a section (appears in TOC, no new slide)
- **Level 2 (`##`)**: Creates a subsection AND a new slide with that title
- **Level 3 (`###`)**: Creates a new slide with that title
- **Level 4+ (`####`)**: Appears as bold text within the current slide

**Example:**

```markdown
# بخش اول    ← Section in TOC only

## موضوع اصلی    ← New slide titled "موضوع اصلی"

این محتوا در اسلاید "موضوع اصلی" نمایش داده می‌شود.

### زیرموضوع    ← New slide titled "زیرموضوع"

این محتوا در اسلاید "زیرموضوع" قرار می‌گیرد.

#### نکته مهم    ← Bold heading within current slide

این متن همچنان در اسلاید "زیرموضوع" است.
```

### Code Blocks

Code blocks are syntax-highlighted with line numbers:

````markdown
```java
public class Example {
    public static void main(String[] args) {
        System.out.println("Hello!");
    }
}
```
````

Supported languages include: java, python, javascript, c, cpp, bash, and many more.

### Images

Images are automatically resized to fit slides:

```markdown
![](path/to/image.png)
```

- Images maintain aspect ratio
- Maximum size: 70% width, 60% height
- Centered automatically

### Lists

Both bullet and numbered lists are supported:

```markdown
- Item 1
- Item 2
  - Nested item
- Item 3
```

```markdown
1. First step
2. Second step
3. Third step
```

### Tables

Tables work with Persian text:

```markdown
| Header 1 | Header 2 | Header 3 |
|----------|----------|----------|
| Cell 1   | Cell 2   | Cell 3   |
| Data A   | Data B   | Data C   |
```

### Mathematical Formulas

Inline math: `$E = mc^2$`

Display math:
```markdown
$$
\int_{-\infty}^{\infty} e^{-x^2} dx = \sqrt{\pi}
$$
```

## Customization

### Change Theme Colors

Edit `config/templates/latex-slideshow-automated-usage/settings.tex`:

```latex
\definecolor{primarycolor}{RGB}{0,51,102}     % Main color
\definecolor{secondarycolor}{RGB}{0,102,204}  % Secondary color
\definecolor{accentcolor}{RGB}{204,0,0}       # Accent color
```

### Change Aspect Ratio

Edit the first line of `settings.tex`:

```latex
% For 16:9 (default)
\documentclass[aspectratio=169,xcolor={dvipsnames}]{beamer}

% For 4:3
\documentclass[aspectratio=43,xcolor={dvipsnames}]{beamer}
```

### Change Beamer Theme

Edit `settings.tex`:

```latex
\usetheme{Madrid}      % Try: Berlin, Copenhagen, Singapore, Warsaw, etc.
\usecolortheme{default} # Try: dolphin, seahorse, whale, etc.
```

### Enable Presentation Notes

To add speaker notes that appear on a second screen:

1. Edit `settings.tex` and uncomment:
   ```latex
   \setbeameroption{show notes on second screen}
   ```

2. After generating the LaTeX file (without PDF), manually add notes:
   ```latex
   \begin{frame}{Slide Title}
     Slide content...
     \note{These are speaker notes visible only to presenter}
   \end{frame}
   ```

## Advanced Usage

### Generate LaTeX Without Compiling

To get the intermediate LaTeX file for manual editing:

```bash
pandoc input.md \
  -o output.tex \
  --template=config/templates/latex-slideshow-automated-usage/template.tex \
  --lua-filter=config/latex-slideshow-automated-filter.lua
```

Then compile manually:

```bash
cd config/templates/latex-slideshow-automated-usage
xelatex -shell-escape output.tex
```

### Batch Conversion

Convert all markdown files in a directory:

```bash
for file in documents/markdown-source-files/*/*.md; do
  output="slideshows/$(basename "$file" .md).pdf"
  pandoc "$file" -o "$output" \
    --pdf-engine=xelatex \
    --pdf-engine-opt=-shell-escape \
    --template=config/templates/latex-slideshow-automated-usage/template.tex \
    --lua-filter=config/latex-slideshow-automated-filter.lua \
    --resource-path=config/templates/latex-slideshow-automated-usage
done
```

## Troubleshooting

### Error: "minted Error: You must invoke LaTeX with the -shell-escape flag"

**Solution:** Add `--pdf-engine-opt=-shell-escape` to your pandoc command.

### Error: "Font not found: Estedad"

**Solution:** Ensure all Estedad font files are in `config/templates/latex-slideshow-automated-usage/fonts/`

### Error: "Package minted Error: Missing Pygments"

**Solution:** Install Pygments:
```bash
pip install Pygments
```

### Images Not Displayed

**Solution:** Use `--resource-path` option or absolute paths in markdown:
```bash
--resource-path=config/templates/latex-slideshow-automated-usage
```

### Persian Text Appears Broken

**Solution:** Ensure you're using XeLaTeX (not pdflatex):
```bash
--pdf-engine=xelatex
```

## Example Files

- **Example Presentation**: `config/templates/latex-slideshow-automated-usage/example-presentation.md`
- **Test Script**: `config/test-beamer-conversion.sh`
- **Template README**: `config/templates/latex-slideshow-automated-usage/README.md`

## Comparison with Document Template

| Feature | Document Template | Slideshow Template |
|---------|------------------|-------------------|
| Format | Report/Article | Beamer Slides |
| Navigation | Table of Contents | TOC + Navigation |
| Page Size | A4 | Presentation (16:9) |
| Code Size | Small | Footnotesize |
| Images | 80% width | 70% width, 60% height |
| Headers | Chapters/Sections | Sections/Frames |
| Notes | N/A | Speaker notes support |

## Tips for Better Slides

1. **Keep slides simple**: One main idea per slide
2. **Use headers wisely**: Level 2 for main topics, Level 3 for subtopics
3. **Limit code**: Show only relevant code snippets
4. **Use bullets**: Break complex ideas into bullet points
5. **Test early**: Generate PDF often to check layout
6. **Manual refinement**: For important presentations, generate LaTeX first and refine manually

## Support

For issues or questions:
1. Check the README in the template directory
2. Review this guide
3. Examine the example presentation
4. Check the Lua filter for conversion logic

## License and Credits

- Template based on Beamer's Madrid theme
- Persian support via XePersian
- Fonts: Estedad family
- Code highlighting: minted + Pygments
