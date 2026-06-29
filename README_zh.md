# ☄️ Dawn.nvim

[English](README.md) | [中文](README_zh.md)

我个人日常做 **AI Infra** 工作用的 Neovim + tmux 配置——训练/推理代码用
**Python**，性能敏感的 **C/C++/CUDA** 算子，以及大量通过 SSH + tmux 的远程会话。
配置刻意保持**精简**，并集成 **Claude Code** 做 AI 结对编程。基于
[Kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) 精简重组而成，
每个插件都是一个独立的小文件。

> 定位：个人自用配置，公开出来仅供参考。默认设置都是围绕 AI Infra 工作流
> （Python + C/C++/CUDA、clangd/pyright、远程 tmux）来的，并非通用发行版。

## ✨ 亮点

- **一个插件一个文件**，放在 `nvim/lua/dawn/plugins/` 下，由 lazy.nvim 的
  `{ import = 'dawn.plugins' }` 自动加载——加个文件就多个插件。
- **VSCode 式手感**——Tab 接受补全、命令行弹出菜单、命令面板，以及可切换的
  底部/右侧/浮动终端。
- **内置 AI**——Claude Code 集成在 `<leader>c` 下。
- **Python 与 C/C++ 开箱即用**——LSP（pyright/ruff/clangd）、保存即格式化、
  代码检查、Tree-sitter（含 `cuda`），以及 LeetCode 工作流。
- **自带 tmux**——配套的 tmux 配置，vim ⇄ tmux 面板无缝切换，由同一脚本安装。

---

## 📦 安装

### 前置要求

| 工具 | 用途 |
|------|------|
| **Neovim** ≥ 0.10（推荐 0.11+） | 核心 |
| **Git** | 插件管理 + 版本控制 |
| **Nerd Font** | 图标 |
| **ripgrep**（`rg`） | Telescope 实时搜索 |
| **make**、**unzip** | 编译原生组件（fzf-native、LuaSnip） |
| **Node.js** | 部分 LSP 服务器 |
| **tmux**（可选） | 需要 tmux 配置时 |

随时用 `:checkhealth dawn` 检查环境。

### 快速安装

```bash
git clone https://github.com/dawnop/dawn.nvim.git ~/.config/dawn.nvim
cd ~/.config/dawn.nvim
chmod +x install.sh
./install.sh
```

脚本会把 `nvim/` 软链到 `~/.config/nvim`、`tmux/tmux.conf` 软链到
`~/.config/tmux/tmux.conf`，并对已有文件做带时间戳的备份。首次启动时
lazy.nvim 自举并安装所有插件，随后 Mason 安装 LSP 服务器和工具。

---

## 📁 目录结构

```
.
├── install.sh              # 软链安装脚本（nvim + tmux），自动备份
├── docs/                   # 机器级配置说明（位于仓库外）
│   ├── clang-format.md     # 全局 CLion 风格 ~/.clang-format
│   └── cuda-macos.md       # macOS 上 .cu/.cuh 的 CUDA 智能提示（无需 GPU）
├── nvim/
│   ├── init.lua            # 自举 lazy.nvim + { import = 'dawn.plugins' }
│   └── lua/dawn/
│       ├── options.lua     # 编辑器选项
│       ├── keymaps.lua     # 全局（非插件）快捷键
│       ├── health.lua      # :checkhealth dawn
│       └── plugins/        # 每个插件一个 spec 文件，自动导入
└── tmux/
    └── tmux.conf           # tmux 配置（prefix C-a，vim 感知导航）
```

---

## 🔌 插件

### AI

| 插件 | 作用 |
|------|------|
| [claudecode.nvim](https://github.com/coder/claudecode.nvim) | 终端分屏里的 Claude Code；发送缓冲区/选区，接受/拒绝 diff |

### 补全

| 插件 | 作用 |
|------|------|
| [blink.cmp](https://github.com/saghen/blink.cmp) | 快速补全；首项自动高亮但不插入——Tab/Enter 才接受 |
| [LuaSnip](https://github.com/L3MON4D3/LuaSnip) | 代码片段引擎，Tab/Shift-Tab 跳转 |
| [lazydev.nvim](https://github.com/folke/lazydev.nvim) | 为编辑本配置优化的 Lua LS |

### 导航与搜索

| 插件 | 作用 |
|------|------|
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | 模糊查找文件、内容、符号、命令 |
| [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) | 文件树（`<C-e>`），打开文件后自动关闭以保持简洁 |
| [leap.nvim](https://codeberg.org/andyg/leap.nvim) | 两个字符跳转到屏幕任意位置 |
| [grug-far.nvim](https://github.com/MagicDuck/grug-far.nvim) | 跨项目查找替换 |

### Git

| 插件 | 作用 |
|------|------|
| [neogit](https://github.com/NeogitOrg/neogit) | 类 Magit 的 Git 界面（`<leader>ng`） |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | 改动标记 + hunk 暂存/预览/blame |
| [diffview.nvim](https://github.com/sindrets/diffview.nvim) | diff 查看器（被 Neogit 使用） |

### 语言工具

| 插件 | 作用 |
|------|------|
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) + [mason.nvim](https://github.com/mason-org/mason.nvim) | LSP 配置；自动安装 `pyright`、`ruff`、`clangd` |
| [conform.nvim](https://github.com/stevearc/conform.nvim) | 保存即格式化：`stylua`、`ruff_format`、`clang_format` |
| [nvim-lint](https://github.com/mfussenegger/nvim-lint) | `markdownlint`（md）、`eslint`（ts） |
| [fidget.nvim](https://github.com/j-hui/fidget.nvim) | LSP 进度提示 |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | bash/c/cpp/cuda/lua/markdown 等高亮 |
| [leetcode.nvim](https://github.com/kawre/leetcode.nvim) | 在 Neovim 里用 C++ 刷力扣（leetcode.cn） |

### 编辑与界面

| 插件 | 作用 |
|------|------|
| [tokyonight.nvim](https://github.com/folke/tokyonight.nvim) + [transparent.nvim](https://github.com/xiyaowong/transparent.nvim) | 配色 + 透明背景 |
| [mini.nvim](https://github.com/echasnovski/mini.nvim) | 状态栏、`surround`、`a`/`i` 文本对象 |
| [which-key.nvim](https://github.com/folke/which-key.nvim) | 按下前缀后弹出可用按键 |
| [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim) | 可切换的底部/右侧/浮动终端 |
| [todo-comments.nvim](https://github.com/folke/todo-comments.nvim) | 高亮 TODO/FIXME 等 |
| [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) | 缩进参考线 |
| [nvim-autopairs](https://github.com/windwp/nvim-autopairs) | 自动补全括号/引号 |
| [guess-indent.nvim](https://github.com/NMAC427/guess-indent.nvim) | 自动识别文件缩进 |
| [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator) | 一套按键在 vim 分屏和 tmux 面板间移动 |

---

## ⌨️ 快捷键

Leader 是 `<Space>`。忘了快捷键？按下前缀（`<Space>`、`g` 等）停顿一下，
**which-key** 会显示可用按键。`<leader>?` 列出全部；`<leader>sk` 模糊搜索所有快捷键。

### 基础

| 按键 | 操作 |
|------|------|
| `<Space>` | Leader |
| `;` | 进入命令模式（`:`） |
| `jk` | 退出（插入 & 终端模式） |
| `<Esc>` | 清除搜索高亮 |
| `<Esc><Esc>` | 退出终端模式 |
| `tn` / `tj` / `tk` | 新建标签页 / 下一个 / 上一个 |
| `<C-h/j/k/l>` | 在分屏与 tmux 面板间移动 · `<C-\>` 上一个面板 |
| `e` / `E` | Leap 跳转 / 从其他窗口跳转 |

### 文件、搜索与终端

| 按键 | 操作 |
|------|------|
| `<C-e>` | 开关/定位文件树 |
| `<C-p>` / `<leader>sf` | 查找文件 |
| `<leader>sg` | 实时搜索 · `<leader>s/` 搜索已打开文件 |
| `<leader>sw` | 搜索光标下单词 |
| `<leader>/` | 当前缓冲区模糊搜索 |
| `<leader><leader>` | 切换缓冲区 |
| `<leader>sc` | 命令面板（搜索命令） |
| `<leader>sk` / `<leader>sh` | 搜索快捷键 / 帮助 |
| `<leader>sd` / `<leader>sr` | 诊断 / 恢复上次搜索 |
| `<leader>s.` / `<leader>sn` | 最近文件 / Neovim 配置文件 |
| `<leader>gs` | 跨项目查找替换（grug-far） |
| `<leader>tt` / `tv` / `tf` | 终端：底部 / 右侧 / 浮动 |

> Telescope 选择器内：`<C-j>`/`<C-k>` 移动，`<C-t>` 在新标签页打开，`<Esc>` 关闭。

### LSP 与诊断

| 按键 | 操作 |
|------|------|
| `grn` / `gra` | 重命名 / 代码操作 |
| `grd` / `grD` | 跳转定义 / 声明 |
| `grr` / `gri` / `grt` | 引用 / 实现 / 类型定义 |
| `gO` / `gW` | 文档 / 工作区符号 |
| `L` | 行诊断（浮窗）· `<leader>q` 加入 loclist |
| `<leader>th` | 切换 inlay hints |
| `<leader>yd` | 复制诊断为 `文件:行:列: 信息` |
| `<leader>f` | 格式化缓冲区 |

### Git（gitsigns）

| 按键 | 操作 |
|------|------|
| `]c` / `[c` | 下一个 / 上一个 hunk |
| `<leader>hs` / `<leader>hr` | 暂存 / 重置 hunk（可视模式选区同样有效） |
| `<leader>hS` / `<leader>hR` / `<leader>hu` | 暂存整个缓冲区 / 重置缓冲区 / 撤销暂存 |
| `<leader>hp` / `<leader>hb` | 预览 hunk / 行 blame |
| `<leader>hd` / `<leader>hD` | 与索引 / 上次提交比较 |
| `<leader>tb` / `<leader>tD` | 切换行 blame / 内联显示删除 |
| `<leader>ng` | 打开 Neogit |

### Claude Code

| 按键 | 操作 |
|------|------|
| `<leader>cc` / `<leader>cf` | 开关 / 聚焦 Claude 终端 |
| `<leader>cr` / `<leader>cC` | 恢复 / 继续对话 |
| `<leader>cm` | 选择模型 |
| `<leader>cb` / `<leader>cs` | 添加缓冲区 / 发送选区（或从文件树添加文件） |
| `<leader>ca` / `<leader>cd` | 接受 / 拒绝 diff |

---

## 🧠 语言工具

- **Python**——`pyright` + `ruff` LSP，保存时 `ruff_format`。
- **C/C++**——`clangd` LSP 和 `clang_format`。C/C++ **不**保存即格式化
  （改用 `<leader>f`）；关闭了 tree-sitter 缩进，改用内置 `cindent`。
  全局 CLion 风格格式化配置见 [`docs/clang-format.md`](docs/clang-format.md)。
- **CUDA**——tree-sitter `cuda` 高亮，外加一套可选的、仅用于 clangd 的
  `.cu`/`.cuh` 智能提示方案（macOS 上无需 GPU/工具链），见
  [`docs/cuda-macos.md`](docs/cuda-macos.md)。
- **LeetCode**——`:Leet` 打开面板（`nvim leetcode.nvim` 可独立启动）。每道题会在
  可折叠的 `@leet imports` 标记内注入 STL 头文件，让 clangd 能解析
  `vector`/`sort` 等；提交时不会带上，且去掉了 libc++ 不兼容的
  `<bits/stdc++.h>`。

---

## 🪟 tmux

与 Neovim 一起安装。前缀是 **`C-a`**；复制模式为 vi 风格并复制到系统剪贴板
（`pbcopy`）。

| 按键 | 操作 |
|------|------|
| `prefix` + <code>&#124;</code> / `_` | 向右 / 向下分屏（满尺寸） |
| `prefix` + `\` / `-` | 向右 / 向下分屏（25%） |
| `prefix` + `c` | 在当前路径新建窗口 |
| `prefix` + `H/J/K/L` | 调整面板大小 |
| `prefix` + `r` | 重载配置 |
| `C-h/j/k/l` | 面板间移动——**vim 感知**，与分屏同一套键 |
| `C-s` | 开关浮动 popup 会话 |
| `Shift-Left` / `Shift-Right` | 上一个 / 下一个窗口 |

---

## 🔧 自定义

- **加插件**——新建一个 `lua/dawn/plugins/xxx.lua`，返回 lazy.nvim spec 即可，
  会被自动导入，无需改任何列表。
- **改选项/快捷键**——`lua/dawn/options.lua` 和 `lua/dawn/keymaps.lua`。
- **锁版本**——`nvim/lazy-lock.json` 已提交；在任意机器上 `:Lazy restore`
  即可还原到锁定的版本集合。

---

## 📝 许可证

MIT
