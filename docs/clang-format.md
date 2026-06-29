# Global clang-format (CLion default style)

This config lives **outside** this repo at `~/.clang-format` (a machine-level
file, not version-controlled here). This doc records its contents and rationale
so the setup can be reproduced on a new machine.

## What it is

A global `~/.clang-format` matching **CLion's default C/C++ code style**.

clang-format searches from a file's directory upward until it finds a
`.clang-format`. Putting one in `$HOME` makes it the default for any C/C++
project under your home directory that doesn't ship a closer `.clang-format`.

- **In Neovim:** `<leader>f` (conform.nvim → `clang_format`) picks it up
  automatically. No restart needed — clang-format reads the file on each run.
- **Override per project:** drop a `.clang-format` in a project root and it
  wins over the global one for that tree.

## Key choices (CLion defaults)

| Setting | Value | Effect |
| --- | --- | --- |
| `IndentWidth` / `TabWidth` | `4`, spaces | 4-space indent, no tabs |
| `ContinuationIndentWidth` | `8` | wrapped lines indent by 8 |
| `AccessModifierOffset` | `-4` | `public:` / `private:` dedent back 4 |
| `NamespaceIndentation` | `All` | namespace bodies are indented |
| `BreakBeforeBraces` | `Custom` (attached) | `int f() {` on the same line |
| `PointerAlignment` | `Right` | `int *data` |
| `AllowShortBlocksOnASingleLine` | `Always` | `if (x) { return x; }` stays one line |
| `IndentCaseLabels` | `true` | `case` labels indented under `switch` |
| `ColumnLimit` | `0` | **no automatic line wrapping** |

### Note on `ColumnLimit: 0`

CLion's default disables clang-format's column-based wrapping (CLion does its
own wrapping in-editor). If you want clang-format to hard-wrap, set
`ColumnLimit: 120` (CLion's hard-wrap default).

## Reproduce on a new machine

Copy the config to `~/.clang-format`. Verify with:

```sh
clang-format --style=file -dump-config | grep -E 'IndentWidth|AccessModifierOffset|NamespaceIndentation|ColumnLimit'
```

Expected: `IndentWidth: 4`, `AccessModifierOffset: -4`,
`NamespaceIndentation: All`, `ColumnLimit: 0`.
