#!/bin/bash
# test-beamer-conversion.sh
# Script to test the beamer slideshow template conversion

# Configuration
INPUT_MD="${1:-documents/markdown-source-files/introduction/introduction-to-java.md}"
OUTPUT_PDF="${2:-test-slideshow.pdf}"
TEMPLATE_DIR="config/templates/latex-slideshow-automated-usage"
FILTER="config/latex-slideshow-automated-filter.lua"

# Check if input file exists
if [ ! -f "$INPUT_MD" ]; then
    echo "Error: Input markdown file not found: $INPUT_MD"
    exit 1
fi

# Check if template exists
if [ ! -f "$TEMPLATE_DIR/template.tex" ]; then
    echo "Error: Template file not found: $TEMPLATE_DIR/template.tex"
    exit 1
fi

# Check if filter exists
if [ ! -f "$FILTER" ]; then
    echo "Error: Lua filter not found: $FILTER"
    exit 1
fi

echo "Converting markdown to beamer slideshow..."
echo "Input:    $INPUT_MD"
echo "Output:   $OUTPUT_PDF"
echo "Template: $TEMPLATE_DIR"
echo "Filter:   $FILTER"
echo ""

# Run pandoc conversion
pandoc "$INPUT_MD" \
  -o "$OUTPUT_PDF" \
  --pdf-engine=xelatex \
  --pdf-engine-opt=-shell-escape \
  --template="$TEMPLATE_DIR/template.tex" \
  --lua-filter="$FILTER" \
  --resource-path="$TEMPLATE_DIR"

# Check if conversion was successful
if [ $? -eq 0 ]; then
    echo ""
    echo "Success! Slideshow created: $OUTPUT_PDF"
    echo ""
    echo "To view the slideshow:"
    echo "  xdg-open $OUTPUT_PDF    # Linux"
    echo "  open $OUTPUT_PDF        # macOS"
else
    echo ""
    echo "Error: Conversion failed. Please check the error messages above."
    echo ""
    echo "Common issues:"
    echo "  1. XeLaTeX not installed: Install TeX Live or MiKTeX"
    echo "  2. Pygments not installed: pip install Pygments"
    echo "  3. Missing fonts: Ensure Estedad fonts are in $TEMPLATE_DIR/fonts/"
    exit 1
fi
