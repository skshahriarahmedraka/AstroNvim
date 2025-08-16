return {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
        -- Disable all log messages
        log_level = 'off', -- or vim.log.levels.OFF
        
        -- Alternative: Set log level to only show errors
        -- log_level = 'error', -- or vim.log.levels.ERROR
        
        -- Disable specific warning types (if you want more granular control)
        acknowledge_conflicts = true, -- Acknowledge conflicts to suppress warnings
        
        -- You can also disable the plugin entirely in certain filetypes if needed
        file_types = { 'markdown' }, -- Only enable for markdown files
        
        -- Disable rendering in certain contexts to avoid warnings
        render = {
            enabled = true,
        },
        
        -- If you're getting warnings about treesitter, you can configure this
        treesitter = {
            enabled = true,
            -- Disable specific parsers that might cause warnings
            -- disable = { 'markdown_inline' }, -- uncomment if needed
        },
    },
}
