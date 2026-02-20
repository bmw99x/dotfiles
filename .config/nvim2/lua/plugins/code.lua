return {
  -- refactoring.nvim: extract/inline functions and variables
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
              if vim.fn.executable(venv_python) == 1 then return venv_python end
            end
            local venv = vim.fn.getcwd() .. "/.venv/bin/python"
            if vim.fn.executable(venv) == 1 then return venv end
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
          if meta and meta.__call then adapter = adapter(config) end
        end
        table.insert(adapters, adapter)
      end
      opts.adapters = adapters
      require("neotest").setup(opts)
    end,
    keys = {
      { "<leader>tn", function() require("neotest").run.run() end,                                     desc = "Run nearest test" },
      { "<leader>tl", function() require("neotest").run.run_last() end,                                desc = "Run last test" },
      { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end,                   desc = "Run file tests" },
      { "<leader>tF", function() require("neotest").run.run({ status = "failed" }) end,                desc = "Run failed tests" },
      { "<leader>ta", function() require("neotest").run.attach() end,                                  desc = "Attach to nearest test" },
      { "<leader>tA", function() require("neotest").run.run({ suite = true }) end,                     desc = "Run all tests" },
      { "<leader>tS", function() require("neotest").run.stop() end,                                    desc = "Stop test" },
      { "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Show test output" },
      { "<leader>tO", function() require("neotest").output_panel.toggle() end,                         desc = "Toggle output panel" },
      { "<leader>tp", function() require("neotest").summary.toggle() end,                              desc = "Toggle test summary" },
      { "<leader>tw", function() require("neotest").watch.toggle(vim.fn.expand("%")) end,              desc = "Toggle watch file" },
      { "<leader>tW", function() require("neotest").watch.toggle() end,                                desc = "Toggle watch nearest" },
      { "[t",         function() require("neotest").jump.prev({ status = "failed" }) end,              desc = "Prev failed test" },
      { "]t",         function() require("neotest").jump.next({ status = "failed" }) end,              desc = "Next failed test" },
    },
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

      -- Auto open/close UI with debug session
      dap.listeners.after.event_initialized["dapui_config"]  = function() dapui.open() end
      dap.listeners.before.event_terminated["dapui_config"]  = function() dapui.close() end
      dap.listeners.before.event_exited["dapui_config"]      = function() dapui.close() end

      require("dap-python").setup("python")
    end,
    keys = {
      { "<leader>db", function() require("dap").toggle_breakpoint() end,                                              desc = "Toggle breakpoint" },
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end,           desc = "Conditional breakpoint" },
      { "<leader>dc", function() require("dap").continue() end,                                                       desc = "Continue" },
      { "<leader>dC", function() require("dap").run_to_cursor() end,                                                  desc = "Run to cursor" },
      { "<leader>di", function() require("dap").step_into() end,                                                      desc = "Step into" },
      { "<leader>do", function() require("dap").step_over() end,                                                      desc = "Step over" },
      { "<leader>dO", function() require("dap").step_out() end,                                                       desc = "Step out" },
      { "<leader>du", function() require("dapui").toggle() end,                                                       desc = "Toggle debug UI" },
      { "<leader>dr", function() require("dap").repl.open() end,                                                      desc = "Open REPL" },
      { "<leader>dl", function() require("dap").run_last() end,                                                       desc = "Run last" },
      { "<leader>dS", function() require("dap").terminate() end,                                                      desc = "Stop debugger" },
    },
  },
}
