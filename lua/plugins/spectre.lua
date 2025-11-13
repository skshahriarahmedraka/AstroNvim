return {
  "nvim-pack/nvim-spectre",
  -- lazy = false, -- If you want to lazy load on event
  config = function()
    require("spectre").setup()
  end,
  keys = {
    {
      "<leader>S",
      group = "Spectre",
    },
    {
      "<leader>St",
      "<cmd>SpectreToggle<cr>",
      desc = "Toggle Spectre",
    },
    {
      "<leader>Sw",
      '<cmd>lua require("spectre").open_visual({select_word=true})<cr>',
      desc = "Search current word",
    },
    {
      "<leader>Sf",
      '<cmd>lua require("spectre").open_file_search()<cr>',
      desc = "Search on current file",
    },
    {
      mode = "v",
      "<leader>Sv",
      '<esc><cmd>lua require("spectre").open_visual()<cr>',
      desc = "Search in visual selection",
    },
  },
}
