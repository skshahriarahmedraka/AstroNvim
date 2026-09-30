-- AstroNvim pins aerial to ^2.2 (lazy_snapshot.lua), but v2.x calls TSNode:start()/end_(),
-- which errors on Neovim 0.12 ("attempt to call method 'start'"). v4 uses node:range() and
-- only raises the minimum Neovim version to 0.12. Drop this once AstroNvim bumps its pin.
---@type LazySpec
return {
  "stevearc/aerial.nvim",
  version = "^4",
}
