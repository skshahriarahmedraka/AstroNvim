-- ~/.config/nvim/lua/plugins/astrolsp.lua (or similar path)
-- AstroLSP allows you to customize the features in AstroNvim's LSP configuration engine
-- Configuration documentation can be found with `:h astrolsp`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing
---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    -- Configuration table of features provided by AstroLSP
    features = {
      codelens = true, -- enable/disable codelens refresh on start
      inlay_hints = true, -- enable inlay hints for better code understanding
      semantic_tokens = true, -- enable/disable semantic token highlighting
    },
    -- Enhanced formatting options
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = true, -- enable format on save globally
        allow_filetypes = { -- enable format on save for specified filetypes only
          -- Add filetypes you want to auto-format
          -- "go",
          "lua",
          "python",
          "javascript",
          "typescript",
          "json",
          "yaml",
        },
        ignore_filetypes = { -- disable format on save for specified filetypes
          -- Add filetypes you don't want to auto-format
        },
      },
      disabled = { -- disable formatting capabilities for the listed language servers
        -- Uncomment if you want to use external formatters
        -- "lua_ls",
      },
      timeout_ms = 3000, -- increased timeout for complex formatting
      -- Enhanced filter for better formatting control
      filter = function(client)
        -- Allow formatters
        return true
      end,
    },
    -- Diagnostic configuration for better error display
    diagnostics = {
      virtual_text = {
        severity = { min = vim.diagnostic.severity.HINT },
        source = "if_many",
        prefix = "●",
        spacing = 2,
      },
      signs = {
        active = true,
        values = {
          { name = "DiagnosticSignError", text = "" },
          { name = "DiagnosticSignWarn", text = "" },
          { name = "DiagnosticSignHint", text = "" },
          { name = "DiagnosticSignInfo", text = "" },
        },
      },
      underline = true,
      update_in_insert = true, -- Show diagnostics in insert mode
      severity_sort = true,
      float = {
        focused = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
    },
    -- enable servers that you already have installed without mason
    servers = {
      -- "pyright"
    },
    -- customize language server configuration options passed to `lspconfig`
    ---@diagnostic disable: missing-fields
    config = {
      gopls = {
        settings = {
          gopls = {
            -- Core analysis settings
            gofumpt = true,
            analyses = {
              unusedparams = true,
              shadow = true,
              ST1000 = false, -- ignore package comment requirement
              ST1003 = false, -- ignore underscore in package names
              ST1020 = false, -- ignore method comment format
              golangci_lint = false,
              fieldalignment = false,
              fillreturns = true,
              nilness = true,
              nonewvars = true,
              undeclaredname = true,
              unreachable = true,
              unusedwrite = true,
              useany = true,
            },
            staticcheck = false,
            -- Completion settings
            ["ui.diagnostic.analyses"] = {
              golangci_lint = false,
            },
            buildFlags = { "-tags", "integration" },
            usePlaceholders = false,
            completionBudget = "100ms",
            -- Diagnostic settings - use correct paths
            diagnosticsDelay = "50ms", -- Lower delay for faster diagnostics
            -- Formatting settings
            ["local"] = "", -- local import prefix
            -- Code lens and hints
            codelenses = {
              gc_details = true,
              generate = true,
              regenerate_cgo = true,
              tidy = true,
              upgrade_dependency = true,
              vendor = true,
            },
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              compositeLiteralTypes = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
            -- Hover and documentation
            hoverKind = "FullDocumentation",
            linkTarget = "pkg.go.dev",
            linksInHover = true,
            -- Experimental features
            experimentalPostfixCompletions = true,
            completeUnimported = true,
            matcher = "Fuzzy",
            semanticTokens = true,
            symbolMatcher = "fuzzy",
          },
        },
        -- Enable real-time diagnostics with proper debounce
        flags = {
          debounce_text_changes = 50, -- Lower debounce for faster updates
        },
      },
    },
    -- customize how language servers are attached
    handlers = {
      -- Enhanced LSP handlers for better UI
      ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
        max_width = 80,
        max_height = 20,
        focusable = true,
        close_events = { "CursorMoved", "BufHidden" },
      }),
      ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "rounded",
        focusable = false,
        close_events = { "CursorMoved", "BufHidden", "InsertCharPre" },
      }),
      -- Enhanced diagnostic handler for immediate updates
      -- This handler sets the *defaults* for diagnostics, but can be overridden per buffer in on_attach
      ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        underline = true,
        virtual_text = {
          severity = { min = vim.diagnostic.severity.HINT },
          source = "if_many",
          prefix = "●",
          spacing = 2,
        },
        signs = true,
        update_in_insert = true, -- Key part: Show diagnostics in insert mode by default
        severity_sort = true,
      }),
    },
    -- Configure buffer local auto commands to add when attaching a language server
    -- REMOVED CUSTOM AUTOCMDS HERE TO AVOID CONFLICTS. Handled in on_attach and polish.lua
    autocmds = {
      -- Enhanced real-time diagnostics for Go files
      lsp_diagnostics_go = {
        cond = function(client, bufnr) return client.name == "gopls" and vim.bo[bufnr].filetype == "go" end,
        {
          event = { "TextChanged", "TextChangedI", "TextChangedP" },
          desc = "Real-time diagnostics for Go on text change",
          callback = function(args)
            -- Immediate diagnostic update without debounce for faster feedback
            vim.schedule(function()
              if vim.api.nvim_buf_is_valid(args.buf) then
                -- Force LSP to send diagnostics
                local clients = vim.lsp.get_clients { bufnr = args.buf, name = "gopls" }
                for _, client in pairs(clients) do
                  if client.supports_method "textDocument/diagnostic" then
                    vim.lsp.buf.document_diagnostic { bufnr = args.buf }
                  end
                end
                -- Show existing diagnostics immediately
                vim.diagnostic.show(nil, args.buf)
              end
            end)
          end,
        },
      },
      -- Diagnostics on save for Go files
      lsp_diagnostics_save = {
        cond = function(client, bufnr) return client.name == "gopls" and vim.bo[bufnr].filetype == "go" end,
        {
          event = { "BufWritePost" },
          desc = "Refresh diagnostics on save",
          callback = function(args)
            vim.schedule(function()
              if vim.api.nvim_buf_is_valid(args.buf) then
                -- Force diagnostic refresh on save
                local clients = vim.lsp.get_clients { bufnr = args.buf, name = "gopls" }
                for _, client in pairs(clients) do
                  if client.supports_method "textDocument/diagnostic" then
                    vim.lsp.buf.document_diagnostic { bufnr = args.buf }
                  end
                end
                vim.diagnostic.show(nil, args.buf)
              end
            end)
          end,
        },
      },
      -- Cursor hold diagnostics for Go files
      lsp_diagnostics_hold = {
        cond = function(client, bufnr) return client.name == "gopls" and vim.bo[bufnr].filetype == "go" end,
        {
          event = { "CursorHold", "CursorHoldI" },
          desc = "Request diagnostics on cursor hold",
          callback = function(args)
            vim.schedule(function()
              if vim.api.nvim_buf_is_valid(args.buf) then vim.diagnostic.show(nil, args.buf) end
            end)
          end,
        },
      },
      -- Codelens refresh
      lsp_codelens_refresh = {
        cond = "textDocument/codeLens",
        {
          event = { "InsertLeave", "BufEnter", "BufWritePost" },
          desc = "Refresh codelens (buffer)",
          callback = function(args)
            if require("astrolsp").config.features.codelens then vim.lsp.codelens.refresh { bufnr = args.buf } end
          end,
        },
      },
      -- Inlay hints toggle
      lsp_inlay_hints = {
        cond = function(client, bufnr) return client.supports_method("textDocument/inlayHint", { bufnr = bufnr }) end,
        {
          event = { "InsertEnter", "InsertLeave" },
          desc = "Toggle inlay hints",
          callback = function(args)
            if vim.api.nvim_get_mode().mode == "i" then
              vim.lsp.inlay_hint.enable(false, { bufnr = args.buf })
            else
              vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
            end
          end,
        },
      },
    },
    -- Enhanced mappings
    mappings = {
      n = {
        -- Make 'dd' delete without yanking (to black hole register)
        -- ["dd"] = { '"_dd', desc = "Delete line (no yank)" },

        -- Make '_dd' delete and yank (like original dd)
        -- ["_dd"] = { "dd", desc = "Delete line and yank" },

        -- Navigation
        gD = {
          function() vim.lsp.buf.declaration() end,
          desc = "Declaration of current symbol",
          cond = "textDocument/declaration",
        },
        gd = {
          function() vim.lsp.buf.definition() end,
          desc = "Go to definition",
          cond = "textDocument/definition",
        },
        gI = {
          function() vim.lsp.buf.implementation() end,
          desc = "Go to implementation",
          cond = "textDocument/implementation",
        },
        gy = {
          function() vim.lsp.buf.type_definition() end,
          desc = "Go to type definition",
          cond = "textDocument/typeDefinition",
        },
        gr = {
          function() vim.lsp.buf.references() end,
          desc = "Show references",
          cond = "textDocument/references",
        },

        -- Enhanced hover and help
        K = {
          function() vim.lsp.buf.hover() end,
          desc = "Hover symbol details",
          cond = "textDocument/hover",
        },
        ["<C-k>"] = {
          function() vim.lsp.buf.signature_help() end,
          desc = "Signature help",
          cond = "textDocument/signatureHelp",
        },

        -- Code actions and refactoring
        ["<Leader>ca"] = {
          function() vim.lsp.buf.code_action() end,
          desc = "Code actions",
          cond = "textDocument/codeAction",
        },
        ["<Leader>cA"] = {
          function()
            vim.lsp.buf.code_action {
              context = { only = { "source" } },
              apply = true,
            }
          end,
          desc = "Source actions",
          cond = "textDocument/codeAction",
        },

        -- Formatting
        ["<Leader>cf"] = {
          function()
            vim.lsp.buf.format {
              timeout_ms = 3000,
            }
          end,
          desc = "Format buffer",
          cond = "textDocument/formatting",
        },

        -- Diagnostics
        -- Replace your current mapping with this safe version:
        -- Replace your current mapping with this safe version:
        ["<Leader><Leader>"] = {
          function()
            local ok, telescope = pcall(require, "telescope.builtin")
            if ok then
              telescope.buffers()
            else
              vim.cmd "ls" -- fallback to basic buffer list
            end
          end,
          desc = "Switch buffers",
        },
        -- Quick buffer navigation
        ["<Leader>bb"] = { "<C-6>", desc = "Toggle last buffer" },
        -- ["<Leader>l"] = { ":bnext<CR>", desc = "Next buffer" },
        -- ["<Leader>h"] = { ":bprev<CR>", desc = "Previous buffer" },
        --
        -- -- Buffer management
        -- ["<Leader>bd"] = { ":bdelete<CR>", desc = "Delete buffer" },
        -- ["<Leader>bD"] = { ":bdelete!<CR>", desc = "Force delete buffer" },
        -- ["<Leader>ba"] = { ':%bdelete|edit #|normal `"<CR>', desc = "Delete all but current" },
        --
        -- -- Alternative buffer list (always available)
        -- ["<Leader>bl"] = { ":ls<CR>:b<Space>", desc = "List buffers" },
        -- Diagnostics
        ["<Leader>cd"] = { function() vim.diagnostic.open_float() end, desc = "Line diagnostics" },
        ["<Leader>cD"] = { function() vim.diagnostic.setloclist() end, desc = "Diagnostics location list" },
        ["]d"] = { function() vim.diagnostic.goto_next() end, desc = "Next diagnostic" },
        ["[d"] = { function() vim.diagnostic.goto_prev() end, desc = "Previous diagnostic" },
        ["<Leader>cq"] = { function() vim.diagnostic.setqflist() end, desc = "Diagnostics quickfix" },
        -- Manual diagnostic refresh for Go files
        ["<Leader>cr"] = {
          function()
            local clients = vim.lsp.get_clients { bufnr = 0, name = "gopls" }
            for _, client in pairs(clients) do
              if client.supports_method "textDocument/diagnostic" then vim.lsp.buf.document_diagnostic { bufnr = 0 } end
            end
            vim.diagnostic.show(nil, 0)
          end,
          desc = "Refresh diagnostics",
          cond = function(client, bufnr) return client.name == "gopls" and vim.bo[bufnr].filetype == "go" end,
        },

        --  Toggle features
        ["<Leader>uY"] = {
          function() require("astrolsp.toggles").buffer_semantic_tokens() end,
          desc = "Toggle LSP semantic highlight (buffer)",
          cond = function(client)
            return client.supports_method "textDocument/semanticTokens/full" and vim.lsp.semantic_tokens ~= nil
          end,
        },
        ["<Leader>uh"] = {
          function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end,
          desc = "Toggle inlay hints",
          cond = function(client, bufnr) return client.supports_method("textDocument/inlayHint", { bufnr = bufnr }) end,
        },
      },
      i = {
        -- Signature help in insert mode
        ["<C-k>"] = {
          function() vim.lsp.buf.signature_help() end,
          desc = "Signature help",
          cond = "textDocument/signatureHelp",
        },
      },
      v = {
        -- Code actions in visual mode
        ["<Leader>ca"] = {
          function() vim.lsp.buf.code_action() end,
          desc = "Code actions",
          cond = "textDocument/codeAction",
        },
      },
    },
    -- Enhanced on_attach function
    on_attach = function(client, bufnr)
      -- Apply the global diagnostic config specifically to this buffer
      -- This reinforces the settings, especially update_in_insert
      vim.diagnostic.config {
        virtual_text = {
          severity = { min = vim.diagnostic.severity.HINT },
          source = "if_many",
          prefix = "●",
          spacing = 2,
        },
        signs = true,
        underline = true,
        update_in_insert = true, -- Explicitly set for this buffer
        severity_sort = true,
        float = {
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
          focusable = false,
        },
      }

      if client.name == "null-ls" and vim.bo[bufnr].filetype == "markdown" then vim.diagnostic.enable(false, bufnr) end

      -- Enable inlay hints if supported
      if client.supports_method "textDocument/inlayHint" then vim.lsp.inlay_hint.enable(true, { bufnr = bufnr }) end

      -- Set up enhanced completion
      vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

      -- Configure formatexpr for gq command
      if client.supports_method "textDocument/rangeFormatting" then
        vim.bo[bufnr].formatexpr = "v:lua.vim.lsp.formatexpr()"
      end

      -- Enable document highlighting if supported
      if client.supports_method "textDocument/documentHighlight" then
        local highlight_augroup = vim.api.nvim_create_augroup("lsp_document_highlight", { clear = false })
        vim.api.nvim_clear_autocmds { buffer = bufnr, group = highlight_augroup }
        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
          group = highlight_augroup,
          buffer = bufnr,
          callback = vim.lsp.buf.document_highlight,
        })
        vim.api.nvim_create_autocmd({ "CursorMoved", "WinLeave" }, {
          group = highlight_augroup,
          buffer = bufnr,
          callback = vim.lsp.buf.clear_references,
        })
      end

      -- Special configuration for Go files
      if client.name == "gopls" and vim.bo[bufnr].filetype == "go" then
        -- Set very fast update times for Go files to trigger CursorHold* events faster
        vim.opt_local.updatetime = 100 -- Lower than default 500ms, adjust if needed (e.g., 250)
      end
    end,
  },
}
