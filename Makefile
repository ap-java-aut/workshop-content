# Makefile for converting markdown to PDF documents and slideshows
# 
# Usage:
#   make document INPUT=path/to/file.md OUTPUT=output.pdf
#   make slideshow INPUT=path/to/file.md OUTPUT=slides.pdf
#   make example-slideshow
#   make help

# Configuration
PANDOC := pandoc
XELATEX := xelatex
DOC_TEMPLATE := config/templates/latex-document-automated-usage/template.tex
DOC_FILTER := config/latex-document-automated-filter.lua
SLIDE_TEMPLATE := config/templates/latex-slideshow-automated-usage/template.tex
SLIDE_FILTER := config/latex-slideshow-automated-filter.lua
SLIDE_RESOURCE_PATH := config/templates/latex-slideshow-automated-usage

# Default target
.PHONY: help
help:
	@echo "Markdown to PDF Conversion Makefile"
	@echo ""
	@echo "Available targets:"
	@echo "  make document INPUT=file.md OUTPUT=output.pdf"
	@echo "      Convert markdown to PDF document"
	@echo ""
	@echo "  make slideshow INPUT=file.md OUTPUT=slides.pdf"
	@echo "      Convert markdown to Beamer slideshow"
	@echo ""
	@echo "  make example-slideshow"
	@echo "      Generate example slideshow from template"
	@echo ""
	@echo "  make test-slideshow"
	@echo "      Convert introduction-to-java to slideshow"
	@echo ""
	@echo "  make clean"
	@echo "      Remove generated example files"
	@echo ""
	@echo "Examples:"
	@echo "  make slideshow INPUT=documents/markdown-source-files/oop/oop-1-introduction.md OUTPUT=oop-slides.pdf"
	@echo "  make document INPUT=documents/markdown-source-files/git/git.md OUTPUT=git-doc.pdf"

# Check if required tools are installed
.PHONY: check-tools
check-tools:
	@command -v $(PANDOC) >/dev/null 2>&1 || { echo "Error: pandoc not found. Please install pandoc."; exit 1; }
	@command -v $(XELATEX) >/dev/null 2>&1 || { echo "Error: xelatex not found. Please install TeX Live or MiKTeX."; exit 1; }
	@command -v pygmentize >/dev/null 2>&1 || { echo "Error: pygmentize not found. Please install Pygments (pip install Pygments)."; exit 1; }

# Convert markdown to PDF document
.PHONY: document
document: check-tools
	@if [ -z "$(INPUT)" ] || [ -z "$(OUTPUT)" ]; then \
		echo "Error: INPUT and OUTPUT must be specified"; \
		echo "Usage: make document INPUT=file.md OUTPUT=output.pdf"; \
		exit 1; \
	fi
	@echo "Converting $(INPUT) to document $(OUTPUT)..."
	$(PANDOC) "$(INPUT)" \
		-o "$(OUTPUT)" \
		--pdf-engine=$(XELATEX) \
		--template="$(DOC_TEMPLATE)" \
		--lua-filter="$(DOC_FILTER)"
	@echo "Success! Document created: $(OUTPUT)"

# Convert markdown to Beamer slideshow
.PHONY: slideshow
slideshow: check-tools
	@if [ -z "$(INPUT)" ] || [ -z "$(OUTPUT)" ]; then \
		echo "Error: INPUT and OUTPUT must be specified"; \
		echo "Usage: make slideshow INPUT=file.md OUTPUT=slides.pdf"; \
		exit 1; \
	fi
	@echo "Converting $(INPUT) to slideshow $(OUTPUT)..."
	$(PANDOC) "$(INPUT)" \
		-o "$(OUTPUT)" \
		--pdf-engine=$(XELATEX) \
		--pdf-engine-opt=-shell-escape \
		--template="$(SLIDE_TEMPLATE)" \
		--lua-filter="$(SLIDE_FILTER)" \
		--resource-path="$(SLIDE_RESOURCE_PATH)"
	@echo "Success! Slideshow created: $(OUTPUT)"

# Generate example slideshow
.PHONY: example-slideshow
example-slideshow: check-tools
	@echo "Generating example slideshow..."
	$(PANDOC) "$(SLIDE_RESOURCE_PATH)/example-presentation.md" \
		-o "example-slideshow.pdf" \
		--pdf-engine=$(XELATEX) \
		--pdf-engine-opt=-shell-escape \
		--template="$(SLIDE_TEMPLATE)" \
		--lua-filter="$(SLIDE_FILTER)" \
		--resource-path="$(SLIDE_RESOURCE_PATH)"
	@echo "Success! Example slideshow created: example-slideshow.pdf"

# Test with introduction-to-java
.PHONY: test-slideshow
test-slideshow: check-tools
	@echo "Converting introduction-to-java to slideshow..."
	$(PANDOC) "documents/markdown-source-files/introduction/introduction-to-java.md" \
		-o "test-intro-java-slides.pdf" \
		--pdf-engine=$(XELATEX) \
		--pdf-engine-opt=-shell-escape \
		--template="$(SLIDE_TEMPLATE)" \
		--lua-filter="$(SLIDE_FILTER)" \
		--resource-path="$(SLIDE_RESOURCE_PATH):documents/markdown-source-files/introduction"
	@echo "Success! Test slideshow created: test-intro-java-slides.pdf"

# Clean generated files
.PHONY: clean
clean:
	@echo "Cleaning generated files..."
	@rm -f example-slideshow.pdf test-intro-java-slides.pdf
	@echo "Clean complete."

.PHONY: all
all: help
