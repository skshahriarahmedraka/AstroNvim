return {
  "NvChad/nvim-colorizer.lua",
  event = "BufReadPre",
  opts = {
    filetypes = {
      css = { css = true },
      scss = { css = true },
      html = { names = true, css = true },
      javascript = { names = true, css = true },
      typescript = { names = true, css = true },
      svelte = { names = true },
      vue = { names = true },
    },
  },
}
