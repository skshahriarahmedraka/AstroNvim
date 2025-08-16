-- /home/raka/.config/nvim/lua/user/session.lua

local M = {}

-- Helper functions
local function is_lazy_open() return vim.fn.argc() == 0 and vim.fn.line "$" == 1 and vim.fn.getline(1) == "" end

local function FocusLastFocusedFile()
  if vim.g.last_focused_file and vim.g.last_focused_file ~= "" then
    -- Check if file exists before trying to edit it
    if vim.fn.filereadable(vim.g.last_focused_file) == 1 then
      vim.cmd("edit " .. vim.fn.fnameescape(vim.g.last_focused_file))
    end
  end
end

local function AppendLastFocusedFileToSession()
  if vim.g.session_file and vim.g.last_focused_file then
    local file = io.open(vim.g.session_file, "a")
    if file then
      file:write(
        string.format(
          '\n" Last focused file: %s\nlet g:last_focused_file = "%s"\n',
          vim.g.last_focused_file,
          vim.g.last_focused_file
        )
      )
      file:close()
    end
  end
end

local function werkspaces_close_tmp_windows_to_not_reopen_them()
  local current_buf = vim.api.nvim_get_current_buf()
  local buftype = vim.api.nvim_buf_get_option(current_buf, "buftype")

  if buftype == "terminal" or buftype == "quickfix" or buftype == "help" then vim.cmd "close" end
end

-- Make functions global so they can be called from vim commands
_G.FocusLastFocusedFile = FocusLastFocusedFile
_G.AppendLastFocusedFileToSession = AppendLastFocusedFileToSession
_G.werkspaces_close_tmp_windows_to_not_reopen_them = werkspaces_close_tmp_windows_to_not_reopen_them

-- Main setup function
function M.setup_workspace()
  local function get_git_root()
    local handle = io.popen "git rev-parse --show-toplevel 2>/dev/null"
    if handle then
      local git_root = handle:read "*line"
      handle:close()
      return git_root
    end
    return nil
  end

  local dir = get_git_root() or vim.fn.getcwd()
  local hash = vim.fn.sha256(dir)
  local workspace_dir = "~/.config/nvim/shada/workspaces/"
  workspace_dir = vim.fn.expand(workspace_dir)
  local shada_path = workspace_dir .. hash .. "/shada"

  -- Create workspace directory if it doesn't exist
  vim.fn.mkdir(workspace_dir .. hash, "p")

  vim.opt.shadafile = shada_path
  vim.g.session_file = workspace_dir .. hash .. "/session.vim"

  -- Debug: Print paths
  vim.g.session_debug = true
  if vim.g.session_debug then
    print("Session file: " .. vim.g.session_file)
    print("Shada file: " .. shada_path)
    print("Directory: " .. dir)
  end

vim.cmd [[
    function! RestoreSession()
        let files_before_load = argv()
        if !filereadable(g:session_file)
            if g:session_debug
                lua vim.notify("Session file not found: " .. vim.g.session_file, "warn", { title = "Session Restore" })
            endif
            return
        endif

        " Save current working directory
        let old_cwd = getcwd()
        
        " Temporarily disable events and command line to prevent popups
        let old_eventignore = &eventignore
        let old_cmdheight = &cmdheight
        set eventignore=all
        set cmdheight=0
        
        try
            if g:session_debug
                lua vim.notify("Attempting to restore session from: " .. vim.g.session_file, "info", { title = "Session Restore" })
            endif
            silent! execute "source" g:session_file
            
            " Fix barbar tabs visibility
            set showtabline=2
            
            " Refresh barbar if it exists
            if exists(":BarbarEnable")
                silent! BarbarEnable
            endif
            
            if g:session_debug
                lua vim.notify("Session restored successfully", "info", { title = "Session Restore" })
            endif
        catch
            lua vim.notify("Session Restore FAILED: " .. vim.v.exception, "error", { title = "Session Restore" })
            " Restore working directory if session failed
            execute "cd" fnameescape(old_cwd)
        finally
            " Restore original settings
            let &eventignore = old_eventignore
            let &cmdheight = old_cmdheight
            " Force a redraw to clear any lingering prompts
            redraw!
        endtry

        " Open any files passed as arguments
        if len(files_before_load) > 0
            for file in files_before_load
                execute "edit" fnameescape(file)
            endfor
        endif

        lua FocusLastFocusedFile()
    endfunction
]]
end

function M.setup()
  M.setup_workspace()

  -- Delay the session restoration to avoid conflicts with other plugins
  vim.defer_fn(function()
    -- Auto-restore and save setup
    if not is_lazy_open() then
      -- Disable command line during session restore
      vim.o.cmdheight = 0
      vim.cmd [[
                silent! call RestoreSession()

                augroup AstroVimSessionManagement
                    autocmd!
                    autocmd VimLeavePre * call OnLeaveSaveSession()
                augroup END

                augroup TrackLastFocusedFile
                    autocmd!
                    autocmd BufEnter * if &buftype == '' | let g:last_focused_file = expand('%:p') | endif
                augroup END
            ]]
      -- Re-enable command line after session restore
      vim.defer_fn(function() vim.o.cmdheight = 1 end, 200)
    else
      vim.notify("Lazy open detected - no session restore", vim.log.levels.WARN)
    end
  end, 100) -- 100ms delay

  -- Set up keymaps for which-key if available
  if pcall(require, "which-key") then
    require("which-key").register {
      ["<F6>"] = { "<cmd>call SaveSessionWithNotify()<cr>", "Save Session" },
      ["<F7>"] = { "<cmd>call RestoreSessionWithNotify()<cr>", "Restore Session" },
    }
  end
end

return M
