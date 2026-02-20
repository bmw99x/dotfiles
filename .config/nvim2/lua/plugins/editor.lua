return {
  -- flash.nvim: jump anywhere with s/S
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s",     function() require("flash").jump() end,       mode = { "n", "x", "o" }, desc = "Flash jump" },
      { "S",     function() require("flash").treesitter() end, mode = { "n", "x", "o" }, desc = "Flash treesitter" },
      { "r",     function() require("flash").remote() end,     mode = "o",               desc = "Flash remote" },
      { "<c-s>", function() require("flash").toggle() end,     mode = "c",               desc = "Flash search toggle" },
    },
  },

  -- nvim-autopairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      local autopairs = require("nvim-autopairs")
      local cond = require("nvim-autopairs.conds")
      autopairs.setup({})
      -- Don't auto-close " after Python string prefixes
      autopairs.get_rule('"')[1].not_filetypes = nil
      autopairs.get_rule('"')[1]:with_pair(cond.not_before_regex("[fFbBrRuU]", 1))
    end,
  },

  -- Comment.nvim: toggle comments
  {
    "numToStr/Comment.nvim",
    opts = {},
  },

  -- mini.surround: add/delete/change surrounds
  {
    "echasnovski/mini.surround",
    version = false,
    opts = {
      mappings = {
        add            = "gsa",
        delete         = "gsd",
        find           = "gsf",
        find_left      = "gsF",
        highlight      = "gsh",
        replace        = "gsr",
        update_n_lines = "gsn",
      },
    },
  },

  -- mini.ai: extended text objects (a/i)
  {
    "echasnovski/mini.ai",
    version = false,
    opts = {},
  },

  -- mini.move: move lines/selections with Alt+j/k
  {
    "nvim-mini/mini.move",
    version = false,
    event = "VeryLazy",
    config = function()
      require("mini.move").setup({
        mappings = {
          down       = "<M-j>",
          up         = "<M-k>",
          left       = "",
          right      = "",
          line_down  = "<M-j>",
          line_up    = "<M-k>",
          line_left  = "",
          line_right = "",
        },
        options = { reindent_linewise = true },
      })
    end,
  },

  -- illuminate: highlight other occurrences of word under cursor
  {
    "RRethy/vim-illuminate",
    event = "VeryLazy",
    opts = {
      delay = 200,
      large_file_cutoff = 2000,
    },
    config = function(_, opts)
      require("illuminate").configure(opts)
    end,
  },

  -- yanky: yank history
  {
    "gbprod/yanky.nvim",
    opts = {},
    keys = {
      { "p",          "<Plug>(YankyPutAfter)",               mode = { "n", "x" }, desc = "Put after" },
      { "P",          "<Plug>(YankyPutBefore)",              mode = { "n", "x" }, desc = "Put before" },
      { "<c-p>",      "<Plug>(YankyPreviousEntry)",                                desc = "Previous yank" },
      { "<c-n>",      "<Plug>(YankyNextEntry)",                                    desc = "Next yank" },
      { "<leader>sy", function() Snacks.picker.yanky() end,                        desc = "Yank history" },
    },
  },

  -- grug-far: search and replace UI
  {
    "MagicDuck/grug-far.nvim",
    opts = {},
    keys = {
      { "<leader>sr", function() require("grug-far").open() end,                                                     desc = "Search & replace" },
      { "<leader>sw", function() require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } }) end, desc = "Search & replace word" },
      { "<leader>sf", function() require("grug-far").open({ prefills = { paths = vim.fn.expand("%") } }) end,       desc = "Search & replace in file" },
      { "<leader>sv", function() require("grug-far").with_visual_selection() end, mode = "v",                       desc = "Search & replace selection" },
    },
  },

  -- todo-comments: highlight TODO/FIXME/NOTE etc.
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    keys = {
      { "<leader>st", "<cmd>TodoPicker<cr>", desc = "Search TODOs" },
    },
  },
}
