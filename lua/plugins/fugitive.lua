return {
  "tpope/vim-fugitive",
  cmd = { "Git", "G", "Gdiffsplit", "Gvdiffsplit" },
  keys = {
    { "<leader>gg", "<cmd>Git<CR>", desc = "Fugitive Git Status" },
    { "<leader>gl", "<cmd>Git log<CR>", desc = "Fugitive Git Log" },
    { "<leader>gp", "<cmd>Git push<CR>", desc = "Fugitive Git Push" },
    { "<leader>gP", "<cmd>Git pull<CR>", desc = "Fugitive Git Pull" },
    { "<leader>gc", "<cmd>Git commit<CR>", desc = "Fugitive Git Commit" },
  },
}
