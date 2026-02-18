# Advanced Programming (Java) of MCS AUT

## Introduction

This project is dedicated to teaching an advanced programming course in Java. The course starts with the fundamentals and gradually covers more complex topics. Along the way, we also explore essential tools like Git, IntelliJ, and other technologies that are part of a Java programmer's daily workflow.

## Course Platform

The course material is offered to students through [Quera](https://quera.org).

### Current Semester
- **Semester 1403-02** (Spring 2025): Available at [Quera Course Page](https://quera.org/course/add_to_course/course/20556/)

## Repository Structure

### `assignments/`
Contains all course assignments organized by semester:
- **`semester-1403-02/`** - Current semester assignments
  - `weekly-assignments/` - Weekly homeworks
  - `workshop-exercises/` - Practical coding exercises for 2-hour workshops

### `config/`
Configuration files and document templates:
- **Templates** for LaTeX and Word documents
- **Fonts** (Estedad font family) with Persian support
- **Automation scripts** for document processing (from Markdown to LaTex)

### `documents/`
Course content in multiple formats:
- **`markdown-source-files/`** - Raw Markdown content organized by topic:
  - Introduction to Java
  - Git version control
  - Graphics (Swing)
  - Clean Code principles
  - Object-oriented programming in Java
  - File I/O in Java
  - Java Collections Framework (JCF) and introduction "Data Structures and Aglrothms"
  - MySQL Database and Hibernate ORM
- **`semester-1403-02/`** - Compiled documents (PDF and DOCX)

### `guideline/`
Style and quality guidelines for creating educational content.

### `projects/`
Semester-long projects with detailed documentation:
- **`semester-1403-02/`** - Current semester assignments
  - Todo List - In-memory database implementation
  - Milou Project - Simple E-Mail system

## Teaching Assistant Contribution Guidelines

### Branch Strategy
1. Create a branch from `main` using kebab-case naming (e.g., `add-week3-content`)
2. If working in a group, collaborate on a single branch
3. Avoid creating multiple branches for the same week's content

### Pull Request Process
1. Submit a pull request to merge your branch into `main`
2. Ensure all new content follows the established structure
3. Include comprehensive README.md files for student-facing content

### Document Quality
Before creating new content, review the guidelines in:
- [How to Write a Good Document](guideline/how-to-write-a-good-doc.pdf)

## Naming Conventions

### File and Directory Names
- Use **kebab-case** for everything

### Commit Messages
- Use **imperative mood** in present tense
- Write in **all lowercase**


### Content Organization
- Group related materials under topic-specific directories
- Separate source files from compiled documents
- Include images in dedicated `images/` subdirectories

## Workflow Notes

- **Markdown** files in `documents/markdown-source-files/` serve as the source for all documents
- **Templates** in `config/templates/` ensure consistent formatting
- **Assignments** include both problem statements and reference solutions
- **Projects** provide real-world application of course concepts