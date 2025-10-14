-- ~/.config/nvim/lua/polish.lua

vim.o.winborder = "rounded"

-- Remove or comment out the line that prevents activation
-- if true then return end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- This will run last in the setup process.
-- This is just pure lua so anything that doesn't

-- Set global update time to a lower value for faster CursorHold events
-- This affects how quickly diagnostics appear after stopping typing
vim.opt.updatetime = 250 -- Try 250 or 100. 100 is very responsive, might be too frequent.

-- Optional: Simplified auto-save (adjust events as needed)
-- Be careful with events like TextChangedI as they trigger on every keystroke
-- which might cause excessive writes. InsertLeave + TextChanged is often better.
-- Consider if you *really* need autosave on every keystroke.
vim.api.nvim_create_autocmd({
  "InsertLeave",
  -- "TextChanged",
  -- "CursorHold",
  -- "CursorHoldI",
  "TextChanged",
  "TextChangedI",
}, {
  pattern = "*",
  callback = function()
    if
      vim.bo.modifiable
      and not vim.bo.readonly
      and vim.fn.filereadable(vim.fn.expand "%") == 1
      and vim.bo.modified
    then
      vim.cmd "silent write"
    end
  end,
})

-- Enhanced diagnostic configuration to work globally and with autosave
-- This sets the *default* for all buffers unless overridden by buffer-local config (like in on_attach)
vim.diagnostic.config {
  update_in_insert = true, -- Key part: Show diagnostics in insert mode globally by default
  virtual_text = {
    severity = { min = vim.diagnostic.severity.HINT },
    source = "if_many",
    prefix = "●",
    spacing = 2,
  },
  signs = true,
  underline = true,
  severity_sort = true,
  float = {
    border = "rounded",
    source = "always",
    focusable = false,
  },
}

-- Ensure diagnostics refresh after autosave (if you keep autosave)
-- This is usually not strictly necessary if LSP pushes diagnostics correctly,
-- but can act as a backup.
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*",
  callback = function(args)
    vim.schedule(function()
      if vim.api.nvim_buf_is_valid(args.buf) then vim.diagnostic.show(nil, args.buf) end
    end)
  end,
})

-- local session = require "user.session"
-- session.setup()
-- require("user.session").setup {
--   debug = true, -- Enable to troubleshoot
--   auto_save = true,
--   auto_restore = true,
--   delay_ms = 150, -- This is now ignored in favor of VimEnter
-- }

-- Patch for astroui statusline error
pcall(function()
  local status_config = require "astroui.status.config"
  if status_config then
    status_config.buf_name = function(self)
      if not self.bufnr or not vim.api.nvim_buf_is_valid(self.bufnr) then return "[No Name]" end
      local buf_name = vim.api.nvim_buf_get_name(self.bufnr)
      if buf_name == "" then return "[No Name]" end
      return vim.fn.fnamemodify(buf_name, ":t")
    end
  end
end)

-- Patch for hover.nvim error: 'replacement string' item contains newlines
pcall(function()
  local util = require("hover.util")
  if util and util.open_floating_preview then
    local original_open_floating_preview = util.open_floating_preview
    util.open_floating_preview = function(content, opts)
      if type(content) == "string" then
        content = vim.split(content, '\n')
      elseif type(content) == "table" then
        local new_content = {}
        for _, line in ipairs(content) do
          if type(line) == "string" then
            for _, sub_line in ipairs(vim.split(line, '\n')) do
              table.insert(new_content, sub_line)
            end
          else
            table.insert(new_content, line)
          end
        end
        content = new_content
      end
      return original_open_floating_preview(content, opts)
    end
  end
end)
