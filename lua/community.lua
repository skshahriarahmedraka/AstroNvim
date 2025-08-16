-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.bash" },
  { import = "astrocommunity.pack.cmake" },
  { import = "astrocommunity.pack.cpp" },
  { import = "astrocommunity.pack.go" },
  { import = "astrocommunity.pack.golangci-lint" },
  { import = "astrocommunity.pack.zig" },
  { import = "astrocommunity.pack.svelte" },
  -- import/override with your plugins folder
  -- { import = "astrocommunity.colorscheme.catppuccin" },
  -- { import = "astrocommunity.completion.copilot-lua" },
  -- example of importing an entire language pack
  -- these packs can set up things such as Treesitter, Language Servers, additional language specific plugins, and more!
  { import = "astrocommunity.pack.rust" },
  -- { import = "astrocommunity.pack.python" },

  -- { import = "astrocommunity.pack.xml" },
  { import = "astrocommunity.pack.typescript" },
  { import = "astrocommunity.pack.terraform" },
  { import = "astrocommunity.pack.toml" },
  { import = "astrocommunity.pack.yaml" },
  -- { import = "astrocommunity.pack.docker" },
  { import = "astrocommunity.pack.eslint" },
  { import = "astrocommunity.pack.helm" },
  -- { import = "astrocommunity.pack.markdown" },
  -- { import = "astrocommunity.pack.nginx" },
  { import = "astrocommunity.pack.proto" },
  -- { import = "astrocommunity.pack.python" },
  -- { import = "astrocommunity.pack.sql" },
  { import = "astrocommunity.pack.templ" },
  { import = "astrocommunity.recipes.vscode-icons" },
}
