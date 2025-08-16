-- Git shortcuts using vim-fugitive
local map = vim.keymap.set

-- Basic Git operations
map("n", "<leader>gs", "<cmd>Git<cr>", { desc = "Git status" })
map("n", "<leader>ga", "<cmd>Git add %<cr>", { desc = "Git add current file" })
map("n", "<leader>gA", "<cmd>Git add .<cr>", { desc = "Git add all" })
map("n", "<leader>gc", "<cmd>Git commit<cr>", { desc = "Git commit" })
map("n", "<leader>gp", "<cmd>Git push<cr>", { desc = "Git push" })
map("n", "<leader>gP", "<cmd>Git pull<cr>", { desc = "Git pull" })

-- Git blame and log
map("n", "<leader>gB", "<cmd>Git blame<cr>", { desc = "Git blame" })
map("n", "<leader>gl", "<cmd>Git log --oneline<cr>", { desc = "Git log" })
map("n", "<leader>gL", "<cmd>Git log<cr>", { desc = "Git log detailed" })

-- Diff operations
map("n", "<leader>gd", "<cmd>Gdiffsplit<cr>", { desc = "Git diff split" })
map("n", "<leader>gD", "<cmd>Gdiffsplit HEAD<cr>", { desc = "Git diff HEAD" })

-- Branch operations
map("n", "<leader>gco", "<cmd>Git checkout ", { desc = "Git checkout" })
map("n", "<leader>gcb", "<cmd>Git checkout -b ", { desc = "Git checkout new branch" })
map("n", "<leader>gm", "<cmd>Git merge ", { desc = "Git merge" })

-- Stash operations
map("n", "<leader>gss", "<cmd>Git stash<cr>", { desc = "Git stash" })
map("n", "<leader>gsp", "<cmd>Git stash pop<cr>", { desc = "Git stash pop" })
map("n", "<leader>gsl", "<cmd>Git stash list<cr>", { desc = "Git stash list" })
