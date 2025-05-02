---@class boiler.picker.Vim
local M = {}

local util = require("boiler.util")

---Pick boilerplate
---@param items boiler.Cache
function M.pick(items)
  local opts = vim.iter(pairs(items))
      :map(function(_, t) return t end)
      :flatten()
      :totable()

  vim.ui.select(opts, {
    prompt = "boiler.nvim",
    kind = "boiler.picker.Vim",
  }, function(choice)
    if choice == nil then return end
    util.insert(util.read(choice))
  end)
end

return M
