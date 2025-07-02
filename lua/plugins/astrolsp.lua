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
      -- Add your language server configurations here
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
    },
    -- Configure buffer local auto commands to add when attaching a language server
    autocmds = {
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
        ["<Leader>cd"] = { function() vim.diagnostic.open_float() end, desc = "Line diagnostics" },
        ["]d"] = { function() vim.diagnostic.goto_next() end, desc = "Next diagnostic" },
        ["[d"] = { function() vim.diagnostic.goto_prev() end, desc = "Previous diagnostic" },
        ["<Leader>cq"] = { function() vim.diagnostic.setqflist() end, desc = "Diagnostics quickfix" },

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
      -- Configure diagnostic display
      vim.diagnostic.config({
        virtual_text = {
          severity = { min = vim.diagnostic.severity.HINT },
          source = "if_many",
          prefix = "●",
        },
        signs = true,
        underline = true,
        update_in_insert = true, -- Show diagnostics in insert mode
        severity_sort = true,
        float = {
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
      }, bufnr)

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
    end,
  },
}
