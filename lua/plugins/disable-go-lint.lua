-- This file overrides the default linter for Go to disable golangci-lint.
return {
  "nvimtools/none-ls.nvim",
  opts = function(_, opts)
    -- This function finds the linter sources and filters out golangci-lint
    local new_sources = {}
    if opts.sources then
      for _, source in ipairs(opts.sources) do
        if source.name ~= "golangci-lint" then
          table.insert(new_sources, source)
        end
      end
    end
    opts.sources = new_sources
    return opts
  end,
}
