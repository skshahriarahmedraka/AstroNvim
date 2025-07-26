-- METHOD 1: Complete Copilot Chat Setup with Agent Mode
-- Add to ~/.config/nvim/lua/user/plugins/copilot-chat.lua
return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
      { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
    },
    opts = {
      debug = false, -- Enable debugging
      -- See Configuration section for rest
    },
    config = function()
      require("CopilotChat").setup {
        debug = false,

        -- Chat settings
        question_header = "## User ",
        answer_header = "## Copilot ",
        error_header = "## Error ",
        separator = " ", -- Separator to use in chat

        -- Agent configuration (NEW FEATURE)
        agent = "copilot", -- Can be 'copilot' or 'gpt4'

        -- Context settings
        context = "buffers", -- Default context to use, 'buffers', 'buffer' or none (can be specified manually in prompt via @).

        -- Window settinjgs
        window = {
          layout = "vertical", -- 'vertical', 'horizontal', 'float', 'replace'
          width = 0.5, -- fractional width of parent, or absolute width in columns when > 1
          height = 0.5, -- fractional height of parent, or absolute height in rows when > 1
          -- Options below only apply to floating windows
          relative = "editor", -- 'editor', 'win', 'cursor', 'mouse'
          border = "single", -- 'none', single', 'double', 'rounded', 'solid', 'shadow'
          row = nil, -- row position of the window, default is centered
          col = nil, -- column position of the window, default is centered
          title = "Copilot Chat", -- title of chat window
          footer = nil, -- footer of chat window
          zindex = 1, -- determines if window is on top or below other floating windows
        },

        -- Selection settings
        selection = function(source)
          local select = require "CopilotChat.select"
          return select.visual(source) or select.buffer(source)
        end,

        -- Prompts (Agents)
        prompts = {
          -- Code related prompts
          Explain = {
            prompt = "/COPILOT_EXPLAIN Write an explanation for the active selection as paragraphs of text.",
          },
          Review = {
            prompt = "/COPILOT_REVIEW Review the selected code.",
            callback = function(response, source)
              -- see config.lua for implementation
            end,
          },
          Fix = {
            prompt = "/COPILOT_GENERATE There is a problem in this code. Rewrite the code to show it with the bug fixed.",
          },
          Optimize = {
            prompt = "/COPILOT_GENERATE Optimize the selected code to improve performance and readability.",
          },
          Docs = {
            prompt = "/COPILOT_GENERATE Please add documentation comment for the selection.",
          },
          Tests = {
            prompt = "/COPILOT_GENERATE Please generate tests for my code.",
          },
          FixDiagnostic = {
            prompt = "/COPILOT_GENERATE Please assist with the following diagnostic issue in file:",
            selection = require("CopilotChat.select").diagnostics,
          },
          Commit = {
            prompt = "/COPILOT_GENERATE Write commit message for the change with commitizen convention",
            selection = require("CopilotChat.select").gitdiff,
          },
          CommitStaged = {
            prompt = "/COPILOT_GENERATE Write commit message for the change with commitizen convention",
            selection = function(source) return require("CopilotChat.select").gitdiff(source, true) end,
          },

          -- Agent-specific prompts
          Agent = {
            prompt = "/COPILOT_AGENT You are an AI coding assistant. Help me with the following task:",
          },
          CodeAgent = {
            prompt = "/COPILOT_AGENT Act as a senior software engineer. Analyze this code and provide suggestions:",
          },
          DebugAgent = {
            prompt = "/COPILOT_AGENT Act as a debugging expert. Help me identify and fix issues in this code:",
          },
          RefactorAgent = {
            prompt = "/COPILOT_AGENT Act as a code refactoring specialist. Suggest improvements for this code:",
          },
        },

        -- Default mappings
        mappings = {
          complete = {
            detail = "Use @<Tab> or /<Tab> for options.",
            insert = "<Tab>",
          },
          close = {
            normal = "q",
            insert = "<C-c>",
          },
          reset = {
            normal = "<C-r>",
            insert = "<C-r>",
          },
          submit_prompt = {
            normal = "<CR>",
            insert = "<C-s>",
          },
          accept_diff = {
            normal = "<C-y>",
            insert = "<C-y>",
          },
          yank_diff = {
            normal = "gy",
            register = '"',
          },
          show_diff = {
            normal = "gd",
          },
        },
      }
    end,
    event = "VeryLazy",
    keys = {
      -- Chat commands
      { "<leader>ccq", "<cmd>CopilotChatToggle<cr>", desc = "Toggle Copilot Chat" },
      { "<leader>ccx", "<cmd>CopilotChatReset<cr>", desc = "Reset Copilot Chat" },
      { "<leader>ccs", "<cmd>CopilotChatSave<cr>", desc = "Save Copilot Chat" },
      { "<leader>ccl", "<cmd>CopilotChatLoad<cr>", desc = "Load Copilot Chat" },

      -- Agent prompts
      { "<leader>cce", "<cmd>CopilotChatExplain<cr>", desc = "Explain code", mode = { "n", "v" } },
      { "<leader>ccr", "<cmd>CopilotChatReview<cr>", desc = "Review code", mode = { "n", "v" } },
      { "<leader>ccf", "<cmd>CopilotChatFix<cr>", desc = "Fix code", mode = { "n", "v" } },
      { "<leader>cco", "<cmd>CopilotChatOptimize<cr>", desc = "Optimize code", mode = { "n", "v" } },
      { "<leader>ccd", "<cmd>CopilotChatDocs<cr>", desc = "Generate docs", mode = { "n", "v" } },
      { "<leader>cct", "<cmd>CopilotChatTests<cr>", desc = "Generate tests", mode = { "n", "v" } },
      { "<leader>ccD", "<cmd>CopilotChatFixDiagnostic<cr>", desc = "Fix diagnostic", mode = { "n", "v" } },
      { "<leader>ccm", "<cmd>CopilotChatCommit<cr>", desc = "Generate commit message" },
      { "<leader>ccM", "<cmd>CopilotChatCommitStaged<cr>", desc = "Generate commit message for staged" },

      -- Agent modes
      { "<leader>cca", "<cmd>CopilotChatAgent<cr>", desc = "General AI Agent", mode = { "n", "v" } },
      { "<leader>ccA", "<cmd>CopilotChatCodeAgent<cr>", desc = "Code Review Agent", mode = { "n", "v" } },
      { "<leader>ccb", "<cmd>CopilotChatDebugAgent<cr>", desc = "Debug Agent", mode = { "n", "v" } },
      { "<leader>ccR", "<cmd>CopilotChatRefactorAgent<cr>", desc = "Refactor Agent", mode = { "n", "v" } },

      -- Quick chat
      {
        "<leader>ccQ",
        function()
          local input = vim.fn.input "Quick Chat: "
          if input ~= "" then
            require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
          end
        end,
        desc = "Quick chat",
      },

      -- Visual mode specific
      { "<leader>ccv", ":CopilotChatVisual<cr>", mode = "x", desc = "Chat with visual selection" },
      { "<leader>ccV", ":CopilotChatInPlace<cr>", mode = "x", desc = "Chat in place" },
    },
  },
}
