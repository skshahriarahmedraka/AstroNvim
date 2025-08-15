-- In your plugins configuration file
return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Telescope",
    opts = function()
      return require "astronvim.plugins.configs.telescope"
    end,
    config = function(plugin, opts)
      require "astronvim.plugins.configs.telescope" (plugin, opts)
    end,
  }
}
