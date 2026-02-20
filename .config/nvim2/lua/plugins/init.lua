return {
  -- Colorscheme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("catppuccin-mocha")
    end,
  },

  -- which-key: shows keybinding hints
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      spec = {
        { "<leader>f", group = "find" },
        { "<leader>s", group = "search" },
        { "<leader>g", group = "git" },
        { "<leader>c", group = "code" },
        { "<leader>t", group = "todo/test" },
        { "<leader>h", group = "harpoon" },
        { "<leader>a", group = "ai" },
        { "<leader>b", group = "buffer" },
        { "<leader>w", group = "window" },
        { "<leader>r", group = "refactor" },
        { "<leader>u", group = "ui/toggle", icon = " " },
        { "<leader>d", group = "diagnostics/debug", icon = " " },
        { "<leader>df", desc = "Show diagnostic float" },
        { "<leader>cp", group = "copy path" },
        { "<leader>uh", desc = "Toggle inlay hints" },
        { "<leader>uw", desc = "Toggle wrap" },
        { "<leader>us", desc = "Toggle spell" },
        { "<leader>ul", desc = "Toggle line numbers" },
        { "<leader>uL", desc = "Toggle diagnostic lines" },
        { "<leader>uc", desc = "Toggle cursorline" },
        { "<leader>ut", desc = "Theme switcher" },
        { "gd", desc = "Glance definitions" },
        { "gr", desc = "Glance references" },
        { "gi", desc = "Glance implementations" },
        { "gt", desc = "Glance type definitions" },
        { "<x>", group = "uv (Python)", icon = "" },
        { "]", group = "next" },
        { "[", group = "prev" },
      },
    },
  },

  -- snacks.nvim: top-floating picker, notifier, search & replace, etc.
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
              -- vertical navigation (insert + normal)
              ["<C-j>"] = { "list_down", mode = { "i", "n" } },
              ["<C-k>"] = { "list_up",   mode = { "i", "n" } },
              -- normal mode only (j/k must type in insert)
              ["j"]     = { "list_down", mode = "n" },
              ["k"]     = { "list_up",   mode = "n" },
              -- C-h/l for preview scroll only (h/l left free for cursor movement)
              ["<C-h>"] = { "preview_scroll_left",  mode = { "i", "n" } },
              ["<C-l>"] = { "preview_scroll_right", mode = { "i", "n" } },
            },
          },
          list = {
            keys = {
              -- vertical
              ["j"]     = "list_down",
              ["k"]     = "list_up",
              ["<C-j>"] = "list_down",
              ["<C-k>"] = "list_up",
              -- horizontal: scroll preview
              ["<C-h>"] = "preview_scroll_left",
              ["<C-l>"] = "preview_scroll_right",
              ["h"]     = "preview_scroll_left",
              ["l"]     = "preview_scroll_right",
            },
          },
          preview = {
            keys = {
              -- scroll preview with j/k when focused
              ["j"] = "preview_scroll_down",
              ["k"] = "preview_scroll_up",
              ["h"] = "preview_scroll_left",
              ["l"] = "preview_scroll_right",
            },
          },
        },
      },
      notifier = { enabled = true, timeout = 5000 },
      input = { enabled = true },
      lazygit = { enabled = true },
      bufdelete = { enabled = true },
      toggle = { enabled = true },
    },
    keys = {
      -- find
      { "<leader>ff", function() Snacks.picker.files() end,                    desc = "Find files" },
      { "<leader>fF", function() Snacks.picker.files({ hidden = true, ignored = true }) end, desc = "Find ALL files (inc. ignored)" },
      { "<leader>fr", function() Snacks.picker.recent() end,                   desc = "Recent files" },
      { "<leader>fb", function() Snacks.picker.buffers() end,                  desc = "Buffers" },
      { "<leader>fe", function() Snacks.picker.explorer() end,                 desc = "Explorer" },
      -- search
      { "<leader>sg", function() Snacks.picker.grep() end,                     desc = "Grep (rg)" },
      { "<leader>sG", function() Snacks.picker.grep({ hidden = true, ignored = true }) end, desc = "Grep ALL files (inc. ignored)" },
      { "<leader>sw", function() Snacks.picker.grep_word() end,                desc = "Grep word under cursor" },
      { "<leader>ss", function() Snacks.picker.lsp_symbols() end,              desc = "LSP symbols" },
      { "<leader>sd", function() Snacks.picker.diagnostics() end,              desc = "Diagnostics" },
      { "<leader>sh", function() Snacks.picker.help() end,                     desc = "Help tags" },
      { "<leader>sk", function() Snacks.picker.keymaps() end,                  desc = "Keymaps" },
      { "<leader>s.", function() Snacks.picker.resume() end,                   desc = "Resume last picker" },
      { "<leader>s/", function() Snacks.picker.search_history() end,           desc = "Search history" },
      -- git
      { "<leader>gg", function() Snacks.lazygit() end,                         desc = "Lazygit" },
      { "<leader>gc", function() Snacks.picker.git_log() end,                  desc = "Git commits" },
      { "<leader>gs", function() Snacks.picker.git_status() end,               desc = "Git status" },
      { "<leader>gb", function() Snacks.picker.git_branches() end,             desc = "Git branches" },
      -- LSP (go-to via picker)
      { "<leader>cr", function() Snacks.picker.lsp_references() end,           desc = "References" },
      { "<leader>cd", function() Snacks.picker.lsp_definitions() end,          desc = "Definitions" },

      -- window zoom
      { "<leader>wm", function() Snacks.toggle.zoom():toggle() end,             desc = "Zoom window" },
      { "<leader>wz", function() Snacks.toggle.zen():toggle() end,              desc = "Zen mode" },
    },
  },

  -- Mason: LSP/linter/formatter installer
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    opts = {},
  },

  -- mason-lspconfig bridges Mason and nvim-lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {
      -- Add language servers you want auto-installed here
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

  -- nvim-lspconfig (provides :LspInfo, server defaults, etc.)
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- New vim.lsp.config API (nvim 0.11+)
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = { checkThirdParty = false },
          },
        },
      })
      vim.lsp.enable("lua_ls")

      -- basedpyright: imports only (completions, auto-import)
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
          -- Imports only: disable all other capabilities
          client.server_capabilities.diagnosticProvider = false
          client.server_capabilities.hoverProvider = false
          client.server_capabilities.definitionProvider = false
          client.server_capabilities.referencesProvider = false
        end,
      })
      vim.lsp.enable("basedpyright")

      -- ruff: linting + formatting with auto-format on save
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
          -- Auto-format on save
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
          -- Only type checking - no completions, definitions, etc
          client.server_capabilities.definitionProvider = false
          client.server_capabilities.referencesProvider = false
          client.server_capabilities.hoverProvider = false
          client.server_capabilities.completionProvider = false
        end,
      })
      vim.lsp.enable("ty")

      -- vtsls: TypeScript/JavaScript/React (TSX/JSX)
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

      -- cssls: CSS/SCSS/LESS completions and validation
      vim.lsp.enable("cssls")

      -- cssmodules_ls: CSS modules go-to-definition in JS/TS
      vim.lsp.config("cssmodules_ls", {
        init_options = { camelCase = "dashes" },
      })
      vim.lsp.enable("cssmodules_ls")

      -- eslint: linting with auto-fix on save
      vim.lsp.config("eslint", {
        on_attach = function(_, bufnr)
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            command = "EslintFixAll",
          })
        end,
      })
      vim.lsp.enable("eslint")

      -- Shared LSP keymaps
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local buf = args.buf
          local map = function(keys, fn, desc)
            vim.keymap.set("n", keys, fn, { buffer = buf, desc = desc })
          end
          map("K", vim.lsp.buf.hover, "Hover docs")
          map("<leader>ca", vim.lsp.buf.code_action, "Code action")
          map("<leader>cf", vim.lsp.buf.format, "Format")
        end,
      })
    end,
  },

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp-document-symbol",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "onsails/lspkind.nvim",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol_text",
            menu = {
              nvim_lsp = "[LSP]",
              nvim_lsp_document_symbol = "[Symbol]",
              nvim_lsp_signature_help = "[Signature]",
              luasnip = "[Snippet]",
              buffer = "[Buffer]",
              path = "[Path]",
            },
          }),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<C-k>"] = cmp.mapping.select_prev_item(),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "nvim_lsp_document_symbol", keyword_length = 3 },
          { name = "nvim_lsp_signature_help" },
          { name = "luasnip" },
          { name = "buffer", keyword_length = 3 },
          { name = "path" },
        }),
      })
    end,
  },

      -- Treesitter
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

      -- Force treesitter for snacks preview buffers
      vim.api.nvim_create_autocmd("BufWinEnter", {
        callback = function()
          local buf = vim.api.nvim_get_current_buf()
          local ft = vim.bo[buf].filetype
          if ft and ft ~= "" and ft ~= "snacks_picker_input" and ft ~= "snacks_picker_list" then
            pcall(vim.treesitter.start, buf, ft)
          end
        end,
      })

      -- Configure textobjects plugin directly (new treesitter rewrite doesn't
      -- wire these automatically via setup())
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

      -- Move keymaps set manually since new treesitter doesn't wire them
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

      -- Override python.vim ftplugin which clobbers ]m/[m on Python buffers
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "python",
        callback = function(args)
          local buf = args.buf
          vim.keymap.set({ "n", "x" }, "]m", function() move.goto_next_start("@function.outer") end,    { buffer = buf, desc = "Next function" })
          vim.keymap.set({ "n", "x" }, "[m", function() move.goto_previous_start("@function.outer") end, { buffer = buf, desc = "Prev function" })
          vim.keymap.set({ "n", "x" }, "]M", function() move.goto_next_end("@function.outer") end,       { buffer = buf, desc = "Next function end" })
          vim.keymap.set({ "n", "x" }, "[M", function() move.goto_previous_end("@function.outer") end,   { buffer = buf, desc = "Prev function end" })
        end,
      })
    end,
  },

  -- File tree
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      on_attach = function(bufnr)
        local api = require("nvim-tree.api")
        -- Start with all defaults
        api.config.mappings.default_on_attach(bufnr)
        local map = function(key, fn, desc)
          vim.keymap.set("n", key, fn, { buffer = bufnr, noremap = true, silent = true, desc = desc })
        end
        map("l", api.node.open.edit,                "Open / expand")
        map("h", api.node.navigate.parent_close,    "Collapse")
        map("H", api.tree.collapse_all,             "Collapse all")
      end,
    },
    keys = {
      { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Explorer" },
    },
  },

  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = { theme = "catppuccin" },
    },
  },

  -- Git signs in gutter + inline blame
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
      { "<leader>gb", function() require("gitsigns").blame_line({ full = true }) end, desc = "Blame line (full)" },
      { "<leader>gB", function() require("gitsigns").toggle_current_line_blame() end, desc = "Toggle inline blame" },
      { "[g",         function() require("gitsigns").nav_hunk("prev") end,            desc = "Prev hunk" },
      { "]g",         function() require("gitsigns").nav_hunk("next") end,            desc = "Next hunk" },
      { "<leader>gp", function() require("gitsigns").preview_hunk() end,              desc = "Preview hunk" },
      { "<leader>gr", function() require("gitsigns").reset_hunk() end,                desc = "Reset hunk" },
    },
  },

  -- Auto pairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      local autopairs = require("nvim-autopairs")
      local Rule = require("nvim-autopairs.rule")
      local cond = require("nvim-autopairs.conds")

      autopairs.setup({})

      -- Don't auto-close " when preceded by f, b, r, rb, br (string prefixes)
      autopairs.get_rule('"')[1].not_filetypes = nil
      autopairs.get_rule('"')[1]:with_pair(cond.not_before_regex("[fFbBrRuU]", 1))
    end,
  },

  -- Comment toggling
  {
    "numToStr/Comment.nvim",
    opts = {},
  },

  -- Harpoon2: mark files and jump between them instantly
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    keys = {
      { "<leader>h",  function() require("harpoon"):list():add() end,                                    desc = "Harpoon add file" },
      { "<leader>H",  function() local h = require("harpoon"); h.ui:toggle_quick_menu(h:list()) end,     desc = "Harpoon menu" },
      { "<leader>1",  function() require("harpoon"):list():select(1) end,                                desc = "Harpoon file 1" },
      { "<leader>2",  function() require("harpoon"):list():select(2) end,                                desc = "Harpoon file 2" },
      { "<leader>3",  function() require("harpoon"):list():select(3) end,                                desc = "Harpoon file 3" },
      { "<leader>4",  function() require("harpoon"):list():select(4) end,                                desc = "Harpoon file 4" },
      { "<leader>5",  function() require("harpoon"):list():select(5) end,                                desc = "Harpoon file 5" },
    },
  },

  -- neotest: test runner
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-neotest/nvim-nio",
      "nvim-neotest/neotest-python",
    },
    opts = {
      adapters = {
        ["neotest-python"] = {
          python = function()
            local venv_env = os.getenv("VIRTUAL_ENV")
            if venv_env then
              local venv_python = venv_env .. "/bin/python"
              if vim.fn.executable(venv_python) == 1 then
                return venv_python
              end
            end
            local venv = vim.fn.getcwd() .. "/.venv/bin/python"
            if vim.fn.executable(venv) == 1 then
              return venv
            end
            return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
          end,
        },
      },
    },
    config = function(_, opts)
      local adapters = {}
      for name, config in pairs(opts.adapters) do
        local adapter = require(name)
        if type(config) == "table" and not vim.tbl_isempty(config) then
          local meta = getmetatable(adapter)
          if meta and meta.__call then
            adapter = adapter(config)
          end
        end
        table.insert(adapters, adapter)
      end
      opts.adapters = adapters
      require("neotest").setup(opts)
    end,
    keys = {
      { "<leader>tn",  function() require("neotest").run.run() end,                                    desc = "Run nearest test" },
      { "<leader>tl",  function() require("neotest").run.run_last() end,                               desc = "Run last test" },
      { "<leader>tf",  function() require("neotest").run.run(vim.fn.expand("%")) end,                  desc = "Run file tests" },
      { "<leader>tF",  function() require("neotest").run.run({ status = "failed" }) end,               desc = "Run failed tests" },
      { "<leader>ta",  function() require("neotest").run.attach() end,                                 desc = "Attach to nearest test" },
      { "<leader>tA",  function() require("neotest").run.run({ suite = true }) end,                    desc = "Run all tests" },
      { "<leader>tS",  function() require("neotest").run.stop() end,                                   desc = "Stop test" },
      { "<leader>to",  function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Show test output" },
      { "<leader>tO",  function() require("neotest").output_panel.toggle() end,                        desc = "Toggle output panel" },
      { "<leader>tp",  function() require("neotest").summary.toggle() end,                             desc = "Toggle test summary" },
      { "<leader>tw",  function() require("neotest").watch.toggle(vim.fn.expand("%")) end,             desc = "Toggle watch file" },
      { "<leader>tW",  function() require("neotest").watch.toggle() end,                               desc = "Toggle watch nearest" },
      { "[t",          function() require("neotest").jump.prev({ status = "failed" }) end,             desc = "Prev failed test" },
      { "]t",          function() require("neotest").jump.next({ status = "failed" }) end,             desc = "Next failed test" },
    },
  },

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
      { "<leader>at", function() require("opencode").toggle() end,                              desc = "Toggle OpenCode",  mode = { "n", "x" } },
      { "<leader>ao", function() require("opencode").ask("@this: ", { submit = true }) end,     desc = "Ask OpenCode",     mode = { "n", "x" } },
      { "<leader>ax", function() require("opencode").select() end,                              desc = "OpenCode action",  mode = { "n", "x" } },
      { "<leader>aO", function() require("opencode").ask("", { submit = false }) end,           desc = "OpenCode prompt",  mode = { "n", "x" } },
    },
  },

  -- grug-far: search and replace UI
  {
    "MagicDuck/grug-far.nvim",
    opts = {},
    keys = {
      { "<leader>sr",  function() require("grug-far").open() end,                                                           desc = "Search & replace" },
      { "<leader>sw",  function() require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } }) end,       desc = "Search & replace word" },
      { "<leader>sf",  function() require("grug-far").open({ prefills = { paths = vim.fn.expand("%") } }) end,              desc = "Search & replace in file" },
      { "<leader>sv",  function() require("grug-far").with_visual_selection() end,  mode = "v",                             desc = "Search & replace selection" },
    },
  },

  -- yanky: yank history with snacks picker integration
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

  -- flash.nvim: jump anywhere with s/S + 2 chars
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s",     function() require("flash").jump() end,              mode = { "n", "x", "o" }, desc = "Flash jump" },
      { "S",     function() require("flash").treesitter() end,        mode = { "n", "x", "o" }, desc = "Flash treesitter" },
      { "r",     function() require("flash").remote() end,            mode = "o",               desc = "Flash remote" },
      { "<c-s>", function() require("flash").toggle() end,            mode = "c",               desc = "Flash search toggle" },
    },
  },

  -- todo-comments: highlight and search TODO/FIXME/NOTE etc.
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    keys = {
      { "<leader>st", "<cmd>TodoPicker<cr>", desc = "Search TODOs" },
    },
  },

  -- refactoring.nvim: extract function/variable, inline variable
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
    opts = {},
    keys = {
      { "<leader>re", function() require("refactoring").refactor("Extract Function") end,         mode = "x", desc = "Extract function" },
      { "<leader>rf", function() require("refactoring").refactor("Extract Function To File") end, mode = "x", desc = "Extract function to file" },
      { "<leader>rv", function() require("refactoring").refactor("Extract Variable") end,         mode = "x", desc = "Extract variable" },
      { "<leader>ri", function() require("refactoring").refactor("Inline Variable") end,          mode = { "n", "x" }, desc = "Inline variable" },
      { "<leader>rr", function() require("refactoring").select_refactor() end,                    mode = { "n", "x" }, desc = "Select refactor" },
    },
  },

  -- inc-rename: live preview LSP rename
  {
    "smjonas/inc-rename.nvim",
    opts = {},
    keys = {
      { "<leader>rn", function() return ":IncRename " .. vim.fn.expand("<cword>") end, expr = true, desc = "Rename (live preview)" },
    },
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

  -- treesitter-context: sticky header showing current function/class
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      max_lines = 3,
    },
  },

  -- fidget: LSP progress spinner
  {
    "j-hui/fidget.nvim",
    opts = {},
  },

  -- mini.ai: extended text objects
  {
    "echasnovski/mini.ai",
    version = false,
    opts = {},
  },

  -- mini.move: move lines/selections with <M-j>/<M-k>
  -- (Option/Alt key — left of spacebar with modifiers swapped on Mac/Ghostty)
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
        options = {
          reindent_linewise = true,
        },
      })
    end,
  },

  -- nvim-colorizer: show CSS colors inline in terminal
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

  -- uv.nvim: uv Python package manager integration
  {
    "benomahony/uv.nvim",
    ft = { "python" },
    dependencies = { "folke/snacks.nvim" },
    opts = {
      picker_integration = true,
    },
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

  -- Color schemes for theme switcher
  {
    "folke/tokyonight.nvim",
    lazy = true,
  },
  {
    "loctvl842/monokai-pro.nvim",
    lazy = true,
  },
  {
    "ellisonleao/gruvbox.nvim",
    lazy = true,
  },
  {
    "shaunsingh/nord.nvim",
    lazy = true,
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = true,
  },
  {
    "EdenEast/nightfox.nvim",
    lazy = true,
  },
  {
    "Mofiqul/dracula.nvim",
    lazy = true,
  },
  {
    "navarasu/onedark.nvim",
    lazy = true,
  },

  -- Theme switcher
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
          "catppuccin-mocha",
          "catppuccin",
          "catppuccin-latte",
          "catppuccin-frappe",
          "catppuccin-macchiato",
          "tokyonight",
          "tokyonight-storm",
          "tokyonight-night",
          "tokyonight-moon",
          "tokyonight-day",
          "monokai-pro",
          "gruvbox",
          "nord",
          "kanagawa",
          "kanagawa-wave",
          "kanagawa-dragon",
          "kanagawa-lotus",
          "rose-pine",
          "rose-pine-main",
          "rose-pine-moon",
          "rose-pine-dawn",
          "nightfox",
          "dayfox",
          "dawnfox",
          "duskfox",
          "nordfox",
          "terafox",
          "carbonfox",
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

  -- trouble.nvim: diagnostics list in sidebar
  {
    "folke/trouble.nvim",
    opts = {
      focus = true,
      keys = {
        ["<cr>"] = "jump_close",
        ["o"] = "jump",
        ["<C-s>"] = "split",
        ["<C-v>"] = "vsplit",
      },
    },
    cmd = "Trouble",
    keys = {
      { "<leader>dx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (workspace)" },
      { "<leader>dd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Diagnostics (buffer)" },
      { "<leader>dl", "<cmd>Trouble loclist toggle<cr>", desc = "Location list" },
      { "<leader>dq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix list" },
      { "<leader>dr", "<cmd>Trouble lsp toggle<cr>", desc = "LSP references" },
    },
  },

  -- glance.nvim: preview definitions/references/diagnostics in floating window
  {
    "DNLHC/glance.nvim",
    opts = {
      border = { enable = true },
      theme = { enable = true, mode = "auto" },
      list = { position = "right", width = 0.4 },
      preview_win_opts = { cursorline = true, number = true },
    },
    keys = {
      { "gD", "<cmd>Glance definitions<cr>", desc = "Glance definitions" },
      { "gR", "<cmd>Glance references<cr>", desc = "Glance references" },
      { "gI", "<cmd>Glance implementations<cr>", desc = "Glance implementations" },
      { "gT", "<cmd>Glance type_definitions<cr>", desc = "Glance type definitions" },
    },
  },

  -- lsp_lines.nvim: show diagnostics as virtual lines (not horizontal)
  {
    "Maan2003/lsp_lines.nvim",
    opts = {},
    keys = {
      { "<leader>uL", function()
        vim.diagnostic.config({ virtual_lines = not vim.diagnostic.config().virtual_lines })
        vim.diagnostic.reset(nil, 0)
        vim.diagnostic.reset(nil)
      end, desc = "Toggle diagnostic lines" },
    },
    config = function()
      vim.diagnostic.config({
        virtual_lines = false,
      })
    end,
  },

  -- nvim-dap: debug adapter protocol
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "mfussenegger/nvim-dap-python",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup()

      -- Auto-open/close UI
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- Python debug adapter
      require("dap-python").setup("python")
    end,
    keys = {
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle breakpoint" },
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = "Conditional breakpoint" },
      { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
      { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to cursor" },
      { "<leader>di", function() require("dap").step_into() end, desc = "Step into" },
      { "<leader>do", function() require("dap").step_over() end, desc = "Step over" },
      { "<leader>dO", function() require("dap").step_out() end, desc = "Step out" },
      { "<leader>du", function() require("dapui").toggle() end, desc = "Toggle debug UI" },
      { "<leader>dr", function() require("dap").repl.open() end, desc = "Open REPL" },
      { "<leader>dl", function() require("dap").run_last() end, desc = "Run last" },
      { "<leader>dS", function() require("dap").terminate() end, desc = "Stop debugger" },
    },
  },
}
