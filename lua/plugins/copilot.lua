
return {
  "github/copilot.vim",
  event = "VeryLazy",
  config = function()
    -- Copilot settings
    vim.g.copilot_no_tab_map = true
    vim.g.copilot_assume_mapped = true
    vim.g.copilot_tab_fallback = ""
    
    -- Custom keymaps
    local keymap = vim.keymap.set
    keymap("i", "<C-g>", 'copilot#Accept("\\<CR>")', { expr = true, replace_keycodes = false })
    keymap("i", "<C-j>", 'copilot#Next()', { expr = true, silent = true })
    keymap("i", "<C-k>", 'copilot#Previous()', { expr = true, silent = true })
    keymap("i", "<C-o>", 'copilot#Dismiss()', { expr = true, silent = true })
    keymap("i", "<C-s>", 'copilot#Suggest()', { expr = true, silent = true })
  end,
}
