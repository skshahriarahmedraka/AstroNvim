-- In your plugins configuration file
return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Telescope",
    opts = function()
      local opts = require "astronvim.plugins.configs.telescope"()
      opts.defaults.vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--hidden",
        "-g",
        "!.git",
      }
      return opts
    end,
    config = function(plugin, opts)
      require "astronvim.plugins.configs.telescope" (plugin, opts)
    end,
  },
}
