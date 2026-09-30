# Config Improvement Plan

Audit of this AstroNvim config, focused on making it work well with AI agents (Claude Code, Avante) and feel closer to Cursor, Conductor and VS Code.

**Baseline (2026-09-30):** ~350 ms startup, 86 plugins. A lean AstroNvim config starts in roughly 80–120 ms.

See [AI_GUIDE.md](AI_GUIDE.md) for how the current Avante and Claude Code setup works.

---

## 1. Fix first: these break AI workflows

- [ ] **1. Auto-save on every keystroke** (`lua/polish.lua:37`)
  `TextChanged`/`TextChangedI` run `silent write`. Agents edit files on disk, and the editor keeps writing its own copy back, which can overwrite their changes. It also reruns format-on-save on every keypress.
  **Fix:** save on `FocusLost`, `BufLeave` and `InsertLeave` only, or use a debounced plugin (`astrocommunity.editing-support.auto-save-nvim`).

- [ ] **2. No reload of files changed by an agent** (no `autoread` or `checktime` anywhere)
  Open buffers go stale while an agent edits in the background, and you get "file changed" conflicts.
  **Fix:** set `autoread`, and run `checktime` on `FocusGained`, `BufEnter`, `CursorHold` and `TermLeave`.

- [ ] **3. Three session managers** (`lua/plugins/auto-session.lua`, `lua/plugins/persistence.lua`, AstroNvim's built-in resession; `lua/user/session.lua` is empty)
  They compete to restore layouts and bring back dead AI terminal splits and sidebars.
  **Fix:** keep one. persisted.nvim's `branch = true` fits the one-agent-per-worktree workflow.

- [ ] **4. Three Copilot or chat layers** (`copilot.vim`, `copilot.lua` pulled in by CopilotChat, CopilotChat)
  CopilotChat does the same job as Avante. `vim.g.ai_accept` is never set, so the AI part of `<Tab>` in `lua/plugins/cmp_ai.lua` does nothing.
  **Fix:** keep one completion engine (see section 2) and one chat (Avante).

- [ ] **5. Three TypeScript language servers** (vtsls from `pack.typescript`, `typescript-tools`, and `"tsserver"` in `lua/plugins/nvim-lspconfig.lua:8`)
  `tsserver` was renamed `ts_ls`. You get duplicate diagnostics and more memory use, and Claude Code reads those diagnostics as context.
  **Fix:** keep vtsls from the pack; remove `typescript-tool.lua` and the `tsserver` entry.

- [ ] **6. Deprecated LSP APIs and diagnostics set in four places** (`lua/plugins/astrolsp.lua:157-180, 378`, `lua/polish.lua:45`)
  `vim.lsp.with` prints a warning on every startup; `diagnostic.goto_next` and `diagnostic.disable` are deprecated. `update_in_insert = true` flickers while an agent streams edits.
  **Fix:** configure diagnostics once in astrolsp, drop the hover and signature handlers (`vim.o.winborder` is already set), use `vim.diagnostic.jump`, and set `update_in_insert = false`.

- [ ] **7. Keymap conflicts**
  - `<leader>gs` and `<leader>gp` are bound by both fugitive (`lua/config/keymaps.lua`) and gitsigns (`lua/plugins/gitsigns.lua`).
  - `" <leader>gm"` has a stray leading space (`lua/config/keymaps.lua:24`).
  - `<leader>q` replaces AstroNvim's "Quit Window" with a session save (`lua/plugins/auto-session.lua`).
  - hover.nvim takes `<C-n>`/`<C-p>` (`lua/plugins/mouse_hover.lua`).

- [ ] **8. Three right-hand panels** (neo-tree, Avante and the Claude terminal)
  **Fix:** move neo-tree to the left (`lua/plugins/neo-tree.lua`) for the VS Code and Cursor layout: files on the left, AI on the right.

- [ ] **9. Two statuslines plus a second tabline** (heirline from AstroNvim, `lualine.lua`, `barbar.lua`)
  A large part of the startup time, and the reason for a workaround in `polish.lua`.
  **Fix:** keep heirline, or disable it properly if you prefer lualine and barbar.

- [ ] **10. Leftover files**
  - `lua/plugins/astrocore.lua` is switched off by `if true then return {} end`, so none of its options or mappings apply.
  - `lua/plugins/auto-save.lua` and `lua/plugins/snacks.lua` are empty.
  - `lua/plugins/render_markdown.lua` actually configures markview.
  **Fix:** delete or rename them so the config says what it does.

---

## 2. Cursor-like features

| Cursor feature | How to get it here | Done |
|---|---|---|
| Tab / next-edit prediction | `astrocommunity.ai.sidekick-nvim` for Copilot next edit suggestions (the closest match to Cursor Tab), plus `copilot.lua` and `blink-copilot` in place of `copilot.vim` | [ ] |
| Cmd-K inline edit | Avante `<Leader>Ae` already works; optionally give it a single-chord key | [ ] |
| Chat that knows the codebase | Avante, plus `astrocommunity.editing-support.mcphub-nvim` so Avante and Claude Code share MCP servers (docs, GitHub, databases) | [ ] |
| Rules files | `CLAUDE.md` and `avante.md` in each repo; `.claude/settings.json` for permissions | [ ] |
| Review and checkpoint agent changes | `:DiffviewOpen` against `HEAD`; gitsigns stage/reset hunk as accept/reject; commit before each agent task as a checkpoint | [ ] |
| Inline errors | `astrocommunity.diagnostics.tiny-inline-diagnostic-nvim` | [ ] |

---

## 3. Conductor-like features (parallel agents)

Conductor's core idea: one git worktree per agent, a list of running agents, and a review queue.

- [ ] **Worktrees:** a picker (`git-worktree.nvim` or a small snacks picker) that creates `../repo-<task>` on a new branch, opens it in a new Neovim tab with `:tcd`, and starts a Claude terminal there. Each tab is an isolated agent.
- [ ] **Many agent sessions:** sidekick.nvim's CLI picker to manage several Claude Code sessions, optionally through tmux or zellij so they survive closing Neovim.
- [ ] **"Agent finished" alerts:** Claude Code `Stop` and `Notification` hooks in `~/.claude/settings.json` that run `notify-send`.
- [ ] **Review queue:** `astrocommunity.git.octo-nvim` to review each agent's PR (opened with `gh`), and `diffview` for each branch compared with `master`.

---

## 4. VS Code-like features

- [ ] **Problems panel:** `astrocommunity.diagnostics.trouble-nvim`
- [ ] **Command palette:** snacks picker `commands()` on `<C-S-p>` (or `<Leader>fC`)
- [ ] **Multi-cursor:** `astrocommunity.editing-support.multicursors-nvim` or `vim-visual-multi`
- [ ] **Test explorer:** `neotest` with the Go and Jest adapters (dap is already set up for debugging)
- [ ] **Sticky scroll:** `astrocommunity.editing-support.nvim-treesitter-context`
- [ ] **Git UI:** snacks `lazygit()` as a Source Control-style view alongside fugitive and diffview

---

## Suggested order

1. **Section 1, items 1–2** (save and reload behaviour). These are the ones that lose or overwrite work while agents are editing.
2. **Section 1, items 3–10** (overlapping plugins and cleanup). Target: around 150 ms startup and no duplicate diagnostics.
3. **Sidekick with Copilot next-edit suggestions, and neo-tree moved left.** These do the most to make it feel like Cursor.
4. **Worktree workflow and notification hooks.** Conductor-style parallel agents.
5. **VS Code extras** as needed.

Measure startup after each step:

```sh
nvim --startuptime /tmp/nvim-start.log +qa && tail -1 /tmp/nvim-start.log
```
