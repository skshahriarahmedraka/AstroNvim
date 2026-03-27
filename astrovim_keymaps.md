# AstroVim Configuration & Keymaps Guide

**Generated on:** March 27, 2026  
**Base:** AstroVim v4  
**Theme:** Catppuccin Mocha

---

## Table of Contents

1. [Quick Start](#quick-start)
2. [Core Keymaps](#core-keymaps)
3. [Leader Key Reference](#leader-key-reference)
4. [Plugin-Specific Guides](#plugin-specific-guides)
5. [Language Support](#language-support)
6. [Workflow Examples](#workflow-examples)

---

## Quick Start

### Essential Keys for Beginners

| Key | Action |
|-----|--------|
| `<Space>` | Leader key (press then release, then press next key) |
| `gg` | Go to top of file |
| `G` | Go to bottom of file |
| `:w` | Save file |
| `:q` | Quit |
| `:q!` | Quit without saving |
| `u` | Undo |
| `<C-r>` | Redo |
| `/pattern` | Search for pattern |
| `n` / `N` | Next / Previous search result |

### First Time Setup

1. **Install Language Servers**: Run `:Mason` to install LSP servers
2. **Verify Installation**: Run `:Lazy` to check plugin status
3. **Test Keymaps**: Press `<leader>?` to see available keymaps

---

## Core Keymaps

### Normal Mode

#### Window Management

| Key | Command | Description |
|-----|---------|-------------|
| `<C-H>` | `vim.fn.winmove('left')` | Move window left |
| `<C-J>` | `vim.fn.winmove('down')` | Move window down |
| `<C-K>` | `vim.fn.winmove('up')` | Move window up |
| `<C-L>` | `vim.fn.winmove('right')` | Move window right |
| `<leader>w` | `<C-w>` prefix | Window commands (Which-Key) |
| `<C-w><Space>` | Which-Key window mode | Hydra mode for windows |

#### Buffer Management (Barbar)

| Key | Command | Description |
|-----|---------|-------------|
| `<A-,>` | `:BufferPrevious` | Previous buffer |
| `<A-.>` | `:BufferNext` | Next buffer |
| `<A-<` | `:BufferMovePrevious` | Move buffer left |
| `<A->` | `:BufferMoveNext` | Move buffer right |
| `<A-1>` to `<A-9>` | `:BufferGoto N` | Jump to buffer N |
| `<A-0>` | `:BufferLast` | Last buffer |
| `<A-p>` | `:BufferPin` | Pin/unpin buffer |
| `<A-c>` | `:BufferClose` | Close buffer |
| `<A-x>` | `:BufferClose` | Close buffer (alternative) |
| `<C-p>` | `:BufferPick` | Pick buffer |

#### File Explorer (Neo-tree)

| Key | Command | Description |
|-----|---------|-------------|
| `<leader>e` | `:Neotree toggle` | Toggle file explorer |
| `<leader>E` | `:Neotree focus` | Focus file explorer |

Neo-tree is positioned on the **right side** of the editor.

#### Terminal

| Key | Command | Description |
|-----|---------|-------------|
| `<F7>` | `:ToggleTerm` | Toggle terminal |
| `<C-'>` | `:ToggleTerm` | Toggle terminal (alternative) |
| `<C-\>` | `:ToggleTerm` | Toggle terminal (alternative) |

In terminal mode, use `<C-H/J/K/L>` to navigate between windows.

---

## Leader Key Reference

### `<leader>f` - File/Find Operations

| Key | Command | Description |
|-----|---------|-------------|
| `<leader>ff` | Telescope find_files | Find files |
| `<leader>fg` | Telescope live_grep | Grep/search in files |
| `<leader>fb` | Telescope buffers | List buffers |
| `<leader>fh` | Telescope help_tags | Search help |
| `<leader>fr` | Telescope oldfiles | Recent files |
| `<leader>fc` | Telescope find_files (cwd) | Find in config |
| `<leader>fp` | Telescope projects | Projects |

### `<leader>s` - Search

| Key | Command | Description |
|-----|---------|-------------|
| `<leader>sw` | Spectre search word | Search word under cursor |
| `<leader>sf` | Spectre file search | Search in current file |
| `<leader>st` | Spectre toggle | Toggle Spectre |
| `<leader>sv` | Spectre visual | Search visual selection |

### `<leader>g` - Git Operations (Fugitive + Gitsigns)

#### Git Status & Staging

| Key | Command | Description |
|-----|---------|-------------|
| `<leader>gs` | `:Git` | Git status |
| `<leader>ga` | `:Git add %` | Add current file |
| `<leader>gA` | `:Git add .` | Add all files |
| `<leader>gc` | `:Git commit` | Commit changes |
| `<leader>gp` | `:Git push` | Push changes |
| `<leader>gP` | `:Git pull` | Pull changes |

#### Git History

| Key | Command | Description |
|-----|---------|-------------|
| `<leader>gB` | `:Git blame` | Git blame |
| `<leader>gl` | `:Git log --oneline` | Git log (oneline) |
| `<leader>gL` | `:Git log` | Git log (detailed) |
| `<leader>gv` | `:DiffviewOpen` | Open diff view |
| `<leader>gh` | `:DiffviewFileHistory %` | File history |

#### Git Hunks (Gitsigns)

| Key | Command | Description |
|-----|---------|-------------|
| `<leader>gs` | `gitsigns.stage_hunk` | Stage hunk |
| `<leader>gr` | `gitsigns.reset_hunk` | Reset hunk |
| `<leader>gS` | `gitsigns.stage_buffer` | Stage buffer |
| `<leader>gu` | `gitsigns.undo_stage_hunk` | Undo stage |
| `<leader>gR` | `gitsigns.reset_buffer` | Reset buffer |
| `<leader>gp` | `gitsigns.preview_hunk` | Preview hunk |
| `<leader>gb` | `gitsigns.blame_line` | Blame line |
| `<leader>gd` | `gitsigns.diffthis` | Diff |
| `<leader>gD` | `gitsigns.diffthis "~"` | Diff vs HEAD |
| `<leader>tb` | Toggle line blame | Toggle blame |
| `<leader>td` | Toggle deleted | Toggle deleted signs |
| `]c` | Next hunk | Navigate to next hunk |
| `[c` | Previous hunk | Navigate to previous hunk |
| `ih` | Select hunk | Text object for hunk |

#### Branch Operations

| Key | Command | Description |
|-----|---------|-------------|
| `<leader>gco` | `:Git checkout ` | Checkout branch |
| `<leader>gcb` | `:Git checkout -b ` | Create new branch |
| `<leader>gm` | `:Git merge ` | Merge branch |

#### Stash Operations

| Key | Command | Description |
|-----|---------|-------------|
| `<leader>gss` | `:Git stash` | Stash changes |
| `<leader>gsp` | `:Git stash pop` | Pop stash |
| `<leader>gsl` | `:Git stash list` | List stashes |

### `<leader>c` - Code Operations

| Key | Command | Description |
|-----|---------|-------------|
| `<leader>cc` | Code actions | LSP code actions |
| `<leader>cr` | Rename | LSP rename symbol |
| `<leader>ca` | Code action | LSP code action |
| `<leader>cd` | Definition | Go to definition |
| `<leader>cD` | Declaration | Go to declaration |
| `<leader>ci` | Implementation | Go to implementation |
| `<leader>ct` | Type definition | Go to type definition |
| `<leader>cr` | References | Find references |
| `<leader>cs` | Signature help | Show signature |

### `<leader>d` - Debug (DAP)

| Key | Command | Description |
|-----|---------|-------------|
| `<F5>` | `dap.continue()` | Continue debugging |
| `<F10>` | `dap.step_over()` | Step over |
| `<F11>` | `dap.step_into()` | Step into |
| `<S-F11>` | `dap.step_out()` | Step out |
| `<leader>dc` | `dap.continue()` | Continue |
| `<leader>so` | `dap.step_over()` | Step over |
| `<leader>si` | `dap.step_into()` | Step into |
| `<leader>su` | `dap.step_out()` | Step out |
| `<leader>db` | Toggle breakpoint | Toggle breakpoint |
| `<leader>dB` | Clear breakpoints | Clear all breakpoints |
| `<leader>dt` | Toggle DAP UI | Toggle debug UI |
| `<leader>dn` | Open DAP UI | Open debug UI |
| `<leader>dk` | Terminate | Terminate session |
| `<leader>dr` | Restart | Restart session |
| `<leader>dp` | Show log | Show DAP log |
| `K` | Evaluate | Evaluate expression |

### `<leader>S` - Sessions (Auto-Session)

| Key | Command | Description |
|-----|---------|-------------|
| `<leader>Ss` | Save session | Save current session |
| `<leader>Sr` | Restore session | Restore session |
| `<leader>Sd` | Delete session | Delete session |
| `<leader>Sf` | Find sessions | Search sessions |
| `<leader>S.` | Restore from file | Restore session file |
| `<leader>Q` | Save & quit all | Save and quit |
| `<leader>q` | Save & quit | Save and quit current |
| `ZZ` | Save & write quit | Save all and quit |

### `<leader>cc` - Copilot Chat

| Key | Command | Description |
|-----|---------|-------------|
| `<leader>ccq` | Toggle chat | Toggle Copilot Chat |
| `<leader>ccx` | Reset chat | Reset current chat |
| `<leader>ccs` | Save chat | Save chat session |
| `<leader>ccl` | Load chat | Load chat session |

#### Code Analysis (Normal/Visual Mode)

| Key | Command | Description |
|-----|---------|-------------|
| `<leader>cce` | Explain | Explain selected code |
| `<leader>ccr` | Review | Review selected code |
| `<leader>ccf` | Fix | Fix selected code |
| `<leader>cco` | Optimize | Optimize code |
| `<leader>ccd` | Docs | Generate documentation |
| `<leader>cct` | Tests | Generate tests |
| `<leader>ccD` | Fix diagnostic | Fix diagnostics |
| `<leader>ccm` | Commit message | Generate commit message |
| `<leader>ccM` | Commit staged | Commit for staged changes |

#### Agent Modes

| Key | Command | Description |
|-----|---------|-------------|
| `<leader>cca` | General Agent | General AI assistant |
| `<leader>ccA` | Code Agent | Code review specialist |
| `<leader>ccb` | Debug Agent | Debugging expert |
| `<leader>ccR` | Refactor Agent | Refactoring specialist |

#### Visual Mode Specific

| Key | Command | Description |
|-----|---------|-------------|
| `<leader>ccv` | Visual chat | Chat with selection |
| `<leader>ccV` | In-place chat | Chat in place |

#### Working with Results

| Key | Command | Description |
|-----|---------|-------------|
| `<C-y>` | Accept | Accept suggested changes |
| `gy` | Yank | Copy suggested changes |
| `gd` | Show diff | Show diff of changes |

### `<leader>u` - UI Toggles

| Key | Command | Description |
|-----|---------|-------------|
| `<leader>us` | Toggle spelling | Toggle spell checker |
| `<leader>uw` | Toggle wrap | Toggle line wrap |
| `<leader>uL` | Toggle relative numbers | Toggle line numbers |
| `<leader>ud` | Toggle diagnostics | Toggle diagnostics |
| `<leader>ul` | Toggle line numbers | Toggle line display |
| `<leader>uc` | Toggle conceal | Toggle conceal level |
| `<leader>uT` | Toggle treesitter | Toggle Treesitter |
| `<leader>ub` | Toggle background | Toggle dark/light |
| `<leader>uh` | Toggle inlay hints | Toggle LSP hints |
| `<leader>ug` | Toggle indent | Toggle indent guides |
| `<leader>uD` | Toggle dim | Toggle dim inactive |

### `<leader>x` - Diagnostics/Quickfix

| Key | Command | Description |
|-----|---------|-------------|
| `<leader>xx` | Open diagnostics | Open diagnostics panel |
| `<leader>xn` | Next diagnostic | Jump to next |
| `<leader>xp` | Previous diagnostic | Jump to previous |
| `<leader>xl` | Location list | Open location list |
| `<leader>xq` | Quickfix list | Open quickfix list |

### `<leader>b` - Buffer Operations

| Key | Command | Description |
|-----|---------|-------------|
| `<leader>bd` | Delete buffer | Close current buffer |
| `<leader>bb` | Order by number | Sort buffers |
| `<leader>bo` | Order by directory | Sort by directory |
| `<leader>bl` | Order by language | Sort by language |

### `<leader>w` - Windows

Access via `<leader>w` or `<C-w>` prefix for all standard window commands.

### `<leader>?` - Which-Key

| Key | Command | Description |
|-----|---------|-------------|
| `<leader>?` | Show keymaps | Show buffer-local keymaps |

---

## Plugin-Specific Guides

### Telescope

Telescope is configured with horizontal layout and fuzzy finding.

**Basic Usage:**
1. Press `<leader>ff` to find files
2. Type to fuzzy search
3. Use `<C-j>` / `<C-k>` to navigate
4. Press `<CR>` to open

**Advanced Features:**
- Use `./` to search in current directory
- Use `..` to go up a directory
- Use `*` as wildcard

### Gitsigns

Gitsigns provides Git integration with visual indicators.

**Visual Indicators:**
- `+` in green: Added lines
- `~` in yellow: Modified lines
- `_` in red: Deleted lines

**Workflow:**
1. Edit files (indicators appear automatically)
2. Stage hunks with `<leader>gs`
3. Preview with `<leader>gp`
4. Commit with `<leader>gc`

### DAP (Debug Adapter Protocol)

**Starting a Debug Session (Go):**

1. Open a Go file
2. Set breakpoints with `<leader>db`
3. Start debugging with `<F5>` or `<leader>dc`

**Debug UI Components:**
- **Left Panel**: Scopes, Breakpoints, Stack traces
- **Bottom Panel**: Interactive console
- **Inline Values**: Variable values shown in code

**Common Workflow:**
```
1. Open file → 2. Set breakpoints → 3. Press F5 → 4. Step through code
```

### Copilot

**Accepting Suggestions:**
- `<Tab>` - Accept full suggestion
- `<C-j>` / `<C-k>` - Navigate suggestions
- `<C-o>` - Dismiss suggestion
- `<C-s>` - Force suggestion

### Barbar (Buffer Tabs)

The buffer line shows at the top with:
- File icons and names
- Git status indicators (+/~/-)
- Diagnostic indicators
- Modified indicator (●)

**Pinning Buffers:**
- `<A-p>` to pin important buffers
- Pinned buffers stay on the left

### Neo-tree

File explorer positioned on the right side.

**Neo-tree Keymaps:**
- `<CR>` - Open file/folder
- `h` - Collapse/Go up
- `l` - Expand/Open
- `a` - Create file/folder
- `d` - Delete
- `r` - Rename
- `H` - Toggle hidden files
- `?` - Show help

### Satellite

Scrollbar on the right showing:
- Cursor position
- Search matches
- Diagnostics (colored marks)
- Git changes
- Bookmarks

### Lualine

Status line showing:
- Mode (single character)
- Git branch
- File changes (+/-)
- Filename with status
- Diagnostics count
- LSP clients
- Treesitter status
- Encoding, format, filetype
- Progress and location

### Render Markdown / Markview

Automatically renders Markdown with:
- Headers with icons
- Checkboxes
- Code blocks with language icons
- Tables with borders
- Callouts and quotes

### Colorizer

Shows color previews for:
- CSS/SCSS colors
- RGB/RGBA values
- Named colors in HTML/JS/TS

### Crates.nvim (Rust)

When editing `Cargo.toml`:
- Inline version information
- Completion for crate versions
- LSP integration

---

## Language Support

### Go

**Plugins:**
- `gopls` - Language server
- `delve` - Debugger
- `goimports` - Formatter

**Key Features:**
- Run tests with `<leader>t`
- Debug with DAP
- Auto-import on save

### Rust

**Plugins:**
- `rust-analyzer` - Full LSP support
- `codelldb` - Debugger
- `crates.nvim` - Dependency management

**Key Features:**
- Clippy integration
- Inlay hints
- Debug with `<F5>`

### Zig

**Plugins:**
- `zls` - Language server
- `neotest-zig` - Testing

**Configuration:**
- Snippets enabled
- Semantic tokens
- Inlay hints
- Style warnings

### TypeScript/JavaScript

**Plugins:**
- `tsserver` - Language server
- ESLint integration

**Features:**
- Auto-imports
- Type checking
- Refactoring

### Web Development

**Supported:**
- HTML/CSS/SCSS
- Vue.js
- Svelte
- JSON/YAML
- Terraform
- Protobuf
- Helm charts

---

## Workflow Examples

### Git Workflow

```bash
# 1. Check status
<leader>gs

# 2. Stage current file
<leader>ga

# 3. Stage specific hunks
<leader>gs (on hunk)

# 4. Commit
<leader>gc

# 5. Push
<leader>gp
```

### Debugging Go Code

```
1. Open main.go
2. Set breakpoints: <leader>db on lines
3. Start debug: <F5>
4. Step over: <F10>
5. Step into: <F11>
6. Evaluate: K on variable
7. Continue: <F5>
```

### Code Review with Copilot

```
1. Select code (visual mode)
2. Review: <leader>ccr
3. Read suggestions in chat
4. Accept: <C-y> or copy: gy
```

### Session Management

```
# Start work
cd project && nvim

# Auto-restore happens automatically

# End work
<leader>Q  # Save session and quit

# Resume later
cd project && nvim
# Session auto-restores
```

### Finding and Replacing

```
# Search for word under cursor
<leader>Sw

# Search in current file
<leader>Sf

# Search visual selection
Select text, then <leader>Sv

# In Spectre:
- Type replacement in second field
- Press <CR> to replace all
```

---

## Configuration Files

### Plugin Configuration
- `lua/plugins/` - Individual plugin configs
- `lua/config/keymaps.lua` - Custom keymaps
- `lua/user/autocmds.lua` - User autocmds

### Key Locations
- Sessions: `~/.local/share/nvim/sessions/`
- Lazy plugins: `~/.local/share/nvim/lazy/`
- Mason tools: `~/.local/share/nvim/mason/`

---

## Troubleshooting

### Common Issues

**LSP not working:**
```
:Mason
# Install language servers
```

**Plugins not loading:**
```
:Lazy sync
```

**Session not restoring:**
```
:SessionLoad
```

**Debug not starting:**
```
:DapShowLog
```

### Useful Commands

| Command | Description |
|---------|-------------|
| `:Lazy` | Plugin manager UI |
| `:Mason` | LSP/Tool installer |
| `:Checkhealth` | Neovim health check |
| `:Telescope` | Fuzzy finder |
| `:CopilotChat` | AI chat |
| `:DapToggleBreakpoint` | Toggle breakpoint |

---

## Tips & Best Practices

1. **Learn incrementally**: Start with basic navigation, add more as needed
2. **Use Which-Key**: Press `<leader>?` to discover keymaps
3. **Customize**: Edit `lua/config/keymaps.lua` for personal mappings
4. **Sessions**: Use `<leader>Q` to save and quit for easy resume
5. **Git integration**: Stage hunks individually for cleaner commits
6. **Debugging**: Use DAP instead of print statements
7. **Copilot**: Review AI suggestions before accepting

---

## Additional Resources

- `:h astrovim` - AstroVim documentation
- `:h telescope` - Telescope documentation
- `:h gitsigns` - Gitsigns documentation
- `:h dap` - DAP documentation

---

*This guide is auto-generated from your AstroVim configuration. For the most current keymaps, use `<leader>?` in Neovim.*
