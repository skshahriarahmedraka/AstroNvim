-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- Customize Treesitter

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = { "OXY2DEV/markview.nvim" },
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
      -- "rust",
      -- "ron",
    },
  },
}
