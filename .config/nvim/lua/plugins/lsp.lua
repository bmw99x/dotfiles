return {
  -- Mason: LSP/linter/formatter installer
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    opts = {},
  },

  -- mason-lspconfig: bridges Mason and nvim-lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {
      ensure_installed = {
        "lua_ls",
        "basedpyright",
        "ruff",
        "vtsls",
        "cssls",
        "cssmodules_ls",
        "eslint",
      },
      automatic_installation = true,
    },
  },

  -- nvim-lspconfig
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- lua_ls
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = { checkThirdParty = false },
          },
        },
      })
      vim.lsp.enable("lua_ls")

      -- basedpyright: imports/completions only
      vim.lsp.config("basedpyright", {
        settings = {
          basedpyright = {
            analysis = {
              autoImportCompletions = true,
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              typeCheckingMode = "off",
            },
            disableOrganizeImports = true,
            disableTaggedHints = true,
          },
        },
        on_attach = function(client)
          client.server_capabilities.diagnosticProvider = false
          client.server_capabilities.hoverProvider = false
          client.server_capabilities.definitionProvider = false
          client.server_capabilities.referencesProvider = false
        end,
      })
      vim.lsp.enable("basedpyright")

      -- ruff: linting + formatting, auto-format on save
      vim.lsp.config("ruff", {
        init_options = {
          settings = {
            format = { args = { "--fix" } },
          },
        },
        on_attach = function(client, bufnr)
          client.server_capabilities.hoverProvider = false
          client.server_capabilities.definitionProvider = false
          client.server_capabilities.referencesProvider = false
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ async = false, bufnr = bufnr })
            end,
          })
        end,
      })
      vim.lsp.enable("ruff")

      -- ty: type checking only
      vim.lsp.config("ty", {
        on_attach = function(client)
          client.server_capabilities.definitionProvider = false
          client.server_capabilities.referencesProvider = false
          client.server_capabilities.hoverProvider = false
          client.server_capabilities.completionProvider = false
        end,
      })
      vim.lsp.enable("ty")

      -- vtsls: TypeScript/JavaScript/React
      vim.lsp.config("vtsls", {
        settings = {
          typescript = {
            inlayHints = {
              parameterNames = { enabled = "literals" },
              variableTypes = { enabled = true },
              returnTypes = { enabled = true },
            },
          },
          javascript = {
            inlayHints = {
              parameterNames = { enabled = "literals" },
              variableTypes = { enabled = true },
              returnTypes = { enabled = true },
            },
          },
        },
      })
      vim.lsp.enable("vtsls")

      -- cssls: CSS/SCSS/LESS
      vim.lsp.enable("cssls")

      -- cssmodules_ls: CSS modules go-to-definition
      vim.lsp.config("cssmodules_ls", {
        init_options = { camelCase = "dashes" },
      })
      vim.lsp.enable("cssmodules_ls")

      -- eslint: linting + auto-fix on save
      vim.lsp.config("eslint", {
        on_attach = function(_, bufnr)
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            command = "EslintFixAll",
          })
        end,
      })
      vim.lsp.enable("eslint")

      -- Shared keymaps on LspAttach
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local buf = args.buf
          local map = function(keys, fn, desc)
            vim.keymap.set("n", keys, fn, { buffer = buf, desc = desc })
          end
          map("K",           vim.lsp.buf.hover,        "Hover docs")
          map("<leader>ca",  vim.lsp.buf.code_action,  "Code action")
          map("<leader>cf",  vim.lsp.buf.format,        "Format")
        end,
      })
    end,
  },

  -- fidget: LSP progress spinner
  {
    "j-hui/fidget.nvim",
    opts = {},
  },

  -- trouble.nvim: diagnostics list
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {
      focus = true,
      keys = {
        ["<cr>"]  = "jump_close",
        ["o"]     = "jump",
        ["<C-s>"] = "split",
        ["<C-v>"] = "vsplit",
      },
    },
    keys = {
      { "<leader>dx", "<cmd>Trouble diagnostics toggle<cr>",           desc = "Diagnostics (workspace)" },
      { "<leader>dd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Diagnostics (buffer)" },
      { "<leader>dl", "<cmd>Trouble loclist toggle<cr>",               desc = "Location list" },
      { "<leader>dq", "<cmd>Trouble qflist toggle<cr>",                desc = "Quickfix list" },
      { "<leader>dr", "<cmd>Trouble lsp toggle<cr>",                   desc = "LSP references" },
    },
  },

  -- glance.nvim: floating LSP preview
  {
    "DNLHC/glance.nvim",
    opts = {
      border = { enable = true },
      theme = { enable = true, mode = "auto" },
      list = { position = "right", width = 0.4 },
      preview_win_opts = { cursorline = true, number = true },
    },
    keys = {
      { "gD", "<cmd>Glance definitions<cr>",     desc = "Glance definitions" },
      { "gR", "<cmd>Glance references<cr>",      desc = "Glance references" },
      { "gI", "<cmd>Glance implementations<cr>", desc = "Glance implementations" },
      { "gT", "<cmd>Glance type_definitions<cr>", desc = "Glance type definitions" },
    },
  },

  -- lsp_lines: virtual diagnostic lines
  {
    "Maan2003/lsp_lines.nvim",
    opts = {},
    config = function()
      vim.diagnostic.config({ virtual_lines = false })
    end,
    keys = {
      { "<leader>uL", function()
        vim.diagnostic.config({ virtual_lines = not vim.diagnostic.config().virtual_lines })
      end, desc = "Toggle diagnostic lines" },
    },
  },
}
