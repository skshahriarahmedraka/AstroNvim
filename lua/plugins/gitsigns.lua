return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    signs = {
      add = { text = "+" },
      change = { text = "~" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
    },
    current_line_blame = true,
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = "eol", -- eol | overlay | right_align
      delay = 500,
      ignore_whitespace = false,
    },
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map("n", "]c", function()
        if vim.wo.diff then return "]c" end
        vim.schedule(function() gs.next_hunk() end)
        return "<Ignore>"
      end, { expr = true })

      map("n", "[c", function()
        if vim.wo.diff then return "[c" end
        vim.schedule(function() gs.prev_hunk() end)
        return "<Ignore>"
      end, { expr = true })

      -- Actions
      map("n", "<leader>hs", gs.stage_hunk, { desc = "Git Stage Hunk" })
      map("n", "<leader>hr", gs.reset_hunk, { desc = "Git Reset Hunk" })
      map(
        "v",
        "<leader>hs",
        function() gs.stage_hunk { vim.fn.line ".", vim.fn.line "v" } end,
        { desc = "Git Stage Hunk" }
      )
      map(
        "v",
        "<leader>hr",
        function() gs.reset_hunk { vim.fn.line ".", vim.fn.line "v" } end,
        { desc = "Git Reset Hunk" }
      )
      map("n", "<leader>hS", gs.stage_buffer, { desc = "Git Stage Buffer" })
      map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Git Undo Stage Hunk" })
      map("n", "<leader>hR", gs.reset_buffer, { desc = "Git Reset Buffer" })
      map("n", "<leader>hp", gs.preview_hunk, { desc = "Git Preview Hunk" })
      map("n", "<leader>hb", function() gs.blame_line { full = true } end, { desc = "Git Blame Line" })
      map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "Toggle Git Blame" })
      map("n", "<leader>hd", gs.diffthis, { desc = "Git Diff" })
      map("n", "<leader>hD", function() gs.diffthis "~" end, { desc = "Git Diff ~" })
      map("n", "<leader>td", gs.toggle_deleted, { desc = "Toggle Git Deleted" })

      -- Text object
      map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Git Select Hunk" })
    end,
  },
}
