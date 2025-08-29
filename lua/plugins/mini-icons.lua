return {
  {
    "echasnovski/mini.nvim",
    branch = "stable",
    opts = {
      icons = {
        -- Configure the default setting as a table, not boolean
        default = {
          enable = true
        },
        -- Custom icon mappings
        icons = {
          kind = {
            Text = "󰉿",
            Method = "󰆧",
            Function = "󰊕",
            Constructor = "",
            Field = "󰜢",
            Variable = "󰂡",
            Class = "󰠱",
            Interface = "",
            Module = "",
            Property = "󰜢",
            Unit = "󰑭",
            Value = "󰎠",
            Enum = "",
            Keyword = "󰌋",
            Snippet = "",
            Color = "󰏘",
            File = "󰈙",
            Reference = " Refer",
            Folder = "󰉋",
            EnumMember = "",
            Constant = "󰏿",
            Struct = "󰙅",
            Event = "",
            Operator = "󰆕",
            TypeParameter = "",
          },
        },
      }
    },
    config = function(_, opts)
      -- Setup mini.icons with proper configuration
      require("mini.icons").setup(opts.icons)
      
      -- If you're using nvim-tree.lua with AstroVim
      vim.g.nvim_tree_icons = {
        default = "",
        symlink = "",
        git = {
          unstaged = "󰄱",
          staged = "",
          unmerged = "",
          renamed = "",
          untracked = "ﲉ",
          ignored = "◌",
        },
        folder = {
          arrow_open = "",
          arrow_closed = "",
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
          symlink_open = "",
        },
      }
    end,
  },
}
