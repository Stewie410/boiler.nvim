# boiler.nvim

Minimal boilerplate templating

## 📦 Setup

### ⚠️ Requirements

- Neovim 0.10+ (`vim.iter()`)
- [Grub4K/glib.nvim](https://github.com/Grub4K/glib.nvim)
- Optional Pickers:
  - [folke/snacks.nvim](https://github.com/folke/snacks.nvim)
  - [echasnovski/mini.pick](https://github.com/echasnovski/mini.pick)

### 💤 lazy.nvim

```lua
{
  "Stewie410/boiler.nvim",
  dependencies = {
    "Grub4K/glib.nvim",
    -- Optional picker with preview
    "folke/snacks.nvim",
    "echasnovski/mini.pick",
  },
  opts = {},
}
```

## 🚀 Usage

### Configuration

```lua
---@alias boiler.config.Picker "snacks"|"mini"|"vim" support picker types

---@class boiler.Config
---@field picker? boiler.config.Picker picker preference
---@field paths? string[] paths to search for boilerplate templates
```

```lua
require("boiler").setup({
  picker = "vim", -- use vim.ui.select for picker
  paths = {
    vim.fn.stdpath("config") .. "/boilerplate", -- ~/.config/nvim/boilerplate
    vim.fn.stdpath("data") .. "/boilerplate", -- ~/.local/share/nvim/boilerplate
  },
})
```

### Commands

- `Boiler [filetype]`: Find and insert boilerplate into current buffer
  - If `filetype` not specified, use `vim.bo.filetype`
- `BoilerAll`: Find and insert boilerplate into current buffer, unfiltered

### Keymap

`boiler.nvim` does not add any keymaps by default, however `boiler.pick()` can
be called directly after setup.  For example:

```lua
vim.keymap.set("n", "<leader>bp", function()
  require("boiler").pick(vim.bo.filetype)
end, { desc = "Boiler: Select by Filetype" })

vim.keymap.set("n", "<leader>bpa", function()
  require("boiler").pick()
end, { desc = "Boiler: Select Any" })
```

### Help

Run `:help boiler` for more details

### ✅ To-Do

- More pickers?
  - Telescope
  - fzf-lua
  - PickMe (as a wrapper?)
