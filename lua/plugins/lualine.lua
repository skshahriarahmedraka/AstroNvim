return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = {
    options = {
      theme = "auto", -- or "catppuccin" if using catppuccin
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      disabled_filetypes = {
        statusline = { "dashboard", "alpha", "starter" },
      },
    },
    sections = {
      lualine_a = {
        {
          "mode",
          fmt = function(str)
            return str:sub(1, 1) -- Show only first character
          end,
        },
      },
      lualine_b = {
        {
          "branch",
          icon = "",
        },
        {
          "diff",
          symbols = {
            added = " ",
            modified = " ",
            removed = " ",
          },
        },
      },
      lualine_c = {
        {
          "filename",
          file_status = true,
          newfile_status = false,
          path = 1, -- Relative path
          symbols = {
            modified = "●",
            readonly = "",
            unnamed = "",
            newfile = "",
          },
        },
        {
          "diagnostics",
          sources = { "nvim_diagnostic" },
          symbols = {
            error = " ",
            warn = " ",
            info = " ",
            hint = "󰌵 ",
          },
        },
      },
      lualine_x = {
        {
          function()
            local clients = {}
            for _, client in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
              if client.name ~= "null-ls" and client.name ~= "copilot" then
                table.insert(clients, client.name)
              end
            end
            if #clients > 0 then
              return " " .. table.concat(clients, ", ")
            end
            return ""
          end,
          color = { fg = "#a6e3a1" },
        },
        {
          function()
            local buf = vim.api.nvim_get_current_buf()
            local ts = vim.treesitter.highlighter.active[buf]
            return ts and " TS" or ""
          end,
          color = { fg = "#cba6f7" },
        },
        "encoding",
        "fileformat",
        "filetype",
      },
      lualine_y = {
        "progress",
      },
      lualine_z = {
        "location",
      },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { "filename" },
      lualine_x = { "location" },
      lualine_y = {},
      lualine_z = {},
    },
    extensions = { "neo-tree", "lazy", "toggleterm", "mason" },
  },
}
