return {
  "jay-babu/mason-null-ls.nvim",
  optional = true,
  opts = function(_, opts)
    opts.ensure_installed = require("astrocore").list_insert_unique(
      opts.ensure_installed,
      { "gomodifytags", "iferr", "impl", "gotests", "goimports" }
    )
  end,
}
