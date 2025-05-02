---@class Boiler
local M = {}

local util = require("boiler.util")
local picker = require("boiler.picker")

---Pick boilerplate template
---@param filetype? string filter items by filetype + generics
function M.pick(filetype)
  local items = util.find_templates(M.config.paths)
  picker.pick(items, M.config.picker, filetype)
end

local function setup_commands()
  vim.api.nvim_create_user_command("Boiler", function(opts)
    local ft = opts.args or vim.bo.filetype
    M.pick(ft)
  end, { nargs = "?", desc = "Boiler: Select Boilerplate by filetype" })

  vim.api.nvim_create_user_command("BoilerAll", function()
    M.pick()
  end, { desc = "Boiler: Select any Boilerplate" })
end

---Plugin Setup
---@param opts? boiler.Config
function M.setup(opts)
  require("boiler.config").setup(opts)
  M.config = require("boiler.config").config

  setup_commands()
end

return M
