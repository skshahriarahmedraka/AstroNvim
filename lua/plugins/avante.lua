-- Avante: Cursor-style AI sidebar, backed by Claude.
-- Base spec (keymaps under <Leader>A, blink/markview/neo-tree/snacks integration)
-- comes from `astrocommunity.ai.avante-nvim` in lua/community.lua; this only overrides it.
--
-- Provider selection:
--   * ANTHROPIC_API_KEY set  -> "claude"      (direct Anthropic API, pay-per-token)
--   * otherwise              -> "claude-code" (ACP agent that reuses your `claude` CLI login)
-- Switch at runtime with <Leader>A? (select model) or :AvanteSwitchProvider.
-- Never hardcode keys here; export them from your shell or a secrets manager.

local has_api_key = (os.getenv "ANTHROPIC_API_KEY" or "") ~= ""

---@type LazySpec
return {
  "yetone/avante.nvim",
  version = false, -- avante recommends tracking main; lazy-lock.json pins the exact commit
  -- Download prebuilt native libs; the community default `make` now compiles from source
  -- and requires a bleeding-edge rustc.
  build = vim.fn.has "win32" == 1 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
    or "bash ./build.sh",
  ---@module 'avante'
  ---@type avante.Config
  opts = {
    provider = has_api_key and "claude" or "claude-code",

    providers = {
      claude = {
        endpoint = "https://api.anthropic.com",
        auth_type = "api",
        model = "claude-sonnet-5-5",
        timeout = 60000,
        extra_request_body = {
          temperature = 0,
          max_tokens = 16384,
        },
      },
    },

    acp_providers = {
      ["claude-code"] = {
        -- npx keeps this working without a global install; `npm i -g @agentclientprotocol/claude-agent-acp`
        -- for faster startup and it will be picked up automatically.
        command = vim.fn.executable "claude-agent-acp" == 1 and "claude-agent-acp" or "npx",
        args = vim.fn.executable "claude-agent-acp" == 1 and {} or { "-y", "@agentclientprotocol/claude-agent-acp" },
        env = {
          NODE_NO_WARNINGS = "1",
          ANTHROPIC_API_KEY = os.getenv "ANTHROPIC_API_KEY",
          ANTHROPIC_BASE_URL = os.getenv "ANTHROPIC_BASE_URL",
          ACP_PATH_TO_CLAUDE_CODE_EXECUTABLE = vim.fn.exepath "claude",
          -- Avante's default is "bypassPermissions"; ask before edits/commands instead.
          ACP_PERMISSION_MODE = "default",
        },
      },
    },

    behaviour = {
      auto_suggestions = false, -- inline ghost text stays with copilot.vim; Avante suggestions burn tokens fast
      auto_set_keymaps = true,
      auto_apply_diff_after_generation = false, -- review diffs before applying
      auto_approve_tool_permissions = false, -- confirm every tool call (shell, file writes)
      confirmation_ui_style = "inline_buttons",
      allow_access_to_git_ignored_files = false, -- keep .env and other ignored secrets out of context
      support_paste_from_clipboard = false,
      minimize_diff = true,
      enable_token_counting = true,
      auto_add_current_file = true,
    },

    -- Project-level instructions, read from the repo root (like CLAUDE.md for Claude Code).
    instructions_file = "avante.md",

    -- The community module moves most keys to <Leader>A but misses these two, whose defaults
    -- (<leader>am / <leader>aM) collide with claudecode.nvim's <Leader>a group.
    mappings = {
      select_acp_mode = "<Leader>Am",
      select_acp_model = "<Leader>AM",
    },

    input = { provider = "snacks" },
    selector = { provider = "snacks" },

    windows = {
      position = "right",
      width = 35,
      wrap = true,
      sidebar_header = { rounded = true },
      ask = { floating = false, start_insert = true },
    },
  },
}
