return {
  -- snacks.nvim: picker, notifier, lazygit, terminal, etc.
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      picker = {
        enabled = true,
        win = {
          input = {
            keys = {
              ["<C-j>"] = { "list_down", mode = { "i", "n" } },
              ["<C-k>"] = { "list_up",   mode = { "i", "n" } },
              ["j"]     = { "list_down", mode = "n" },
              ["k"]     = { "list_up",   mode = "n" },
              ["<C-h>"] = { "preview_scroll_left",  mode = { "i", "n" } },
              ["<C-l>"] = { "preview_scroll_right", mode = { "i", "n" } },
            },
          },
          list = {
            keys = {
              ["j"]     = "list_down",
              ["k"]     = "list_up",
              ["<C-j>"] = "list_down",
              ["<C-k>"] = "list_up",
              ["<C-h>"] = "preview_scroll_left",
              ["<C-l>"] = "preview_scroll_right",
              ["h"]     = "preview_scroll_left",
              ["l"]     = "preview_scroll_right",
            },
          },
          preview = {
            keys = {
              ["j"] = "preview_scroll_down",
              ["k"] = "preview_scroll_up",
              ["h"] = "preview_scroll_left",
              ["l"] = "preview_scroll_right",
            },
          },
        },
      },
      notifier  = { enabled = true, timeout = 5000 },
      input     = { enabled = true },
      lazygit   = { enabled = true },
      bufdelete = { enabled = true },
      toggle    = { enabled = true },
    },
    keys = {
      -- find
      { "<leader>ff", function() Snacks.picker.files() end,                                          desc = "Find files" },
      { "<leader>fF", function() Snacks.picker.files({ hidden = true, ignored = true }) end,         desc = "Find ALL files (inc. ignored)" },
      { "<leader>fr", function() Snacks.picker.recent() end,                                         desc = "Recent files" },
      { "<leader>fb", function() Snacks.picker.buffers() end,                                        desc = "Buffers" },
      { "<leader>fe", function() Snacks.picker.explorer() end,                                       desc = "Explorer" },
      -- search
      { "<leader>sg", function() Snacks.picker.grep() end,                                           desc = "Grep (rg)" },
      { "<leader>sG", function() Snacks.picker.grep({ hidden = true, ignored = true }) end,          desc = "Grep ALL files (inc. ignored)" },
      { "<leader>sw", function() Snacks.picker.grep_word() end,                                      desc = "Grep word under cursor" },
      { "<leader>ss", function() Snacks.picker.lsp_symbols() end,                                   desc = "LSP symbols" },
      { "<leader>sd", function() Snacks.picker.diagnostics() end,                                   desc = "Diagnostics" },
      { "<leader>sh", function() Snacks.picker.help() end,                                           desc = "Help tags" },
      { "<leader>sk", function() Snacks.picker.keymaps() end,                                        desc = "Keymaps" },
      { "<leader>s.", function() Snacks.picker.resume() end,                                         desc = "Resume last picker" },
      { "<leader>s/", function() Snacks.picker.search_history() end,                                desc = "Search history" },
      -- git
      { "<leader>gg", function() Snacks.lazygit() end,                                               desc = "Lazygit" },
      { "<leader>gc", function() Snacks.picker.git_log() end,                                        desc = "Git commits" },
      { "<leader>gs", function() Snacks.picker.git_status() end,                                    desc = "Git status" },
      { "<leader>gb", function() Snacks.picker.git_branches() end,                                  desc = "Git branches" },
      -- LSP
      { "<leader>cr", function() Snacks.picker.lsp_references() end,                                desc = "References" },
      { "<leader>cd", function() Snacks.picker.lsp_definitions() end,                               desc = "Definitions" },
      -- window
      { "<leader>wm", function() Snacks.toggle.zoom():toggle() end,                                  desc = "Zoom window" },
      { "<leader>wz", function() Snacks.toggle.zen():toggle() end,                                   desc = "Zen mode" },
      -- yank history (requires yanky)
      { "<leader>sy", function() Snacks.picker.yanky() end,                                          desc = "Yank history" },
    },
  },

  -- nvim-tree: file explorer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      on_attach = function(bufnr)
        local api = require("nvim-tree.api")
        api.config.mappings.default_on_attach(bufnr)
        local map = function(key, fn, desc)
          vim.keymap.set("n", key, fn, { buffer = bufnr, noremap = true, silent = true, desc = desc })
        end
        map("l", api.node.open.edit,             "Open / expand")
        map("h", api.node.navigate.parent_close, "Collapse")
        map("H", api.tree.collapse_all,          "Collapse all")
      end,
    },
    keys = {
      { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Explorer" },
    },
  },

  -- harpoon2: mark and jump between files
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    keys = {
      { "<leader>h", function() require("harpoon"):list():add() end,                                desc = "Harpoon add file" },
      { "<leader>H", function() local h = require("harpoon"); h.ui:toggle_quick_menu(h:list()) end, desc = "Harpoon menu" },
      { "<leader>1", function() require("harpoon"):list():select(1) end,                            desc = "Harpoon file 1" },
      { "<leader>2", function() require("harpoon"):list():select(2) end,                            desc = "Harpoon file 2" },
      { "<leader>3", function() require("harpoon"):list():select(3) end,                            desc = "Harpoon file 3" },
      { "<leader>4", function() require("harpoon"):list():select(4) end,                            desc = "Harpoon file 4" },
      { "<leader>5", function() require("harpoon"):list():select(5) end,                            desc = "Harpoon file 5" },
    },
  },
}
