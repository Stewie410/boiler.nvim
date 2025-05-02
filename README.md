# boiler.nvim

Minimal boilerplate templating

## 📦 Setup

### ⚠️ Requirements

- Neovim 0.10+ (`vim.iter()`)
- [Grub4K/glob.nvim](https://github.com/Grub4K/glob.nvim)
- Optional
  - [folke/snacks.nvim](https://github.com/folke/snacks.nvim)

### 💤 lazy.nvim

```lua
{
  "Stewie410/boiler.nvim",
  dependencies = {
    "Grub4K/glob.nvim",
    -- Optional picker with preview
    "folke/snacks.nvim",
  },
  opts = {},
}
```

## 🚀 Usage

### Configuration

```lua
---@alias boiler.config.Picker "snacks"|"vim"|nil support picker types

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

- `Boiler`: Find and insert boilerplate into current buffer, filtered by `vim.bo.filetype`
- `BoilerAll`: Find and insert boilerplate into current buffer, unfiltered

### Help

Run `:help boiler` for more details

### ✅ To-Do

- [ ] Auto-insert if only a single item available
  - [ ] Config option to toggle this behavior
- [ ] Graceful fallback to `vim.ui.select` if Snacks unavailable
