return {
  "rmagatti/auto-session",
  lazy = false, -- Load on startup to restore session
  dependencies = {
    "nvim-telescope/telescope.nvim", -- Optional: for session picker
  },
  opts = {
    -- Enable logging for debugging (set to vim.log.levels.ERROR in production)
    log_level = vim.log.levels.INFO,
    -- Auto save session on exit
    auto_save_enabled = true,
    -- Auto restore session on startup
    auto_restore_enabled = true,
    -- Auto create session when opening nvim in a directory
    auto_session_create_enabled = true,
    -- Disable automatically restoring the last session
    auto_session_enable_last_session = false,
    -- Set the session strategy to the current working directory
    strategy = "cwd",
    -- Directory where sessions are saved
    auto_session_root_dir = vim.fn.stdpath "data" .. "/sessions/",
    -- Session name patterns to suppress (won't create sessions for these)
    auto_session_suppress_dirs = {
      "~/",
      "~/Downloads",
      "/",
      "/tmp",
    },
    -- Files/patterns to exclude from session saving
    session_lens = {
      -- Load on startup
      load_on_startup = true,
      -- Theme for session picker
      theme_conf = { border = true },
      -- Preview session contents
      previewer = false,
    },
    -- Hook functions for session events
    pre_save_cmds = {
      -- Close Neo-tree before saving session
      "Neotree close",
      -- Close any floating windows
      "lua for _, win in ipairs(vim.api.nvim_list_wins()) do if vim.api.nvim_win_get_config(win).relative ~= '' then vim.api.nvim_win_close(win, false) end end",
    },
    post_restore_cmds = {
      -- Commands to run after restoring session
      -- Uncomment the next line if you want Neo-tree to open automatically after session restore
      -- "Neotree show",
    },
    -- Don't save these buffer types
    bypass_session_save_file_types = {
      "alpha", -- AstroVim dashboard
      "neo-tree",
      "lazy",
      "mason",
      "notify",
      "popup",
      "quickfix",
      "TelescopePrompt",
      "help",
      "nofile",
      "terminal",
    },

    -- Close these windows before saving session
    close_unsupported_windows = true,

    -- Arguments to pass to session save/restore
    args_allow_single_directory = true,
    args_allow_files_auto_save = false,

    -- Cwd change handling
    cwd_change_handling = {
      restore_upcoming_session = true,
      pre_cwd_changed_hook = nil,
      post_cwd_changed_hook = function() require("lualine").refresh() end,
    },

    -- Continue session on config reload
    continue_restore_on_setup = false,
  },

  -- Key mappings
  keys = {
    {
      "<leader>Ss",
      function() require("auto-session").SaveSession() end,
      desc = "Save Session",
    },
    {
      "<leader>Sr",
      function() require("auto-session").RestoreSession() end,
      desc = "Restore Session",
    },
    {
      "<leader>Sd",
      function() require("auto-session").DeleteSession() end,
      desc = "Delete Session",
    },
    {
      "<leader>Sf",
      function() require("auto-session.session-lens").search_session() end,
      desc = "Find Sessions",
    },
    {
      "<leader>S.",
      function() require("auto-session").RestoreSessionFromFile() end,
      desc = "Restore Session from File",
    },
    {
      "<leader>Q",
      function()
        require("auto-session").SaveSession()
        vim.cmd "qa!"
      end,
      desc = "Save Session and Quit All",
    },
    {
      "<leader>q",
      function()
        require("auto-session").SaveSession()
        vim.cmd "q"
      end,
      desc = "Save Session and Quit Current",
    },
    {
      "ZZ",
      function()
        require("auto-session").SaveSession()
        vim.cmd "wqa"
      end,
      desc = "Save Session, Write All and Quit",
      mode = "n",
    },
  },

  -- Optional: Configure which-key descriptions
  config = function(_, opts)
    require("auto-session").setup(opts)

    -- Add which-key group description if available
    local ok, wk = pcall(require, "which-key")
    if ok then wk.register {
      ["<leader>S"] = { name = "󰁯 Sessions" },
    } end

    -- Optional: Create autocmd for additional session handling
    vim.api.nvim_create_autocmd("User", {
      pattern = "AstroFile",
      callback = function()
        -- Custom logic when opening files
        -- This runs after AstroVim determines a real file was opened
      end,
    })

    -- Set up session lens telescope extension
    pcall(require("telescope").load_extension, "session-lens")
  end,
}
