# boiler.nvim

Minimal boilerplate templating

## 📦 Setup

### ⚠️ Requirements

- Neovim 0.10+
  - `vim.iter()` support required
  - `vim.uv` support required
- Optional Pickers:
  - [folke/snacks.nvim](https://github.com/folke/snacks.nvim)
  - [nvim-mini/mini.pick](https://github.com/nvim-mini/mini.pick)

### 📦 vim.pack

```lua
vim.pack.add({
  "https://github.com/Stewie410/boiler.nvim",
  -- optional picker(s) with preview
  -- "https://github.com/folke/snacks.nvim",
  -- "https://github.com/nvim-mini/mini.pick",
})
```

## 🚀 Usage

### Keymap

`boiler.nvim` does not add any keymaps by default, however `boiler.pick()` can
be called directly after setup.  For example:

```lua
vim.keymap.set("n", "<leader>bb", function()
    require("boiler.picker.vim").pick(require("boiler.util").find({
        vim.fn.stdpath("config") .. "/boilerplate/**/*",
        vim.fn.stdpath("data") .. "/boilerplate/**/*",
    }, vim.bo.filetype))
end, { desc = "boiler.nvim: pick by ft" })

vim.keymap.set("n", "<leader>ba", function()
    require("boiler.picker.vim").pick(require("boiler.util").find({
        vim.fn.stdpath("config") .. "/boilerplate/**/*",
        vim.fn.stdpath("data") .. "/boilerplate/**/*",
    }, nil))
end, { desc = "boiler.nvim: pick by any" })
```

### Help

Run `:help boiler` for more details

### ✅ To-Do

- More pickers?
  - Telescope
  - fzf-lua
  - PickMe (as a wrapper?)
