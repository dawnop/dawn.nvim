# ☄️ Dawn.nvim

[English](README.md) | [中文](README_zh.md)

A deliberately **minimal** Neovim + tmux setup, tuned for **Python and C/C++**
development with **Claude Code** for AI pair programming. Built on
[Kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim), then trimmed and
reorganized so every plugin is one small, self-contained file.

## ✨ Highlights

- **One file per plugin** under `nvim/lua/dawn/plugins/`, auto-loaded by
  lazy.nvim's `{ import = 'dawn.plugins' }` — add a file, get a plugin.
- **VSCode-style ergonomics** — Tab-to-accept completion, a command-line popup
  menu, a command palette, and toggleable bottom/right/float terminals.
- **AI built in** — Claude Code integration under `<leader>c`.
- **Batteries for Python & C/C++** — LSP (pyright/ruff/clangd), format-on-save,
  linting, treesitter (incl. `cuda`), and a LeetCode workflow.
- **tmux included** — a matching tmux config with seamless vim ⇄ tmux pane
  navigation, installed by the same script.

---

## 📦 Installation

### Requirements

| Tool | Why |
|------|-----|
| **Neovim** ≥ 0.10 (0.11+ recommended) | Core |
| **Git** | Plugin manager + version control |
| **A Nerd Font** | Icons |
| **ripgrep** (`rg`) | Telescope live grep |
| **make**, **unzip** | Build native bits (fzf-native, LuaSnip) |
| **Node.js** | Several LSP servers |
| **tmux** (optional) | If you want the tmux config |

Check your setup any time with `:checkhealth dawn`.

### Quick install

```bash
git clone https://github.com/dawnop/dawn.nvim.git ~/.config/dawn.nvim
cd ~/.config/dawn.nvim
chmod +x install.sh
./install.sh
```

The script symlinks `nvim/` → `~/.config/nvim` and `tmux/tmux.conf` →
`~/.config/tmux/tmux.conf`, backing up anything already there (with a
timestamp). On first launch, lazy.nvim bootstraps itself and installs every
plugin; Mason then installs the LSP servers and tools.

---

## 📁 Layout

```
.
├── install.sh              # Symlink installer (nvim + tmux), with backups
├── docs/                   # Machine-level config notes (outside the repo)
│   ├── clang-format.md     # Global CLion-style ~/.clang-format
│   └── cuda-macos.md       # CUDA .cu/.cuh intellisense on macOS (no GPU)
├── nvim/
│   ├── init.lua            # Bootstrap lazy.nvim + { import = 'dawn.plugins' }
│   └── lua/dawn/
│       ├── options.lua     # Editor options
│       ├── keymaps.lua     # Global, non-plugin keymaps
│       ├── health.lua      # :checkhealth dawn
│       └── plugins/        # One spec file per plugin, auto-imported
└── tmux/
    └── tmux.conf           # tmux config (prefix C-a, vim-aware navigation)
```

---

## 🔌 Plugins

### AI

| Plugin | What it does |
|--------|--------------|
| [claudecode.nvim](https://github.com/coder/claudecode.nvim) | Claude Code in a terminal split; send buffers/selections, accept/deny diffs |

### Completion

| Plugin | What it does |
|--------|--------------|
| [blink.cmp](https://github.com/saghen/blink.cmp) | Fast completion; first item is preselected but not inserted — Tab/Enter accepts |
| [LuaSnip](https://github.com/L3MON4D3/LuaSnip) | Snippet engine, jumped with Tab/Shift-Tab |
| [lazydev.nvim](https://github.com/folke/lazydev.nvim) | Lua LS tuned for editing this config |

### Navigation & search

| Plugin | What it does |
|--------|--------------|
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | Fuzzy finder for files, grep, symbols, commands |
| [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) | File explorer (`<C-e>`), closes on open for a clean layout |
| [leap.nvim](https://codeberg.org/andyg/leap.nvim) | Two-keystroke jumps anywhere on screen |
| [grug-far.nvim](https://github.com/MagicDuck/grug-far.nvim) | Project-wide find & replace |

### Git

| Plugin | What it does |
|--------|--------------|
| [neogit](https://github.com/NeogitOrg/neogit) | Magit-like Git UI (`<leader>ng`) |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Gutter signs + hunk staging/preview/blame |
| [diffview.nvim](https://github.com/sindrets/diffview.nvim) | Diff viewer (used by Neogit) |

### Language tooling

| Plugin | What it does |
|--------|--------------|
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) + [mason.nvim](https://github.com/mason-org/mason.nvim) | LSP setup; auto-installs `pyright`, `ruff`, `clangd` |
| [conform.nvim](https://github.com/stevearc/conform.nvim) | Format-on-save: `stylua`, `ruff_format`, `clang_format` |
| [nvim-lint](https://github.com/mfussenegger/nvim-lint) | `markdownlint` (md), `eslint` (ts) |
| [fidget.nvim](https://github.com/j-hui/fidget.nvim) | LSP progress UI |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Highlighting for bash/c/cpp/cuda/lua/markdown/… |
| [leetcode.nvim](https://github.com/kawre/leetcode.nvim) | Solve LeetCode (leetcode.cn) in C++ inside Neovim |

### Editing & UI

| Plugin | What it does |
|--------|--------------|
| [tokyonight.nvim](https://github.com/folke/tokyonight.nvim) + [transparent.nvim](https://github.com/xiyaowong/transparent.nvim) | Colorscheme with a transparent background |
| [mini.nvim](https://github.com/echasnovski/mini.nvim) | Statusline, `surround`, and `a`/`i` text objects |
| [which-key.nvim](https://github.com/folke/which-key.nvim) | Pops up the keys available after a prefix |
| [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim) | Toggleable bottom/right/float terminals |
| [todo-comments.nvim](https://github.com/folke/todo-comments.nvim) | Highlights TODO/FIXME/etc. |
| [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) | Indent guides |
| [nvim-autopairs](https://github.com/windwp/nvim-autopairs) | Auto-close brackets/quotes |
| [guess-indent.nvim](https://github.com/NMAC427/guess-indent.nvim) | Detects a file's indentation |
| [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator) | One set of keys to move across vim splits and tmux panes |

---

## ⌨️ Keybindings

Leader is `<Space>`. Forgot a key? Press a prefix (`<Space>`, `g`, …) and pause —
**which-key** shows what's available. `<leader>?` lists everything; `<leader>sk`
fuzzy-searches all keymaps.

### Essentials

| Key | Action |
|-----|--------|
| `<Space>` | Leader |
| `;` | Enter command mode (`:`) |
| `jk` | Escape (insert & terminal mode) |
| `<Esc>` | Clear search highlight |
| `<Esc><Esc>` | Exit terminal mode |
| `tn` / `tj` / `tk` | New tab / next tab / previous tab |
| `<C-h/j/k/l>` | Move between splits & tmux panes · `<C-\>` last pane |
| `e` / `E` | Leap motion / leap from another window |

### Files, search & terminals

| Key | Action |
|-----|--------|
| `<C-e>` | Toggle / reveal file tree |
| `<C-p>` / `<leader>sf` | Find files |
| `<leader>sg` | Live grep · `<leader>s/` grep open files |
| `<leader>sw` | Grep word under cursor |
| `<leader>/` | Fuzzy-find in current buffer |
| `<leader><leader>` | Switch buffers |
| `<leader>sc` | Command palette (search commands) |
| `<leader>sk` / `<leader>sh` | Search keymaps / help |
| `<leader>sd` / `<leader>sr` | Diagnostics / resume last picker |
| `<leader>s.` / `<leader>sn` | Recent files / Neovim config files |
| `<leader>gs` | Project-wide find & replace (grug-far) |
| `<leader>tt` / `tv` / `tf` | Terminal: bottom / right / float |

> In a Telescope picker: `<C-j>`/`<C-k>` move, `<C-t>` opens in a tab, `<Esc>` closes.

### LSP & diagnostics

| Key | Action |
|-----|--------|
| `grn` / `gra` | Rename / code action |
| `grd` / `grD` | Definition / declaration |
| `grr` / `gri` / `grt` | References / implementation / type definition |
| `gO` / `gW` | Document / workspace symbols |
| `L` | Line diagnostics (float) · `<leader>q` send to loclist |
| `<leader>th` | Toggle inlay hints |
| `<leader>yd` | Yank diagnostic as `file:line:col: message` |
| `<leader>f` | Format buffer |

### Git (gitsigns)

| Key | Action |
|-----|--------|
| `]c` / `[c` | Next / previous hunk |
| `<leader>hs` / `<leader>hr` | Stage / reset hunk (works on a visual range too) |
| `<leader>hS` / `<leader>hR` / `<leader>hu` | Stage buffer / reset buffer / undo stage |
| `<leader>hp` / `<leader>hb` | Preview hunk / blame line |
| `<leader>hd` / `<leader>hD` | Diff against index / last commit |
| `<leader>tb` / `<leader>tD` | Toggle line blame / inline deleted |
| `<leader>ng` | Open Neogit |

### Claude Code

| Key | Action |
|-----|--------|
| `<leader>cc` / `<leader>cf` | Toggle / focus Claude terminal |
| `<leader>cr` / `<leader>cC` | Resume / continue conversation |
| `<leader>cm` | Select model |
| `<leader>cb` / `<leader>cs` | Add buffer / send selection (or add file from tree) |
| `<leader>ca` / `<leader>cd` | Accept / deny diff |

---

## 🧠 Language tooling

- **Python** — `pyright` + `ruff` LSP, `ruff_format` on save.
- **C/C++** — `clangd` LSP and `clang_format`. Format-on-save is **off** for
  C/C++ (run `<leader>f` instead); treesitter indent is disabled in favour of
  the built-in `cindent`. A global CLion-style formatter config is documented in
  [`docs/clang-format.md`](docs/clang-format.md).
- **CUDA** — treesitter `cuda` highlighting, plus an optional clangd-only
  intellisense setup for `.cu`/`.cuh` on macOS (no GPU/toolkit needed),
  documented in [`docs/cuda-macos.md`](docs/cuda-macos.md).
- **LeetCode** — `:Leet` opens the dashboard (`nvim leetcode.nvim` to start
  standalone). STL headers are injected into each problem inside foldable
  `@leet imports` markers so clangd resolves `vector`/`sort`/etc.; they are not
  sent on submit, and the libc++-incompatible `<bits/stdc++.h>` is dropped.

---

## 🪟 tmux

Installed alongside Neovim. Prefix is **`C-a`**; copy mode is vi-style and yanks
to the system clipboard (`pbcopy`).

| Key | Action |
|-----|--------|
| `prefix` + <code>&#124;</code> / `_` | Split right / down (full size) |
| `prefix` + `\` / `-` | Split right / down (25%) |
| `prefix` + `c` | New window in the current path |
| `prefix` + `H/J/K/L` | Resize pane |
| `prefix` + `r` | Reload config |
| `C-h/j/k/l` | Move between panes — **vim-aware**, same keys as splits |
| `C-s` | Toggle a floating popup session |
| `Shift-Left` / `Shift-Right` | Previous / next window |

---

## 🔧 Customizing

- **Add a plugin** — drop a new `lua/dawn/plugins/whatever.lua` returning a
  lazy.nvim spec. It's imported automatically; no list to edit.
- **Change options/keymaps** — `lua/dawn/options.lua` and
  `lua/dawn/keymaps.lua`.
- **Pin versions** — `nvim/lazy-lock.json` is committed; `:Lazy restore` brings
  any machine back to the locked set.

---

## 📝 License

MIT
