-- Claude Code IDE integration (same WebSocket/MCP protocol as the official VS Code extension).
-- Claude sees your current selection, open files and diagnostics, and proposes edits as native
-- Neovim diffs you accept (<Leader>aa / :w) or reject (<Leader>ad).
-- Run `/ide` inside Claude if you start `claude` from a separate terminal instead.

---@type LazySpec
return {
  "coder/claudecode.nvim",
  dependencies = { "folke/snacks.nvim" },
  cmd = {
    "ClaudeCode",
    "ClaudeCodeFocus",
    "ClaudeCodeSelectModel",
    "ClaudeCodeAdd",
    "ClaudeCodeSend",
    "ClaudeCodeTreeAdd",
    "ClaudeCodeStatus",
    "ClaudeCodeStart",
    "ClaudeCodeStop",
    "ClaudeCodeOpen",
    "ClaudeCodeClose",
    "ClaudeCodeDiffAccept",
    "ClaudeCodeDiffDeny",
    "ClaudeCodeCloseAllDiffs",
  },
  opts = {
    -- The WebSocket server binds to 127.0.0.1 only and requires an auth token (plugin defaults).
    auto_start = true,
    log_level = "warn",
    track_selection = true,
    focus_after_send = true,
    terminal = {
      provider = "snacks",
      split_side = "right",
      split_width_percentage = 0.35,
      auto_close = true,
    },
    diff_opts = {
      layout = "vertical",
      open_in_new_tab = false,
      keep_terminal_focus = false,
    },
  },
  keys = {
    { "<Leader>a", nil, desc = "󰚩 Claude Code" },
    { "<Leader>ac", "<Cmd>ClaudeCode<CR>", desc = "Toggle Claude" },
    { "<Leader>af", "<Cmd>ClaudeCodeFocus<CR>", desc = "Focus Claude" },
    { "<Leader>ar", "<Cmd>ClaudeCode --resume<CR>", desc = "Resume Claude session" },
    { "<Leader>aC", "<Cmd>ClaudeCode --continue<CR>", desc = "Continue last Claude session" },
    { "<Leader>am", "<Cmd>ClaudeCodeSelectModel<CR>", desc = "Select Claude model" },
    { "<Leader>ab", "<Cmd>ClaudeCodeAdd %<CR>", desc = "Add current buffer to Claude" },
    { "<Leader>as", "<Cmd>ClaudeCodeSend<CR>", mode = "v", desc = "Send selection to Claude" },
    {
      "<Leader>as",
      "<Cmd>ClaudeCodeTreeAdd<CR>",
      desc = "Add file to Claude",
      ft = { "neo-tree", "snacks_picker_list" },
    },
    { "<Leader>aa", "<Cmd>ClaudeCodeDiffAccept<CR>", desc = "Accept Claude diff" },
    { "<Leader>ad", "<Cmd>ClaudeCodeDiffDeny<CR>", desc = "Reject Claude diff" },
    { "<Leader>aS", "<Cmd>ClaudeCodeStatus<CR>", desc = "Claude connection status" },
  },
}
