---@class boiler.Picker
local M = {}

function M.check()
  local ok, _ = pcall(require, "mini.pick")
  return ok
end

function M.pick(items)
  require("mini.pick").start({
    source = {
      items = items,
      name = "boiler.nvim",
      choose = vim.schedule_wrap(require("boiler.util").on_choice),
    },
  })
end

return M
