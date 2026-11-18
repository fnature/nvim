# Changelog

## Unreleased

- Show file sizes from a 26-column Neo-tree width instead of 64, with a compact
  8-character size column to reduce padding beside filenames.

- Keep Neo-tree full-height on the left when horizontal ToggleTerm windows open,
  preserving focus and sidebar width across opening orders and repeated toggles.

- Open Neo-tree after startup session handling: plain `nvim` focuses the sidebar,
  while an explicit file argument opens the sidebar without stealing file focus.
  The sidebar starts at 28 columns, 30% narrower than the default, using normal
  Neo-tree configuration so resizing expands filenames and restores size/date columns.

- Exclude Neo-tree sidebar buffers from saved sessions to prevent ordinary
  `neo-tree filesystem [1]` buffers and E95 collisions after restoring.

- Restore buffers, splits, and tabs separately for each working directory, with
  automatic saving enabled and no fallback to the last unrelated session.

- Added the `ih` text object for an indentation scope plus its heading, excluding
  the following sibling: `yih` copies and `vih` selects, with a which-key label.
  Start on a direct child of the intended heading; existing `ii`/`ai` are unchanged.

## 2026-11-09

- Kept Markdown rendered under the cursor while browsing in Normal mode, instead
  of revealing raw syntax as the cursor moves. Insert mode exposes the source
  throughout the window; returning to Normal mode restores rendering. Avante's
  rendering and the separate wrapped-table renderer are unchanged.

## 2026-11-06

- Added Markdown-only `Space m v` image pasting with `img-clip.nvim`: clipboard
  images are saved beside the document in `images/` with relative links and
  collision-resistant filenames, without changing ordinary paste behavior.

- Switched automatic wrapped tables from a separate Reader to inline replacement
  in the source buffer, preserving Snacks images and the normal Feline status bar.
- Kept all tables rendered outside the cursor's table and documented the temporary
  native-wrap override used to avoid long source rows leaking through overlays.

- Fixed Neo-tree's `Alt+w` reveal from Markdown table Reader/Float views to use
  the backing source file, avoiding bogus working-directory-change prompts.

- Added `markdown-table-wrap.nvim` (stable 1.x) for source-safe wrapped Markdown
  tables, automatic Reader view, and Markdown-only `Space m r/i/f` shortcuts.
- Disabled the competing `render-markdown.nvim` pipe-table renderer only for
  Markdown, preserving its other styling and Avante table support.

- Enabled Snacks image support for inline local images in Markdown when using
  Kitty or another compatible terminal, retaining the existing Markdown renderer.
- Added a Markdown image demo and Kitty setup/troubleshooting notes.

- Added `iamcco/markdown-preview.nvim` for live Markdown previews in the browser,
  with automatic prebuilt-server installation through lazy.nvim.
- Added Markdown-only normal-mode mappings: `Space m p` toggles the preview and
  `Space m s` stops it, without replacing existing shortcuts.

## 2026-05-27

- Added Harpoon 2 for fast project file marks with direct `Alt` keymaps:
  add current file, open the Harpoon menu, move previous/next, and jump to
  marks 1 through 4.
- Fixed markdown files crashing during Tree-sitter parsing after updating Neovim
  and Lazy plugins.
- Added the `markdown_inline` Tree-sitter parser, which is required by
  `render-markdown.nvim` for full markdown parsing.
- Added a local markdown injections query override to avoid the crashing
  `set-lang-from-info-string!` directive while preserving fenced code blocks,
  HTML blocks, YAML/TOML frontmatter, and inline markdown injections.
