-- File: ~/.config/nvim/lua/plugins/neo-tree.lua
-- AstroVim Neo-tree natural sorting configuration

return {
  -- "nvim-neo-tree/neo-tree.nvim",
  -- opts = function(_, opts)
  --   -- Ensure filesystem table exists
  --   if not opts.filesystem then
  --     opts.filesystem = {}
  --   end
  --   -- Add natural sorting
  --   opts.filesystem.sort_function = function(a, b)
  --     -- Convert numbers in filenames to zero-padded strings for proper sorting
  --     local function natural_sort_key(str)
  --       return str:gsub("(%d+)", function(num)
  --         return string.format("%010d", tonumber(num))
  --       end)
  --     end
  --     local a_key = natural_sort_key(a.name:lower())
  --     local b_key = natural_sort_key(b.name:lower())
  --     return a_key < b_key
  --   end
  --   return opts
  -- end,
}
