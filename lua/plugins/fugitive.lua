return {
  "tpope/vim-fugitive",
  cmd = { "Git", "Gdiffsplit", "Gread", "Gwrite", "Ggrep", "GMove", "GDelete", "GBrowse" },
  keys = {
    { "<leader>gs", "<cmd>Git<cr>", desc = "Git status" },
    { "<leader>ga", "<cmd>Git add %<cr>", desc = "Git add current file" },
    { "<leader>gc", "<cmd>Git commit<cr>", desc = "Git commit" },
    { "<leader>gp", "<cmd>Git push<cr>", desc = "Git push" },
    { "<leader>gb", "<cmd>Git blame<cr>", desc = "Git blame" },
    { "<leader>gd", "<cmd>Gdiffsplit<cr>", desc = "Git diff split" },
  },
  config = function()
    -- Auto-open fugitive in vertical split
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "fugitive",
      callback = function()
        local buf = vim.api.nvim_get_current_buf()
        local opts = { buffer = buf, remap = false }
        -- Quick commit with message
        vim.keymap.set("n", "<leader>cc", "<cmd>Git commit -m ''<Left>", opts)
        -- Amend commit
        vim.keymap.set("n", "<leader>ca", "<cmd>Git commit --amend<cr>", opts)
      end,
    })
  end,
}
