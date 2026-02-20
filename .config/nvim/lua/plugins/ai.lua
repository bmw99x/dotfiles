return {
  -- opencode: AI coding assistant
  {
    "NickvanDyke/opencode.nvim",
    dependencies = {
      { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
    },
    config = function()
      vim.g.opencode_opts = {
        cmd = "/Users/benw/.opencode/bin/opencode",
      }
      vim.o.autoread = true
    end,
    keys = {
      { "<leader>at", function() require("opencode").toggle() end,                          desc = "Toggle OpenCode",  mode = { "n", "x" } },
      { "<leader>ao", function() require("opencode").ask("@this: ", { submit = true }) end, desc = "Ask OpenCode",     mode = { "n", "x" } },
      { "<leader>ax", function() require("opencode").select() end,                          desc = "OpenCode action",  mode = { "n", "x" } },
      { "<leader>aO", function() require("opencode").ask("", { submit = false }) end,       desc = "OpenCode prompt",  mode = { "n", "x" } },
    },
  },

  -- uv.nvim: uv Python package manager integration
  {
    "benomahony/uv.nvim",
    ft = { "python" },
    dependencies = { "folke/snacks.nvim" },
    opts = {
      picker_integration = true,
    },
  },
}
