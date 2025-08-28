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
}
