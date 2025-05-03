---@class boiler.picker.Mini
local M = {}

local mini = require("mini.pick")

---Pick boilerplate
---@param items table<string, string[]> available boilerplate templates
---@param callback fun(choice: string) on_choice action
function M.pick(items, callback)
  local opts = vim.iter(vim.tbl_values(items))
      :flatten()
      :totable()

  mini.start({
    source = {
      items = opts,
      name = "boiler.nvim",
      choose = vim.schedule_wrap(callback),
    },
  })
end

return M
