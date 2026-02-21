return {
  -- gitsigns: git gutter + inline blame
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true,
      current_line_blame_opts = {
        delay = 500,
        virt_text_pos = "eol",
      },
    },
    keys = {
      { "<leader>gb", function() require("gitsigns").blame_line({ full = true }) end,  desc = "Blame line (full)" },
      { "<leader>gB", function() require("gitsigns").toggle_current_line_blame() end,  desc = "Toggle inline blame" },
      { "[g",         function() require("gitsigns").nav_hunk("prev") end,             desc = "Prev hunk" },
      { "]g",         function() require("gitsigns").nav_hunk("next") end,             desc = "Next hunk" },
      { "<leader>gp", function() require("gitsigns").preview_hunk() end,               desc = "Preview hunk" },
      { "<leader>gr", function() require("gitsigns").reset_hunk() end,                 desc = "Reset hunk" },
    },
  },
}
