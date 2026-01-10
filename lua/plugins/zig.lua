return {
  -- Treesitter support for Zig
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "zig" })
      end
    end,
  },

  -- Neotest support for Zig testing
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = { "lawrence-laz/neotest-zig", version = "^1", config = function() end },
    opts = function(_, opts)
      if not opts.adapters then opts.adapters = {} end
      table.insert(opts.adapters, require "neotest-zig"(require("astrocore").plugin_opts "neotest-zig"))
    end,
  },

  -- ZLS Language Server Configuration
  {
    "AstroNvim/astrolsp",
    optional = true,
    ---@type AstroLSPOpts
    opts = {
      ---@diagnostic disable: missing-fields
      config = {
        zls = {
          settings = {
            zls = {
              enable_snippets = true,
              enable_ast_check_diagnostics = true,
              enable_autofix = true,
              enable_import_embedfile_argument_completions = true,
              enable_semantic_tokens = true,
              enable_inlay_hints = true,
              inlay_hints_show_builtin = true,
              inlay_hints_exclude_single_argument = false,
              inlay_hints_hide_redundant_param_names = false,
              inlay_hints_hide_redundant_param_names_last_token = false,
              warn_style = true,
              highlight_global_var_declarations = true,
              dangerous_comptime_experiments_do_not_enable = false,
            },
          },
        },
      },
    },
  },

  -- Ensure ZLS is installed (skip if already installed system-wide)
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    optional = true,
    opts = function(_, opts)
      -- Only auto-install if you want Mason to manage it
      -- Since you have zls installed system-wide, you can comment this out
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "zls" })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    optional = true,
    opts = function(_, opts)
      -- Only auto-install if you want Mason to manage it
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "zls" })
    end,
  },
}
