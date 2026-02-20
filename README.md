# Dotfiles

Personal configuration files for development environment.

## Contents

- `.config/nvim2/` - Neovim configuration (Lua-based)
- `.gitconfig` - Git configuration

## Neovim Setup

Requirements:
- Neovim 0.11+
- Git
- A Nerd Font (for icons)

### Install

```bash
# Clone this repo
git clone https://github.com/bmw99x/dotfiles.git

# Symlink nvim config
ln -s $(pwd)/dotfiles/.config/nvim2 ~/.config/nvim2

# Install plugins (auto-installs on first launch)
nvim
```

### LSP Setup

Python:
- `basedpyright` - imports/auto-import
- `ruff` - linting + formatting (auto-format on save)
- `ty` - type checking

TypeScript/JavaScript:
- `vtsls` - completions, go-to-def, hover
- `eslint` - linting (auto-fix on save)

CSS:
- `cssls` - completions
- `cssmodules_ls` - CSS modules go-to-def

### Key Plugins

- **snacks.nvim** - Picker, notifier, terminal, lazygit
- **nvim-cmp** - Autocompletion with LSP
- **nvim-treesitter** - Syntax highlighting
- **trouble.nvim** - Diagnostics list
- **glance.nvim** - LSP preview
- **nvim-dap** - Debugging (Python via debugpy)
- **themery.nvim** - Theme switcher
- **which-key.nvim** - Keybinding help

### Keymaps

See which-key by pressing `<leader>` (space).

Common:
- `<leader>ff` - Find files
- `<leader>sg` - Grep
- `<leader>gg` - Lazygit
- `gd` - Glance definitions
- `<leader>dd` - Diagnostics
- `<leader>db` - Debug breakpoint
