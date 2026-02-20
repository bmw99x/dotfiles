return {
  -- Colorscheme (default)
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("catppuccin-mocha")
    end,
  },

  -- which-key: keybinding hints
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      spec = {
        { "<leader>f",  group = "find" },
        { "<leader>s",  group = "search" },
        { "<leader>g",  group = "git" },
        { "<leader>c",  group = "code" },
        { "<leader>t",  group = "todo/test" },
        { "<leader>h",  group = "harpoon" },
        { "<leader>a",  group = "ai" },
        { "<leader>b",  group = "buffer" },
        { "<leader>w",  group = "window" },
        { "<leader>r",  group = "refactor" },
        { "<leader>u",  group = "ui/toggle", icon = " " },
        { "<leader>d",  group = "diagnostics/debug", icon = " " },
        { "<leader>cp", group = "copy path" },
        { "<leader>uh", desc = "Toggle inlay hints" },
        { "<leader>uw", desc = "Toggle wrap" },
        { "<leader>us", desc = "Toggle spell" },
        { "<leader>ul", desc = "Toggle line numbers" },
        { "<leader>uL", desc = "Toggle diagnostic lines" },
        { "<leader>uc", desc = "Toggle cursorline" },
        { "<leader>ut", desc = "Theme switcher" },
        { "<leader>df", desc = "Show diagnostic float" },
        { "gD",         desc = "Glance definitions" },
        { "gR",         desc = "Glance references" },
        { "gI",         desc = "Glance implementations" },
        { "gT",         desc = "Glance type definitions" },
        { "<x>",        group = "uv (Python)", icon = "" },
        { "]",          group = "next" },
        { "[",          group = "prev" },
      },
    },
  },

  -- lualine: status line
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = { theme = "catppuccin" },
    },
  },

  -- mini.indentscope: animated indent guides
  {
    "echasnovski/mini.indentscope",
    version = false,
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      symbol = "│",
      options = { try_as_border = true },
    },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },

  -- nvim-colorizer: show CSS colors inline
  {
    "NvChad/nvim-colorizer.lua",
    event = "BufReadPre",
    opts = {
      filetypes = {
        "css", "scss", "sass", "less",
        "html", "javascript", "javascriptreact",
        "typescript", "typescriptreact",
        "lua",
      },
      user_default_options = {
        RGB = true,
        RRGGBB = true,
        names = true,
        RRGGBBAA = true,
        css = true,
        css_fn = true,
        mode = "background",
      },
    },
  },

  -- Color schemes for theme switcher
  { "folke/tokyonight.nvim",     lazy = true },
  { "loctvl842/monokai-pro.nvim", lazy = true },
  { "ellisonleao/gruvbox.nvim",  lazy = true },
  { "shaunsingh/nord.nvim",      lazy = true },
  { "rebelot/kanagawa.nvim",     lazy = true },
  { "rose-pine/neovim",          name = "rose-pine", lazy = true },
  { "EdenEast/nightfox.nvim",    lazy = true },
  { "Mofiqul/dracula.nvim",      lazy = true },
  { "navarasu/onedark.nvim",     lazy = true },

  -- themery: theme switcher UI
  {
    "zaldih/themery.nvim",
    lazy = false,
    dependencies = {
      "catppuccin/nvim",
      "folke/tokyonight.nvim",
      "loctvl842/monokai-pro.nvim",
      "ellisonleao/gruvbox.nvim",
      "shaunsingh/nord.nvim",
      "rebelot/kanagawa.nvim",
      "rose-pine/neovim",
      "EdenEast/nightfox.nvim",
      "Mofiqul/dracula.nvim",
      "navarasu/onedark.nvim",
    },
    config = function()
      require("themery").setup({
        themes = {
          "catppuccin-mocha", "catppuccin", "catppuccin-latte", "catppuccin-frappe", "catppuccin-macchiato",
          "tokyonight", "tokyonight-storm", "tokyonight-night", "tokyonight-moon", "tokyonight-day",
          "monokai-pro",
          "gruvbox",
          "nord",
          "kanagawa", "kanagawa-wave", "kanagawa-dragon", "kanagawa-lotus",
          "rose-pine", "rose-pine-main", "rose-pine-moon", "rose-pine-dawn",
          "nightfox", "dayfox", "dawnfox", "duskfox", "nordfox", "terafox", "carbonfox",
          "dracula",
          "onedark",
        },
        livePreview = true,
      })
    end,
    keys = {
      { "<leader>ut", "<cmd>Themery<cr>", desc = "Theme switcher" },
    },
  },
}
