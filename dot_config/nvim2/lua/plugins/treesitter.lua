return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
    config = function()
      require("nvim-treesitter").setup({
        ensure_installed = {
          "lua", "vim", "vimdoc", "markdown", "python",
          "javascript", "typescript", "tsx", "css", "scss", "html", "json",
        },
        highlight = { enable = true },
        indent = { enable = true },
      })

      -- Textobjects
      require("nvim-treesitter-textobjects").setup({
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = { query = "@function.outer",    desc = "Around function" },
            ["if"] = { query = "@function.inner",    desc = "Inner function" },
            ["ac"] = { query = "@class.outer",       desc = "Around class" },
            ["ic"] = { query = "@class.inner",       desc = "Inner class" },
            ["aa"] = { query = "@parameter.outer",   desc = "Around argument" },
            ["ia"] = { query = "@parameter.inner",   desc = "Inner argument" },
            ["ai"] = { query = "@conditional.outer", desc = "Around conditional" },
            ["ii"] = { query = "@conditional.inner", desc = "Inner conditional" },
            ["al"] = { query = "@loop.outer",        desc = "Around loop" },
            ["il"] = { query = "@loop.inner",        desc = "Inner loop" },
            ["ab"] = { query = "@block.outer",       desc = "Around block" },
            ["ib"] = { query = "@block.inner",       desc = "Inner block" },
          },
        },
      })

      -- Movement keymaps (new treesitter API doesn't auto-wire these)
      local move = require("nvim-treesitter-textobjects.move")
      local maps = {
        { "]f", "next_start",     "@function.outer",    "Next function" },
        { "]F", "next_end",       "@function.outer",    "Next function end" },
        { "[f", "previous_start", "@function.outer",    "Prev function" },
        { "[F", "previous_end",   "@function.outer",    "Prev function end" },
        { "]c", "next_start",     "@class.outer",       "Next class" },
        { "]C", "next_end",       "@class.outer",       "Next class end" },
        { "[c", "previous_start", "@class.outer",       "Prev class" },
        { "[C", "previous_end",   "@class.outer",       "Prev class end" },
        { "]a", "next_start",     "@parameter.inner",   "Next argument" },
        { "[a", "previous_start", "@parameter.inner",   "Prev argument" },
        { "]i", "next_start",     "@conditional.outer", "Next conditional" },
        { "[i", "previous_start", "@conditional.outer", "Prev conditional" },
        { "]l", "next_start",     "@loop.outer",        "Next loop" },
        { "[l", "previous_start", "@loop.outer",        "Prev loop" },
      }
      for _, m in ipairs(maps) do
        local lhs, dir, query, desc = m[1], m[2], m[3], m[4]
        vim.keymap.set({ "n", "x" }, lhs, function()
          move["goto_" .. dir](query)
        end, { desc = desc })
      end

      -- Python ftplugin clobbers ]m/[m — restore treesitter mappings
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "python",
        callback = function(args)
          local buf = args.buf
          vim.keymap.set({ "n", "x" }, "]m", function() move.goto_next_start("@function.outer") end,     { buffer = buf, desc = "Next function" })
          vim.keymap.set({ "n", "x" }, "[m", function() move.goto_previous_start("@function.outer") end,  { buffer = buf, desc = "Prev function" })
          vim.keymap.set({ "n", "x" }, "]M", function() move.goto_next_end("@function.outer") end,        { buffer = buf, desc = "Next function end" })
          vim.keymap.set({ "n", "x" }, "[M", function() move.goto_previous_end("@function.outer") end,    { buffer = buf, desc = "Prev function end" })
        end,
      })
    end,
  },

  -- treesitter-context: sticky function/class header
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = { max_lines = 3 },
  },
}
