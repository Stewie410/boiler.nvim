---@class boiler.Picker
local M = {}

function M.check()
  return vim.ui.select ~= nil
end

function M.pick(items)
  vim.ui.select(items, {
    prompt = "boiler.nvim",
    kind = "boiler.Picker",
  }, require("boiler.util").on_choice)
end

return M
