return {
  "romgrk/barbar.nvim",
  dependencies = {
    "lewis6991/gitsigns.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  event = "VeryLazy", -- Load after other plugins
  init = function() 
    vim.g.barbar_auto_setup = false 
  end,
  config = function()
    -- Wait a bit to ensure session is restored first
    vim.defer_fn(function()
      require("barbar").setup({
        animation = false, -- Disable animation for better session compatibility
        auto_hide = false,
        tabpages = true,
        clickable = true,
        icons = {
          buffer_index = false,
          buffer_number = false,
          button = '',
          diagnostics = {
            [vim.diagnostic.severity.ERROR] = {enabled = true, icon = ''},
            [vim.diagnostic.severity.WARN] = {enabled = false},
            [vim.diagnostic.severity.INFO] = {enabled = false},
            [vim.diagnostic.severity.HINT] = {enabled = true},
          },
          gitsigns = {
            added = {enabled = true, icon = '+'},
            changed = {enabled = true, icon = '~'},
            deleted = {enabled = true, icon = '-'},
          },
          filetype = {
            custom_colors = false,
            enabled = true,
          },
          separator = {left = '▎', right = ''},
          modified = {button = '●'},
          pinned = {button = '', filename = true},
          preset = 'default',
          alternate = {filetype = {enabled = false}},
          current = {buffer_index = true},
          inactive = {button = '×'},
          visible = {modified = {buffer_number = false}},
        },
        insert_at_end = false,
        insert_at_start = false,
        maximum_padding = 1,
        minimum_padding = 1,
        maximum_length = 30,
        minimum_length = 0,
        semantic_letters = true,
        letters = 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP',
        no_name_title = nil,
      })
      
      -- Force refresh after setup
      vim.schedule(function()
        pcall(function()
          require("barbar.api").refresh()
          vim.cmd("redrawtabline")
        end)
      end)
    end, 300) -- Wait 300ms after VeryLazy
    
    -- Set up keymaps
    local map = vim.api.nvim_set_keymap
    local opts = { noremap = true, silent = true }
    
    map('n', '<A-,>', '<Cmd>BufferPrevious<CR>', opts)
    map('n', '<A-.>', '<Cmd>BufferNext<CR>', opts)
    map('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', opts)
    map('n', '<A->>', '<Cmd>BufferMoveNext<CR>', opts)
    map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', opts)
    map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', opts)
    map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', opts)
    map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', opts)
    map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', opts)
    map('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', opts)
    map('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', opts)
    map('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', opts)
    map('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', opts)
    map('n', '<A-0>', '<Cmd>BufferLast<CR>', opts)
    map('n', '<A-p>', '<Cmd>BufferPin<CR>', opts)
    map('n', '<A-c>', '<Cmd>BufferClose<CR>', opts)
    map('n', '<A-x>', '<Cmd>BufferClose<CR>', opts)
    map('n', '<C-p>', '<Cmd>BufferPick<CR>', opts)
    map('n', '<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>', opts)
    map('n', '<Space>bd', '<Cmd>BufferOrderByDirectory<CR>', opts)
    map('n', '<Space>bl', '<Cmd>BufferOrderByLanguage<CR>', opts)
    map('n', '<Space>bw', '<Cmd>BufferOrderByWindowNumber<CR>', opts)
  end,
  version = "^1.0.0",
}
