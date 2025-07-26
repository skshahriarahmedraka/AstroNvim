-- ~/.config/nvim/lua/polish.lua

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
-- vim.api.nvim_create_autocmd({
--   "InsertLeave", -- Save when leaving insert mode
--   "TextChanged", -- Save when text changes in normal mode
-- }, {
--   pattern = "*",
--   callback = function()
--     if
--       vim.bo.modifiable
--       and not vim.bo.readonly
--       and vim.fn.filereadable(vim.fn.expand "%") == 1
--       and vim.bo.modified
--     then
--       vim.cmd "silent write"
--     end
--   end,
-- })

-- Enhanced diagnostic configuration to work globally and with autosave
-- This sets the *default* for all buffers unless overridden by buffer-local config (like in on_attach)
vim.diagnostic.config({
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
})

-- Ensure diagnostics refresh after autosave (if you keep autosave)
-- This is usually not strictly necessary if LSP pushes diagnostics correctly,
-- but can act as a backup.
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*",
  callback = function(args)
    vim.schedule(function()
      if vim.api.nvim_buf_is_valid(args.buf) then
        vim.diagnostic.show(nil, args.buf)
      end
    end)
  end,
})

-- You can add other polish configurations here if needed