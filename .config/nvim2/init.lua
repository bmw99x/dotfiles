-- Disable unused providers (avoids slow Python/Ruby/Perl probing)
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Basic options
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.termguicolors = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.undofile = true
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 8
vim.opt.cursorline = true
vim.opt.linebreak = true
vim.opt.list = true
vim.opt.wrap = false
vim.opt.clipboard = "unnamedplus"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitkeep = "screen"
vim.opt.inccommand = "split"
vim.opt.conceallevel = 2
vim.opt.showmode = false

-- Disable line numbers in terminal buffers
vim.api.nvim_create_autocmd("TermOpen", {
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
  end,
})

-- Cmdline: C-j/k to cycle history, C-h/l to move cursor
vim.keymap.set("c", "<C-j>", "<Down>",  { desc = "Next cmdline history" })
vim.keymap.set("c", "<C-k>", "<Up>",    { desc = "Prev cmdline history" })
vim.keymap.set("c", "<C-h>", "<Left>",  { desc = "Cursor left" })
vim.keymap.set("c", "<C-l>", "<Right>", { desc = "Cursor right" })

-- Bracket jumping (any bracket, matched or not)
vim.keymap.set("n", "])", "/)<CR>zz",  { silent = true, desc = "Next )" })
vim.keymap.set("n", "](", "/(<CR>zz",  { silent = true, desc = "Next (" })
vim.keymap.set("n", "]}", "/}<CR>zz",  { silent = true, desc = "Next }" })
vim.keymap.set("n", "]{", "/{<CR>zz",  { silent = true, desc = "Next {" })
vim.keymap.set("n", "][", "/\\[<CR>zz", { silent = true, desc = "Next [" })
vim.keymap.set("n", "]]", "/\\]<CR>zz", { silent = true, desc = "Next ]" })
vim.keymap.set("n", "[)", "?)<CR>zz",  { silent = true, desc = "Prev )" })
vim.keymap.set("n", "[(", "?(<CR>zz",  { silent = true, desc = "Prev (" })
vim.keymap.set("n", "[}", "?}<CR>zz",  { silent = true, desc = "Prev }" })
vim.keymap.set("n", "[{", "?{<CR>zz",  { silent = true, desc = "Prev {" })
vim.keymap.set("n", "[[", "?\\[<CR>zz", { silent = true, desc = "Prev [" })
vim.keymap.set("n", "[]", "?\\]<CR>zz", { silent = true, desc = "Prev ]" })

-- Window navigation (normal + terminal mode)
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })
vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h", { desc = "Go to left window" })
vim.keymap.set("t", "<C-j>", "<C-\\><C-n><C-w>j", { desc = "Go to lower window" })
vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k", { desc = "Go to upper window" })
vim.keymap.set("t", "<C-l>", "<C-\\><C-n><C-w>l", { desc = "Go to right window" })

-- Window resizing
vim.keymap.set("n", "<C-Up>",    "<cmd>resize +2<cr>",          { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>",  "<cmd>resize -2<cr>",           { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>",  "<cmd>vertical resize -2<cr>",  { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>",  { desc = "Increase window width" })

-- Splits
vim.keymap.set("n", "<leader>-",  "<C-W>s",  { desc = "Split below" })
vim.keymap.set("n", "<leader>|",  "<C-W>v",  { desc = "Split right" })
vim.keymap.set("n", "<leader>wd", "<C-W>c",  { desc = "Close window" })

-- Terminal splits (like nvim1)
local function hsplit_term()
  local size = math.floor(vim.o.lines * 0.3)
  vim.cmd("split | resize " .. size .. " | terminal")
  vim.cmd("startinsert")
end
local function vsplit_term()
  local size = math.floor(vim.o.columns * 0.4)
  vim.cmd("vsplit | vertical resize " .. size .. " | terminal")
  vim.cmd("startinsert")
end
vim.keymap.set("n", "<leader>-", hsplit_term, { desc = "Terminal split below" })
vim.keymap.set("n", "<leader>|", vsplit_term, { desc = "Terminal split right" })

-- Stay in visual mode after indent
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and stay in visual" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and stay in visual" })

-- Buffer management
vim.keymap.set("n", "<S-h>",      "<cmd>bprevious<cr>",  { desc = "Prev buffer" })
vim.keymap.set("n", "<S-l>",      "<cmd>bnext<cr>",      { desc = "Next buffer" })
vim.keymap.set("n", "[b",         "<cmd>bprevious<cr>",  { desc = "Prev buffer" })
vim.keymap.set("n", "]b",         "<cmd>bnext<cr>",      { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bb", "<cmd>e #<cr>",        { desc = "Switch to other buffer" })
vim.keymap.set("n", "<leader>bv", "<cmd>vnew<cr>",       { desc = "New vertical split buffer" })
vim.keymap.set("n", "<leader>bh", "<cmd>new<cr>",        { desc = "New horizontal split buffer" })


-- Copy file paths
vim.keymap.set("n", "<leader>cpa", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  vim.notify("Copied: " .. path)
end, { desc = "Copy absolute path" })
vim.keymap.set("n", "<leader>cpr", function()
  local path = vim.fn.expand("%:.")
  vim.fn.setreg("+", path)
  vim.notify("Copied: " .. path)
end, { desc = "Copy relative path" })
vim.keymap.set("n", "<leader>cpg", function()
  local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
  local path
  if vim.v.shell_error == 0 then
    path = vim.fn.expand("%:p"):sub(#git_root + 2)
  else
    path = vim.fn.expand("%:.")
  end
  vim.fn.setreg("+", path)
  vim.notify("Copied: " .. path)
end, { desc = "Copy git-relative path" })

-- UI toggles
vim.keymap.set("n", "<leader>uh", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "Toggle inlay hints" })
vim.keymap.set("n", "<leader>uw", function()
  vim.wo.wrap = not vim.wo.wrap
  vim.notify("Wrap: " .. tostring(vim.wo.wrap))
end, { desc = "Toggle wrap" })
vim.keymap.set("n", "<leader>us", function()
  vim.wo.spell = not vim.wo.spell
  vim.notify("Spell: " .. tostring(vim.wo.spell))
end, { desc = "Toggle spell" })
vim.keymap.set("n", "<leader>ul", function()
  vim.wo.number = not vim.wo.number
  vim.notify("Line numbers: " .. tostring(vim.wo.number))
end, { desc = "Toggle line numbers" })
vim.keymap.set("n", "<leader>uN", function()
  vim.wo.relativenumber = not vim.wo.relativenumber
  vim.notify("Relative numbers: " .. tostring(vim.wo.relativenumber))
end, { desc = "Toggle relative numbers" })
vim.keymap.set("n", "<leader>uc", function()
  vim.wo.cursorline = not vim.wo.cursorline
  vim.notify("Cursorline: " .. tostring(vim.wo.cursorline))
end, { desc = "Toggle cursorline" })

-- Better search: clear highlight with Escape
vim.keymap.set("n", "<Esc>", "<cmd>noh<cr><Esc>", { desc = "Clear search highlight" })

-- Disable arrow keys
for _, key in ipairs({ "<Up>", "<Down>", "<Left>", "<Right>" }) do
  for _, mode in ipairs({ "n", "i", "v", "c", "o", "x", "s" }) do
    vim.keymap.set(mode, key, "<Nop>", { noremap = true })
  end
end

-- Terminal mode escape
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set("t", "jk", "<C-\\><C-n>", { desc = "Exit terminal mode (jk)" })

-- Diagnostics
vim.diagnostic.config({
  underline = true,
  virtual_text = {
    spacing = 4,
    prefix = "●",
    format = function(diagnostic)
      local lines = vim.split(diagnostic.message, "\n")
      return lines[1]
    end,
  },
  signs = true,
  severity_sort = true,
  float = {
    border = "rounded",
    source = true,
    header = "",
    prefix = "",
  },
})

-- Show diagnostics under cursor
vim.keymap.set("n", "<leader>df", function()
  vim.diagnostic.open_float({ scope = "cursor" })
end, { desc = "Show diagnostic float" })

-- Navigate diagnostics with auto-preview
vim.keymap.set("n", "[d", function()
  vim.diagnostic.goto_prev({ float = true })
end, { desc = "Prev diagnostic" })
vim.keymap.set("n", "]d", function()
  vim.diagnostic.goto_next({ float = true })
end, { desc = "Next diagnostic" })

-- Plugins
require("lazy").setup("plugins", {
  change_detection = { notify = false },
})
