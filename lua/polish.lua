-- if true then return end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- This will run last in the setup process.
-- This is just pure lua so anything that doesn't
-- Set update time to 500ms
vim.opt.updatetime = 500

-- Create auto-save on cursor hold
vim.api.nvim_create_autocmd({
  -- "CursorHold",
  -- "CursorHoldI",
  "InsertLeave",
  "TextChanged",
  -- "CursorHold",
  -- "CursorHoldI",
  "TextChanged",
  "TextChangedI",
}, {
  pattern = "*",
  callback = function()
    -- Only save if:
    -- 1. Buffer is modifiable
    -- 2. Not read-only
    -- 3. File exists on disk
    -- 4. Has unsaved changes
    if
      vim.bo.modifiable
      and not vim.bo.readonly
      and vim.fn.filereadable(vim.fn.expand "%") == 1
      and vim.bo.modified
    then
      vim.cmd "silent write"
      -- Optional: Show save notification
      -- vim.notify("Auto-saved: " .. vim.fn.expand "%", vim.log.levels.INFO, { title = "AutoSave" })
    end
  end,
})
