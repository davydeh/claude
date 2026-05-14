---
name: editorial
description: Use when creating PDFs, HTML pages, posters, handouts, checklists, worksheets, or printable documents that need a polished editorial aesthetic — cream paper, serif display type, accent color, generous whitespace. Triggers on phrases like "Claude's design language", "editorial style", "paper-like layout", "magazine feel", "make this a PDF", "give this an editorial treatment", or any request to skin plain content into a printable deliverable.
---

# Editorial

## Overview

A composable editorial design language for PDFs, HTML pages, and printable handouts. Cream paper, Fraunces serif display, Inter body, configurable accent. Built as one stylesheet (`style.css`) plus a snippet library (`components.html`) — pick the components you need, write the doc.

Output is HTML (open in browser) or PDF (one shell command via Chrome headless).

## File layout

```
~/.claude/skills/editorial/
  style.css           ← all CSS: tokens, palettes, components
  components.html     ← copy-pasteable snippet for each component
  template.html       ← minimal scaffold (cover + 1 section + colophon)
  render.sh           ← html → pdf via Chrome headless
  new-doc.sh          ← copy template + style.css into a new directory
  examples/
    elite-writers-checklist.html   ← full multi-page worked example
```

## How to use

### Option 1 — scaffold a new doc

```bash
~/.claude/skills/editorial/new-doc.sh \
  "My Document" forest ~/Desktop/
```

Produces `~/Desktop/my-document.html` and copies `style.css` next to it. Edit the HTML, adding components from `components.html` as needed.

### Option 2 — start from any HTML file

In any `.html` file, add inside `<head>`:

```html
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Fraunces:opsz,wght@9..144,400;9..144,500;9..144,600;9..144,700&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
<link rel="stylesheet" href="path/to/style.css">
```

Set the palette on `<html>` or `<body>`:

```html
<body class="palette-forest">
```

Then copy whichever components you want from `components.html` into `<body>`.

### Render to PDF

```bash
~/.claude/skills/editorial/render.sh input.html output.pdf
```

## Design tokens

| Token              | Hex          | Use                                  |
|--------------------|--------------|--------------------------------------|
| `--paper`          | `#FAF9F5`    | page background                      |
| `--paper-edge`     | `#F0EEE6`    | secondary card surface (rare)        |
| `--ink`            | `#1F1F1E`    | primary text                         |
| `--ink-soft`       | `#3D3D3A`    | secondary text / lede                |
| `--ink-mute`       | `#8A867D`    | tertiary text / captions             |
| `--rule`           | `#E5E1D3`    | hairline dividers                    |
| `--accent`         | per palette  | numerals, italic key terms, borders  |
| `--accent-soft`    | per palette  | card backgrounds (10–15% accent)     |

## Palettes

Apply as a class on `<html>` or `<body>`:

| Class                | `--accent` | `--accent-soft` | Feel                  |
|----------------------|------------|------------------|-----------------------|
| `palette-coral`      | `#D97757`  | `#F4E3D8`        | Claude default, warm  |
| `palette-forest`     | `#4F6B3B`  | `#E1E6D6`        | botanical, studious   |
| `palette-indigo`     | `#3D5A80`  | `#DCE3EE`        | cool, newsprint       |
| `palette-plum`       | `#6B3858`  | `#ECDDE5`        | literary, romantic    |
| `palette-slateteal`  | `#2F5D62`  | `#D3E0E0`        | precise, modern       |

For a custom accent, override the two vars in `:root`:

```css
:root { --accent: #7A4C28; --accent-soft: #EFE0CE; }
```

## Components

See `components.html` for the minimal markup of each block. The system has:

- **`.cover`** — eyebrow + display title (italic accent on final word) + lede + meta-row
- **`aside.card`** — soft-tinted callout (how-to-use, prerequisites, warning)
- **`figure.pullquote`** — left-bordered serif quote with caption
- **`.contents`** — numbered table-of-contents with dotted leader + item count
- **`section.chunk` + `.section-head`** — italic accent numeral + serif title + sub
- **`ul.checks`** — hollow-checkbox list (use `<span class="accent">word</span>` inline)
- **`p.body` + `h3.subhead`** — prose paragraphs with serif subheads
- **`.colophon`** — closing footer with accent dot + italic right-aligned tagline
- **`.page-break`** — utility class to force a page break after any block

Compose freely. A checklist is just `cover + section + ul.checks`. A workshop handout might be `cover + card + section + prose + pullquote + section + colophon`. A poster might be `cover + pullquote`.

## Typography

- **Display & accent:** Fraunces (Google Fonts; variable, optical-sized). Italics in `--accent` for key terms.
- **Body & UI:** Inter (Google Fonts). 10.5pt body, 8.5pt small caps for eyebrows.

| Element       | Family     | Size  | Notes                                  |
|---------------|------------|-------|----------------------------------------|
| Title         | Fraunces   | 44pt  | weight 500, `letter-spacing -0.02em`   |
| Section head  | Fraunces   | 18pt  | weight 500                             |
| Section num   | Fraunces   | 22pt  | italic, color `--accent`               |
| Pull-quote    | Fraunces   | 18pt  | regular, left border accent            |
| Lede          | Fraunces   | 13pt  | regular, `--ink-soft`                  |
| Body          | Inter      | 10.5pt| weight 400                             |
| Eyebrow       | Inter      | 8.5pt | weight 500, uppercase, 0.16em tracking |

## Page setup

`style.css` ships with `@page { size: Letter; margin: 0.7in 0.85in; background: var(--paper); }`. For A4 or other sizes, override `@page` in a local `<style>` block.

## Common mistakes

| Mistake | Fix |
|---------|-----|
| Solid black text (`#000`) | Use `--ink` (`#1F1F1E`) — pure black is harsh on cream. |
| Pure white background | Use `--paper` (`#FAF9F5`). |
| Bold for emphasis | Prefer italic Fraunces in `--accent` for key terms. |
| Section without italic numeral | The numeral is signature — always pair it with the title. |
| Forgetting `@page background` | Without it PDF margins render white instead of cream. |
| Loading Fraunces without `font-optical-sizing: auto` | Display sizes need optical sizing. |
| Tight line-height | Body is 1.5, lede 1.45, titles 1.02–1.1 — give the serif room. |

## When NOT to use

- Data-dense dashboards or analytics — contrast too low for tables of numbers.
- Brand-mandated layouts (DeepL, etc.) — use the project's own design system.
- Plain READMEs — Markdown is fine; this is for typeset deliverables.
