return {
  "neovim/nvim-lspconfig",
  dependencies = {
    {
      "williamboman/mason-lspconfig.nvim",
      opts = {
        ensure_installed = {
          "tsserver",
          "html",
          "cssls",
          "emmet_ls",
          "gopls",
        },
      },
    },
  },
  opts = {
    servers = {
      bacon_ls = {
        enabled = vim.lsp.diagnostics == "bacon-ls",
      },
      rust_analyzer = { enabled = false },
    },
  },
}
