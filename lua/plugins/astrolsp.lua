-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

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
      inlay_hints = false, -- enable/disable inlay hints on start
      semantic_tokens = true, -- enable/disable semantic token highlighting
    },
    -- formatting options enhanced to trigger auto-imports
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = true, -- enable or disable format on save globally
        allow_filetypes = { -- enable format on save for specified filetypes only
          "go",
        },
        ignore_filetypes = { -- disable format on save for specified filetypes
          -- "python",
        },
      },
      disabled = { -- disable formatting capabilities for the listed language servers
        -- disable lua_ls formatting capability if you want to use StyLua to format your lua code
        -- "lua_ls",
      },
      timeout_ms = 1000, -- default format timeout
      -- Custom filter to enable import organization on save for Go
      filter = function(client)
        if client.name == "gopls" then
          return true
        end
        return true
      end
    },
    -- enable servers that you already have installed without mason
    servers = {
      -- "pyright"
    },
    -- customize language server configuration options passed to `lspconfig`
    ---@diagnostic disable: missing-fields
    config = {
      -- clangd = { capabilities = { offsetEncoding = "utf-8" } },
      gopls = {
        settings = {
          gopls = {
            -- Enable hover with detailed information
            hoverKind = "FullDocumentation",
            -- Include function signatures and documentation
            linkSupport = true,
            -- Show function implementations
            linksInHover = true,
            -- Enhanced completion
            usePlaceholders = true,
            -- Static analysis
            staticcheck = true,
            -- Auto-import settings
            gofumpt = true,
            -- Organize imports automatically
            ["formatting.gofumpt"] = true,
            -- Import organization
            ["import.group"] = true,
            ["import.prefix"] = "local",
            -- Code actions for imports
            ["ui.completion.usePlaceholders"] = true,
            ["ui.diagnostic.analyses"] = {
              fieldalignment = true,
              nilness = true,
              unusedparams = true,
              unusedwrite = true,
              useany = true,
            },
            -- Code lens for references, implementations, etc.
            codelenses = {
              gc_details = true,
              generate = true,
              regenerate_cgo = true,
              test = true,
              tidy = true,
              upgrade_dependency = true,
              vendor = true,
            },
          },
        },
        -- Enable code actions including auto-import
        capabilities = {
          textDocument = {
            codeAction = {
              dynamicRegistration = true,
              isPreferredSupport = true,
              codeActionLiteralSupport = {
                codeActionKind = {
                  valueSet = (function()
                    local res = vim.tbl_values(vim.lsp.protocol.CodeActionKind)
                    table.sort(res)
                    return res
                  end)(),
                },
              },
            },
          },
        },
      },
    },
    -- customize how language servers are attached
    handlers = {
      -- a function without a key is simply the default handler, functions take two parameters, the server name and the configured options table for that server
      -- function(server, opts) require("lspconfig")[server].setup(opts) end

      -- the key is the server that is being setup with `lspconfig`
      -- rust_analyzer = false, -- setting a handler to false will disable the set up of that language server
      -- pyright = function(_, opts) require("lspconfig").pyright.setup(opts) end -- or a custom handler function can be passed
    },
    -- Configure buffer local auto commands to add when attaching a language server
    autocmds = {
      -- first key is the `augroup` to add the auto commands to (:h augroup)
      lsp_codelens_refresh = {
        -- Optional condition to create/delete auto command group
        -- can either be a string of a client capability or a function of `fun(client, bufnr): boolean`
        -- condition will be resolved for each client on each execution and if it ever fails for all clients,
        -- the auto commands will be deleted for that buffer
        cond = "textDocument/codeLens",
        -- cond = function(client, bufnr) return client.name == "lua_ls" end,
        -- list of auto commands to set
        {
          -- events to trigger
          event = { "InsertLeave", "BufEnter" },
          -- the rest of the autocmd options (:h nvim_create_autocmd)
          desc = "Refresh codelens (buffer)",
          callback = function(args)
            if require("astrolsp").config.features.codelens then vim.lsp.codelens.refresh { bufnr = args.buf } end
          end,
        },
      },
      -- Enhanced auto-import and organize imports on save for Go
      lsp_auto_import = {
        cond = function(client, bufnr)
          return client.name == "gopls" and vim.bo[bufnr].filetype == "go"
        end,
        {
          event = "BufWritePre",
          desc = "Auto organize imports on save for Go",
          callback = function(args)
            local params = vim.lsp.util.make_range_params()
            params.context = { only = { "source.organizeImports" } }
            local result = vim.lsp.buf_request_sync(args.buf, "textDocument/codeAction", params, 1000)
            for _, res in pairs(result or {}) do
              for _, action in pairs(res.result or {}) do
                if action.edit then
                  vim.lsp.util.apply_workspace_edit(action.edit, "utf-8")
                end
              end
            end
          end,
        },
      },
    },
    -- mappings to be set up on attaching of a language server
    mappings = {
      n = {
        -- a `cond` key can provided as the string of a server capability to be required to attach, or a function with `client` and `bufnr` parameters from the `on_attach` that returns a boolean
        gD = {
          function() vim.lsp.buf.declaration() end,
          desc = "Declaration of current symbol",
          cond = "textDocument/declaration",
        },
        -- Enhanced hover mapping
        K = {
          function() 
            vim.lsp.buf.hover()
          end,
          desc = "Hover symbol details",
          cond = "textDocument/hover",
        },
        -- Code actions for auto-import and organize imports
        ["<Leader>ca"] = {
          function() vim.lsp.buf.code_action() end,
          desc = "Code actions (including auto-import)",
          cond = "textDocument/codeAction",
        },
        -- Quick fix for adding imports
        ["<Leader>cA"] = {
          function()
            vim.lsp.buf.code_action({
              filter = function(action)
                return action.kind == "source.organizeImports"
              end,
              apply = true,
            })
          end,
          desc = "Organize imports",
          cond = "textDocument/codeAction",
        },
        -- Manual import organization
        ["<Leader>ci"] = {
          function()
            local params = vim.lsp.util.make_range_params()
            params.context = { only = { "source.organizeImports" } }
            local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 1000)
            for _, res in pairs(result or {}) do
              for _, action in pairs(res.result or {}) do
                if action.edit then
                  vim.lsp.util.apply_workspace_edit(action.edit, "utf-8")
                end
              end
            end
          end,
          desc = "Organize imports manually",
          cond = "textDocument/codeAction",
        },
        -- Go to implementation
        gI = {
          function() vim.lsp.buf.implementation() end,
          desc = "Go to implementation",
          cond = "textDocument/implementation",
        },
        -- Show signature help
        ["<C-k>"] = {
          function() vim.lsp.buf.signature_help() end,
          desc = "Signature help",
          cond = "textDocument/signatureHelp",
        },
        ["<Leader>uY"] = {
          function() require("astrolsp.toggles").buffer_semantic_tokens() end,
          desc = "Toggle LSP semantic highlight (buffer)",
          cond = function(client)
            return client.supports_method "textDocument/semanticTokens/full" and vim.lsp.semantic_tokens ~= nil
          end,
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
    },
    -- A custom `on_attach` function to be run after the default `on_attach` function
    -- takes two parameters `client` and `bufnr`  (`:h lspconfig-setup`)
    on_attach = function(client, bufnr)
      -- this would disable semanticTokensProvider for all clients
      -- client.server_capabilities.semanticTokensProvider = nil
      
      -- Enhanced hover configuration for Go
      if client.name == "gopls" then
        -- Configure hover options
        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
          vim.lsp.handlers.hover, {
            border = "rounded",
            max_width = 80,
            max_height = 20,
          }
        )
        
        -- Configure signature help
        vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
          vim.lsp.handlers.signature_help, {
            border = "rounded",
            close_events = { "CursorMoved", "BufHidden", "InsertCharPre" },
          }
        )
      end
    end,
  },
}
