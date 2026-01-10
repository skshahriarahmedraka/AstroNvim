-- File: ~/.config/nvim/lua/plugins/neo-tree.lua
-- Configure Neo-tree to open on the right side of the editor

---@type LazySpec
return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = function(_, opts)
    opts = opts or {}
    opts.window = opts.window or {}
    -- Move the file tree to the right
    opts.window.position = "right"
    return opts
  end,
}
