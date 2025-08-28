return {
  "nvim-neotest/neotest",
  optional = true,
  dependencies = { "fredrikaverpil/neotest-golang" },
  opts = function(_, opts)
    if not opts.adapters then opts.adapters = {} end
    table.insert(opts.adapters, require "neotest-golang"(require("astrocore").plugin_opts "neotest-golang"))
  end,
}
