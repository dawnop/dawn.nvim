-- Syntax highlighting and indentation via tree-sitter.
-- Pinned to the classic `master` branch: the `main` rewrite ignores
-- ensure_installed/highlight/indent, so non-bundled parsers (cpp, cuda)
-- never get installed and those filetypes fall back to regex highlighting.
return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'master',
  build = ':TSUpdate',
  main = 'nvim-treesitter.configs',
  opts = {
    ensure_installed = { 'bash', 'c', 'cpp', 'cuda', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
    auto_install = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = { 'ruby' },
    },
    -- Treesitter indent is flaky (often returns column 0); rely on
    -- autoindent + the built-in cindent for C/C++/CUDA instead.
    indent = { enable = false },
  },
}
