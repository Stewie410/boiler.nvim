---@class boiler.picker.Vim
local M = {}

---Pick boilerplate
---@param items table<string, string[]> templates to choose from
---@param callback fun(choice: string) on_choice action
function M.pick(items, callback)
  local opts = vim.iter(vim.tbl_values(items))
      :flatten()
      :totable()

  vim.ui.select(opts, {
    prompt = "boiler.nvim",
    kind = "boiler.picker.Vim",
  }, callback)
end

return M
