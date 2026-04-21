-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- Customize Treesitter

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "lua",
      "vim",
      "go",
      "gomod",
      "gowork",
      "gosum",
      "html",
      "css",
      "scss",
      "javascript",
      "typescript",
      "tsx",
      "vue",
      "svelte",
      "json",
      "yaml",
      "zig",
      "markdown",
      "markdown_inline",
      -- "rust",
      -- "ron",
    },
    highlight = {
      enable = true,
      disable = function(lang, buf)
        -- Disable highlight for markdown files to prevent treesitter errors
        if vim.bo[buf].filetype == "markdown" then
          return true
        end
      end,
    },
  },
}
