# Changelog

## 2026-05-27

- Fixed markdown files crashing during Tree-sitter parsing after updating Neovim
  and Lazy plugins.
- Added the `markdown_inline` Tree-sitter parser, which is required by
  `render-markdown.nvim` for full markdown parsing.
- Added a local markdown injections query override to avoid the crashing
  `set-lang-from-info-string!` directive while preserving fenced code blocks,
  HTML blocks, YAML/TOML frontmatter, and inline markdown injections.
