# AI Guide: Avante & Claude Code

Two complementary Claude integrations live in this config:

| | **Claude Code** (`claudecode.nvim`) | **Avante** (`avante.nvim`) |
|---|---|---|
| What it is | The official `claude` CLI in a terminal split, wired into Neovim like the VS Code extension | Cursor-style chat sidebar inside Neovim |
| Best for | Multi-file tasks, running tests/commands, refactors, git work, long agentic sessions | Quick questions about a selection, inline edits, small focused changes |
| Leader group | `<Leader>a` | `<Leader>A` |
| Config | `lua/plugins/claudecode.lua` | `lua/community.lua` + `lua/plugins/avante.lua` |

---

## 1. Prerequisites

| Requirement | Check | Notes |
|---|---|---|
| Neovim ≥ 0.10 | `nvim --version` | |
| Claude Code CLI | `claude --version` | Install: `curl -fsSL https://claude.ai/install.sh \| bash` |
| Logged in to Claude | `claude` then `/login` | Pro/Max subscription or Console account |
| Node.js + `npx` | `npx --version` | Only for Avante's `claude-code` provider |
| `curl`, `tar` | | Avante downloads prebuilt native libs on install |

Optional:

```sh
# Faster Avante startup (otherwise npx fetches the adapter on first use)
npm i -g @agentclientprotocol/claude-agent-acp

# Use the Anthropic API directly in Avante (pay-per-token) instead of your CLI login
export ANTHROPIC_API_KEY=...   # put this in your shell profile / secrets manager, never in the nvim config
```

After changing plugins: `:Lazy sync`, then `:checkhealth avante`.

---

## 2. Claude Code (`<Leader>a`)

`claudecode.nvim` starts a local WebSocket server (bound to `127.0.0.1`, token-authenticated) that the `claude` CLI connects to. Claude can then see your **current selection, open buffers and LSP diagnostics**, and it proposes edits as **native Neovim diffs**.

### Keymaps

| Key | Mode | Action |
|---|---|---|
| `<Leader>ac` | n | Toggle Claude terminal |
| `<Leader>af` | n | Focus Claude terminal |
| `<Leader>ar` | n | Resume a previous session (picker) |
| `<Leader>aC` | n | Continue the most recent session |
| `<Leader>am` | n | Select model (opus / sonnet / haiku / 1M-context variants) |
| `<Leader>ab` | n | Add current buffer to Claude's context |
| `<Leader>as` | v | Send visual selection to Claude |
| `<Leader>as` | n (neo-tree) | Add file under cursor to Claude's context |
| `<Leader>aa` | n | Accept proposed diff |
| `<Leader>ad` | n | Reject proposed diff |
| `<Leader>aS` | n | Show connection status |

Inside the Claude terminal, `<C-\><C-n>` returns to normal mode so you can scroll, yank or switch windows.

### Reviewing diffs

When Claude edits a file, a vertical diff opens (left: current, right: proposed).

- **Accept:** `<Leader>aa` or `:w` in the proposed buffer. You can edit the proposal before saving.
- **Reject:** `<Leader>ad`, or close the proposed buffer.
- Close every pending diff: `:ClaudeCodeCloseAllDiffs`.

### Using an external terminal

If you prefer running `claude` in tmux or another terminal, start it from the project directory and run `/ide` inside Claude to connect to this Neovim instance.

### Commands

`:ClaudeCode [args]` (args are passed to `claude`, e.g. `:ClaudeCode --model opus`), `:ClaudeCodeAdd <path> [start] [end]`, `:ClaudeCodeSend`, `:ClaudeCodeStatus`, `:ClaudeCodeStart`, `:ClaudeCodeStop`.

---

## 3. Avante (`<Leader>A`)

### Provider selection

Chosen automatically at startup in `lua/plugins/avante.lua`:

| Condition | Provider | Billing |
|---|---|---|
| `ANTHROPIC_API_KEY` is set | `claude` (Anthropic API, `claude-sonnet-5-5`) | Pay-per-token on your Console account |
| otherwise | `claude-code` (ACP agent using your `claude` CLI login) | Your Claude subscription / CLI auth |

Switch at runtime with `<Leader>A?` or `:AvanteSwitchProvider claude`.

### Global keymaps

| Key | Mode | Action |
|---|---|---|
| `<Leader>A<CR>` | n, v | Ask (opens sidebar; uses selection in visual mode) |
| `<Leader>Ae` | v | Edit selected code in place |
| `<Leader>An` | n | New chat |
| `<Leader>At` | n | Toggle sidebar |
| `<Leader>Af` | n | Focus sidebar |
| `<Leader>Ar` | n | Refresh |
| `<Leader>AS` | n | Stop generation |
| `<Leader>Ah` | n | Chat history |
| `<Leader>A?` | n | Select model / provider |
| `<Leader>Am` | n | Select ACP mode (claude-code provider) |
| `<Leader>AM` | n | Select ACP model (claude-code provider) |
| `<Leader>A.` | n | Add current file to context (available once the sidebar has been opened) |
| `<Leader>AB` | n | Add all open buffers to context |
| `<Leader>AZ` | n | Zen mode |
| `<Leader>AR` | n | Show repo map |
| `oa` | neo-tree | Add file under cursor to Avante |

### Inside the sidebar

| Key | Action |
|---|---|
| `<CR>` (normal) / `<C-s>` (insert) | Submit prompt |
| `@` | Add a file to context · type `@` in the input for mentions |
| `/` | Slash commands in the input (`/clear`, `/new`, …) |
| `d` | Remove file from context |
| `a` / `A` | Apply code block under cursor / apply all |
| `r` / `e` | Retry / edit your last request |
| `]p` / `[p` | Next / previous prompt |
| `<Tab>` / `<S-Tab>` | Cycle sidebar windows |
| `q` | Close sidebar |

### Resolving Avante diffs

| Key | Action |
|---|---|
| `co` | Keep ours (current code) |
| `ct` | Take theirs (AI suggestion) |
| `cb` | Keep both |
| `ca` | Take all AI suggestions |
| `cc` | Take the side under the cursor |
| `]c` / `[c` | Next / previous conflict |

Tool calls (file writes, shell commands) ask for confirmation with inline buttons in the sidebar.

---

## 4. Safety defaults (and why)

| Setting | Value | Reason |
|---|---|---|
| API keys | read from env only | No secrets in a git-tracked config |
| `ACP_PERMISSION_MODE` | `default` | Avante's default is `bypassPermissions`; the agent must ask before edits/commands |
| `auto_approve_tool_permissions` | `false` | Every tool call is confirmed |
| `auto_apply_diff_after_generation` | `false` | Review diffs before applying |
| `allow_access_to_git_ignored_files` | `false` | Keeps `.env` and other ignored files out of context |
| `auto_suggestions` | `false` | Inline ghost text stays with copilot.vim; Avante suggestions burn tokens |
| claudecode server | localhost + auth token | Plugin default; no remote access |

Claude Code's own permissions live in `~/.claude/settings.json` (global) or `.claude/settings.json` (per project). Use `/permissions` inside Claude to manage them rather than running with `--dangerously-skip-permissions`.

---

## 5. Project instructions

Give both tools project context with files at the repo root:

| File | Read by | Purpose |
|---|---|---|
| `CLAUDE.md` | Claude Code (and the `claude-code` ACP provider) | Build/test commands, conventions, architecture notes. Generate a starter with `/init` inside Claude |
| `avante.md` | Avante | Role, coding standards and project goals for the sidebar |

Keep them short and factual, and commit them so your team shares them.

---

## 6. Suggested workflow

1. **Understand code:** select it → `<Leader>A<CR>` → "explain this".
2. **Small edit:** select → `<Leader>Ae` → describe the change → resolve with `ct`/`co`.
3. **Feature or refactor:** `<Leader>ac` → describe the task → review each diff with `<Leader>aa`/`<Leader>ad`.
4. **Point Claude at the right code:** `<Leader>as` on a selection, or `<Leader>ab` for the whole buffer, before asking.
5. **Pick up where you left off:** `<Leader>aC` (continue) or `<Leader>ar` (choose a session).

---

## 7. Troubleshooting

| Symptom | Fix |
|---|---|
| Avante error loading `avante_templates` / tokenizers | Rebuild the prebuilt libs: `:Lazy build avante.nvim` (runs `bash ./build.sh`) |
| Build tries to compile Rust and fails on the rustc version | Make sure `build` in `lua/plugins/avante.lua` is `bash ./build.sh`, not `make` |
| `module 'mega.cmdparse' not found` when opening a file | Avante needs `ColinKennedy/mega.cmdparse` and `mega.logging` as plugins (declared in `lua/plugins/avante.lua`); run `:Lazy install` |
| Avante `claude-code` provider hangs on first use | `npx` is downloading the adapter; wait, or install it globally (see Prerequisites) |
| Avante says unauthenticated | Run `claude` once in a terminal and `/login`, or export `ANTHROPIC_API_KEY` |
| Claude doesn't see your selection | `<Leader>aS` to check the connection; run `/ide` inside Claude |
| Diff doesn't open | `:ClaudeCodeStatus`; restart with `:ClaudeCodeStop` then `:ClaudeCodeStart` |
| General health check | `:checkhealth avante`, `:Lazy` logs, `:messages` |
