-- ~/.config/astrovim/lua/plugins/persistence.lua
return {
  {
    "olimorris/persisted.nvim",
    event = "BufReadPre", -- Load early for root detection
    opts = {
      -- Auto-save and auto-restore without any key presses
      autosave = true,
      autorestore = true,

      -- Optional but recommended:
      branch = true,           -- Save sessions per Git branch
      silent = true,           -- No messages when saving/restoring
      cwd = true,              -- Store sessions per working directory
      root_dirs = {           -- Project root detection
        ".git",
        "package.json",
        "Cargo.toml",
        "pyproject.toml",
        "go.mod",
        "Makefile",
        "README.md",
      },
      should_save = function()
        -- get all listed buffers
        local bufs = vim.fn.getbufinfo({ buflisted = 1 })
        -- count how many are NOT neo-tree
        local non_neo_tree_count = 0
        for _, buf in ipairs(bufs) do
          if vim.bo[buf.bufnr].filetype ~= "neo-tree" then
            non_neo_tree_count = non_neo_tree_count + 1
          end
        end
        -- if there are no other buffers, don't save
        return non_neo_tree_count > 0
      end,
    },
  },
}