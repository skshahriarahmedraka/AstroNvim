local function augroup(name)
  return vim.api.nvim_create_augroup("user_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd("User", {
  pattern = "FugitiveChanged",
  group = augroup("fugitive_changed"),
  callback = function()
    vim.cmd("TSBufEnable highlight")
  end,
})

vim.api.nvim_create_autocmd("FileChangedShellPost", {
  group = augroup("auto_treesitter_refresh"),
  pattern = "*",
  callback = function()
    print("FileChangedShellPost triggered")
    vim.cmd("TSBufEnable highlight")
  end,
})
