# Dotfiles

Personal configuration files managed with [chezmoi](https://www.chezmoi.io/).

## Contents

- `.config/nvim/` - Neovim configuration (Lua-based, lazy.nvim)
- `.gitconfig` - Git configuration

## Setup on a new machine

```bash
# Install chezmoi and apply dotfiles in one step
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply git@github.com:bmw99x/dotfiles.git
```

Or manually:

```bash
brew install chezmoi
chezmoi init git@github.com:bmw99x/dotfiles.git
chezmoi apply
```

## Neovim

Requirements:
- Neovim 0.11+
- Git
- A Nerd Font (for icons)
- `uv` (for Python tooling via uv.nvim)

### LSP

Python:
- `basedpyright` - imports/completions (no diagnostics)
- `ruff` - linting + formatting (auto-format on save)
- `ty` - type checking only

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
- **glance.nvim** - LSP peek (definitions, references)
- **nvim-dap** - Debugging (Python via debugpy)
- **themery.nvim** - Theme switcher
- **which-key.nvim** - Keybinding help

### Keymaps

Press `<leader>` (space) to see all keymaps via which-key.

Common:
- `<leader>ff` - Find files
- `<leader>sg` - Grep
- `<leader>gg` - Lazygit
- `gD` - Glance definitions
- `<leader>dd` - Diagnostics (Trouble)
- `<leader>db` - Debug breakpoint

## chezmoi source layout

chezmoi uses a `dot_` prefix convention in this repo:

| Repo path | Destination |
|---|---|
| `dot_config/nvim/` | `~/.config/nvim/` |
| `dot_gitconfig` | `~/.gitconfig` |
| `dot_config/nvim/lua/plugins/ai.lua.tmpl` | `~/.config/nvim/lua/plugins/ai.lua` (templated) |
