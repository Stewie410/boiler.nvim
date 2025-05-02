---@class Boiler
local M = {}

local util = require("boiler.util")
local picker = require("boiler.picker")

---Pick boilerplate template
---@param filetype? string filter items by filetype + generics
function M.pick(filetype)
  local items = util.find_templates(M.config.paths)
  if M.config.picker == "snacks" then
    picker.snacks(items, filetype)
  else
    picker.select(items, filetype)
  end
end

---Plugin Setup
---@param opts? boiler.Config
function M.setup(opts)
  require("boiler.config").setup(opts)
  M.config = require("boiler.config").config

  vim.api.nvim_create_user_command("Boiler", function()
    M.pick(vim.bo.filetype)
  end, { desc = "Boiler: Select Boilerplate (FT)" })

  vim.api.nvim_create_user_command("BoilerAll", function()
    M.pick()
  end, { desc = "Boiler: Select Boilerplate (All)" })
end

return M
