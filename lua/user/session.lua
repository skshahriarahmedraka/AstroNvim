-- ~/.config/nvim/lua/user/session.lua
-- Enhanced Session Management for AstroVim

local M = {}

-- Configuration
local config = {
  workspace_dir = "~/.config/nvim/shada/workspaces/",
  debug = false,
  auto_save = true,
  auto_restore = true,
  delay_ms = 150,
}

-- Helper functions
local function is_lazy_open()
  return vim.fn.argc() == 0 and vim.fn.line("$") == 1 and vim.fn.getline(1) == ""
end

local function get_git_root()
  local handle = io.popen("git rev-parse --show-toplevel 2>/dev/null")
  if handle then
    local git_root = handle:read("*line")
    handle:close()
    if git_root and git_root ~= "" then
      return git_root
    end
  end
  return nil
end

local function get_workspace_info()
  local dir = get_git_root() or vim.fn.getcwd()
  local hash = vim.fn.sha256(dir)
  local workspace_dir = vim.fn.expand(config.workspace_dir)
  local workspace_path = workspace_dir .. hash .. "/"
  
  return {
    dir = dir,
    hash = hash,
    workspace_path = workspace_path,
    session_file = workspace_path .. "session.vim",
    shada_file = workspace_path .. "shada",
  }
end

local function debug_print(msg)
  if config.debug then
    vim.notify("[Session] " .. msg, vim.log.levels.INFO)
  end
end

local function ensure_workspace_dir(workspace_path)
  if vim.fn.isdirectory(workspace_path) == 0 then
    vim.fn.mkdir(workspace_path, "p")
    debug_print("Created workspace directory: " .. workspace_path)
  end
end

local function close_temp_windows()
  local current_buf = vim.api.nvim_get_current_buf()
  local buftype = vim.api.nvim_get_option_value("buftype", { buf = current_buf })
  
  if buftype == "terminal" or buftype == "quickfix" or buftype == "help" then
    vim.cmd("close")
  end
end

local function focus_last_focused_file()
  if vim.g.last_focused_file and vim.g.last_focused_file ~= "" then
    if vim.fn.filereadable(vim.g.last_focused_file) == 1 then
      vim.cmd("edit " .. vim.fn.fnameescape(vim.g.last_focused_file))
      debug_print("Focused last file: " .. vim.g.last_focused_file)
    end
  end
end

local function save_session()
  if not vim.g.session_file then
    debug_print("No session file configured")
    return false
  end
  
  -- Close temporary windows before saving
  close_temp_windows()
  
  local success, err = pcall(function()
    vim.cmd("mksession! " .. vim.fn.fnameescape(vim.g.session_file))
    
    -- Append last focused file info
    if vim.g.last_focused_file then
      local file = io.open(vim.g.session_file, "a")
      if file then
        file:write(string.format(
          '\n" Last focused file: %s\nlet g:last_focused_file = "%s"\n',
          vim.g.last_focused_file,
          vim.g.last_focused_file
        ))
        file:close()
      end
    end
  end)
  
  if success then
    debug_print("Session saved: " .. vim.g.session_file)
    return true
  else
    vim.notify("[Session] Save failed: " .. (err or "unknown error"), vim.log.levels.ERROR)
    return false
  end
end

local function restore_session()
  if not vim.g.session_file then
    debug_print("No session file configured")
    return false
  end
  
  if vim.fn.filereadable(vim.g.session_file) ~= 1 then
    debug_print("Session file not found: " .. vim.g.session_file)
    return false
  end
  
  -- Store command line args before restoration
  local files_before_load = vim.fn.argv()
  local old_cwd = vim.fn.getcwd()
  
  -- Temporarily disable events to prevent conflicts, but keep some for plugins
  local old_eventignore = vim.o.eventignore
  local old_cmdheight = vim.o.cmdheight
  
  -- Don't ignore BufEnter, BufWinEnter as they're needed for barbar
  vim.o.eventignore = "WinEnter,WinLeave,FocusGained,FocusLost"
  vim.o.cmdheight = 0
  
  local success, err = pcall(function()
    debug_print("Restoring session from: " .. vim.g.session_file)
    vim.cmd("silent! source " .. vim.fn.fnameescape(vim.g.session_file))
  end)
  
  -- Restore original settings
  vim.o.eventignore = old_eventignore
  vim.o.cmdheight = old_cmdheight
  
  if not success then
    vim.notify("[Session] Restore failed: " .. (err or "unknown error"), vim.log.levels.ERROR)
    -- Restore working directory if session failed
    vim.cmd("cd " .. vim.fn.fnameescape(old_cwd))
    return false
  end
  
  -- Open files passed as arguments
  if #files_before_load > 0 then
    for _, file in ipairs(files_before_load) do
      vim.cmd("edit " .. vim.fn.fnameescape(file))
    end
  end
  
  -- Post-session restoration tasks
  vim.defer_fn(function()
    -- Re-trigger buffer events for plugins like barbar
    local current_buf = vim.api.nvim_get_current_buf()
    vim.api.nvim_exec_autocmds("BufEnter", { buffer = current_buf })
    vim.api.nvim_exec_autocmds("BufWinEnter", { buffer = current_buf })
    
    -- Focus last focused file
    focus_last_focused_file()
    
    -- Force barbar to refresh if available
    if package.loaded["barbar"] or package.loaded["barbar.api"] then
      pcall(function()
        require("barbar.api").refresh()
      end)
    end
    
    debug_print("Post-session setup completed")
  end, 100)
  
  debug_print("Session restored successfully")
  vim.cmd("redraw!")
  return true
end

-- Public functions for keymaps
function M.save_session_with_notify()
  if save_session() then
    vim.notify("Session saved successfully", vim.log.levels.INFO)
  end
end

function M.restore_session_with_notify()
  if restore_session() then
    vim.notify("Session restored successfully", vim.log.levels.INFO)
  else
    vim.notify("No session to restore", vim.log.levels.WARN)
  end
end

-- Setup workspace configuration
function M.setup_workspace()
  local workspace = get_workspace_info()
  
  -- Create workspace directory
  ensure_workspace_dir(workspace.workspace_path)
  
  -- Configure vim options
  vim.opt.shadafile = workspace.shada_file
  vim.g.session_file = workspace.session_file
  vim.g.workspace_dir = workspace.dir
  
  debug_print("Workspace configured:")
  debug_print("  Directory: " .. workspace.dir)
  debug_print("  Session: " .. workspace.session_file)
  debug_print("  Shada: " .. workspace.shada_file)
end

-- Main setup function
function M.setup(opts)
  -- Merge user config
  if opts then
    config = vim.tbl_deep_extend("force", config, opts)
  end
  
  -- Setup workspace
  M.setup_workspace()
  
  -- Auto-restore session after a delay to avoid plugin conflicts
  if config.auto_restore then
    -- Wait for plugins to load before restoring session
    vim.defer_fn(function()
      if not is_lazy_open() then
        -- Additional delay to ensure barbar is fully loaded
        vim.defer_fn(function()
          restore_session()
        end, 100)
        
        -- Setup auto-save on exit
        if config.auto_save then
          local group = vim.api.nvim_create_augroup("SessionManagement", { clear = true })
          
          vim.api.nvim_create_autocmd("VimLeavePre", {
            group = group,
            callback = function()
              save_session()
            end,
            desc = "Auto-save session on exit",
          })
          
          -- Track last focused file
          vim.api.nvim_create_autocmd("BufEnter", {
            group = group,
            callback = function()
              local buftype = vim.api.nvim_get_option_value("buftype", { buf = 0 })
              if buftype == "" then
                vim.g.last_focused_file = vim.fn.expand("%:p")
              end
            end,
            desc = "Track last focused file",
          })
        end
      else
        debug_print("Lazy open detected - skipping session restore")
      end
    end, config.delay_ms)
  end
  
  -- Setup keymaps
  M.setup_keymaps()
end

-- Setup keymaps with which-key integration
function M.setup_keymaps()
  local opts = { silent = true, desc = "Session" }
  
  vim.keymap.set("n", "<F6>", M.save_session_with_notify, 
    vim.tbl_extend("force", opts, { desc = "Save Session" }))
  vim.keymap.set("n", "<F7>", M.restore_session_with_notify, 
    vim.tbl_extend("force", opts, { desc = "Restore Session" }))
  
  -- Register with which-key if available
  local ok, wk = pcall(require, "which-key")
  if ok then
    wk.register({
      ["<F6>"] = { M.save_session_with_notify, "Save Session" },
      ["<F7>"] = { M.restore_session_with_notify, "Restore Session" },
    })
  end
end

-- Export individual functions for manual use
M.save_session = save_session
M.restore_session = restore_session
M.close_temp_windows = close_temp_windows

return M
