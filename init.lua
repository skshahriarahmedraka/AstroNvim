-- This file simply bootstraps the installation of Lazy.nvim and then calls other files for execution
-- This file doesn't necessarily need to be touched, BE CAUTIOUS editing this file and proceed at your own risk.
local lazypath = vim.env.LAZY or vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.env.LAZY or (vim.uv or vim.loop).fs_stat(lazypath)) then
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)
-- validate that lazy is available
if not pcall(require, "lazy") then
  -- stylua: ignore
  vim.api.nvim_echo({ { ("Unable to load lazy from: %s\n"):format(lazypath), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } }, true, {})
  vim.fn.getchar()
  vim.cmd.quit()
end

require "lazy_setup"
require "polish"
require "user.autocmds"


local function export_keymaps()
  local modes = {
    n = "Normal",
    i = "Insert", 
    v = "Visual",
    c = "Command",
    t = "Terminal",
    x = "Visual Block"
  }
  
  local filename = vim.fn.expand("~/.config/nvim/astrovim_keymaps.md")
  local file = io.open(filename, "w")
  
  if not file then
    print("Error: Could not create file")
    return
  end
  
  file:write("# AstroVim Keymaps\n\n")
  file:write("Generated on: " .. os.date() .. "\n\n")
  
  for mode, name in pairs(modes) do
    file:write("## " .. name .. " Mode\n\n")
    file:write("| Key | Command | Description |\n")
    file:write("|-----|---------|-------------|\n")
    
    local keymaps = vim.api.nvim_get_keymap(mode)
    for _, keymap in ipairs(keymaps) do
      local key = keymap.lhs or ""
      local cmd = keymap.rhs or ""
      local desc = keymap.desc or ""
      
      -- Escape markdown special characters
      key = key:gsub("|", "\\|")
      cmd = cmd:gsub("|", "\\|")
      desc = desc:gsub("|", "\\|")
      
      file:write(string.format("| `%s` | `%s` | %s |\n", key, cmd, desc))
    end
    file:write("\n")
  end
  
  file:close()
  print("Keymaps exported to: " .. filename)
end

-- Create command
vim.api.nvim_create_user_command("ExportKeymapsMarkdown", export_keymaps, {})
