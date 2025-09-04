return {
  -- ── 🐛 DAP: Debug Adapter Protocol Configuration for AstroVim ──
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "AstroNvim/astrocore",
      "leoluz/nvim-dap-go", -- Only add Go-specific adapter
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- ┌────────────────────────────────────┐
      -- │           DAP UI Setup             │
      -- └────────────────────────────────────┘
      dapui.setup()
      

      -- ┌────────────────────────────────────┐
      -- │     Virtual Text (Inline Values)   │
      -- └────────────────────────────────────┘
      require("nvim-dap-virtual-text").setup({
        enabled = true,
      })

      -- ┌────────────────────────────────────┐
      -- │           Go Debugger Setup        │
      -- └────────────────────────────────────┘
      require("dap-go").setup()

      -- ┌────────────────────────────────────┐
      -- │       Debug Configurations (Go)    │
      -- └────────────────────────────────────┘
      dap.configurations.go = {
        {
          type = "go",
          name = "Debug current file",
          request = "launch",
          program = "${file}",
        },
        {
          type = "go",
          name = "Debug test",
          request = "launch",
          mode = "test",
          program = "${file}",
        },
        {
          type = "go",
          name = "Debug package",
          request = "launch",
          program = ".",
        },
      }
      -- ┌────────────────────────────────────┐
      -- │            Keymaps                 │
      -- └────────────────────────────────────┘
      local keymaps = {
        { "n", "<F5>", "<cmd>lua require'dap'.continue()<CR>", { desc = "Debug: Continue" } },
        { "n", "<F10>", "<cmd>lua require'dap'.step_over()<CR>", { desc = "Debug: Step Over" } },
        { "n", "<F11>", "<cmd>lua require'dap'.step_into()<CR>", { desc = "Debug: Step Into" } },
        { "n", "<S-F11>", "<cmd>lua require'dap'.step_out()<CR>", { desc = "Debug: Step Out" } },
        
        { "n", "<leader>dc", "<cmd>lua require'dap'.continue()<CR>", { desc = "Debug: Continue" } },
        { "n", "<leader>so", "<cmd>lua require'dap'.step_over()<CR>", { desc = "Debug: Step Over" } },
        { "n", "<leader>si", "<cmd>lua require'dap'.step_into()<CR>", { desc = "Debug: Step Into" } },
        { "n", "<leader>su", "<cmd>lua require'dap'.step_out()<CR>", { desc = "Debug: Step Out" } },
        
        { "n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", { desc = "Debug: Toggle Breakpoint" } },
        { "n", "<leader>dB", "<cmd>lua require'dap'.clear_breakpoints()<CR>", { desc = "Debug: Clear Breakpoints" } },
        
        { "n", "<leader>dt", "<cmd>lua require'dapui'.toggle()<CR>", { desc = "Debug: Toggle UI" } },
        { "n", "<leader>dn", "<cmd>lua require'dapui'.open()<CR>", { desc = "Debug: Open UI" } },
        { "n", "<leader>dk", "<cmd>lua require'dap'.terminate()<CR>", { desc = "Debug: Terminate" } },
        { "n", "<leader>dr", "<cmd>lua require'dap'.restart()<CR>", { desc = "Debug: Restart" } },
        
        { "n", "K", "<cmd>lua require'dapui'.eval()<CR>", { desc = "Debug: Evaluate" } },
        { "n", "<leader>dp", "<cmd>DapShowLog<CR>", { desc = "Debug: Show Log" } },
      }

      require("which-key").register({
        ["<leader>d"] = { name = "Debug" },
      })

      for _, keymap in ipairs(keymaps) do
        vim.keymap.set(keymap[1], keymap[2], keymap[3], keymap[4])
      end

      -- ┌────────────────────────────────────┐
      -- │      Auto Open/Close DAP UI        │
      -- └────────────────────────────────────┘
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },

  -- ── 🛠️ Mason Integration: Ensure Delve is installed ──
  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = {
      -- Only specify Go-related adapters
      handlers = {
        ["delve"] = function()
          require("dap-go").setup()
        end,
      },
    },
  },
}



-- Debugging Workflow 
-- Starting a Debug Session 
-- Method 1: Debug Current File (Most Common) 
--
--     Open a Go file you want to debug
--     Set breakpoints where needed (see below)
--     Start debugging with one of:
--         <F5> - Start debugging current file
--         <leader>dc - Alternative way to start debugging
--
--
--
-- Method 2: Debug Test 
--
--     Open a Go test file
--     Set breakpoints in test or code being tested
--     Start debugging with:
--         <leader>dT (you'll need to add this mapping - see customization section)
--
--
--
-- Method 3: Debug Package 
--
--     Navigate to your package directory
--     Start debugging with:
--         <leader>dP (you'll need to add this mapping)
--
--
--
-- Basic Debugging Operations 
-- Start/Continue
--
-- <F5>
--
-- <leader>dc
-- Step Over
--
-- <F10>
--
-- <leader>so
-- Step Into
--
-- <F11>
--
-- <leader>si
-- Step Out
--
-- <Shift+F11>
--
-- <leader>su
-- Toggle Breakpoint
--
-- <leader>db
--
-- Click in gutter
-- Clear All Breakpoints
--
-- <leader>dB
--
--
--
-- UI Management 
-- Toggle Debug UI
--
-- <leader>dt
-- Force Open Debug UI
--
-- <leader>dn
-- Terminate Debug Session
--
-- <leader>dk
-- Restart Debug Session
--
-- <leader>dr
-- Evaluate Variable (hover)
--
-- K
--
--
--
-- Key Commands Reference 
-- Core Debugging Commands 
-- Starting & Continuing 
--
--     <F5> / <leader>dc: Start or continue execution
--     <leader>dr: Restart the current debug session
--
--
-- Navigation 
--
--     <F10> / <leader>so: Step over current line
--     <F11> / <leader>si: Step into function call
--     <Shift+F11> / <leader>su: Step out of current function
--
--
-- Breakpoints 
--
--     <leader>db: Toggle breakpoint at current line
--     <leader>dB: Clear all breakpoints
--     Click in the gutter to toggle breakpoints visually
--
--
-- UI & Evaluation 
--
--     <leader>dt: Toggle debug UI panels
--     <leader>dn: Force open debug UI
--     K: Evaluate variable under cursor
--     <leader>dp: Show DAP log for troubleshooting
--
--
--
-- UI Components Explained 
--
-- When you start a debug session, the UI automatically opens with these panels: 
-- Left Panel (40% width) 
--
--     Scopes (40%):  
--         Shows variables in current scope
--         Expand to see local variables, arguments, etc.
--         Values update automatically as you step through code
--
--
--     Breakpoints (20%): 
--         Lists all active breakpoints
--         Click to disable/enable individual breakpoints
--         Shows file path and line number
--
--
--     Stack (40%): 
--         Call stack showing current execution path
--         Click on a frame to jump to that context
--         Shows function names and parameters
--
--
--
-- Bottom Panel (12 lines height) 
--
--     Console:
--         Interactive debug console
--         Type expressions to evaluate
--         Shows program output and debug messages
--         Press <CR> to execute commands
--
--
--
-- Inline Values 
--
--     Variables show current values inline in your code
--     Updates automatically as execution progresses
--     No need to hover or open panels to see common values
--
