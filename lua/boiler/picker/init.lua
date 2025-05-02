local M = {}

local util = require("boiler.util")

---@param pref boiler.config.Picker
---@return table
local function get_picker(pref)
  local name = tostring(pref)
  local ok, picker = pcall(require, "boiler.picker." .. name)
  if not ok then
    util.log(name:gsub("^%l", string.upper) .. " not available, fallback to builtin", "warn")
    picker = require("boiler.picker.vim")
  end
  return picker
end

---Filter boilerplate item table by filetype
---@param items boiler.Cache boilerplate cache
---@param filetype string filetype name
function M.filter_items(items, filetype)
  return {
    [filetype] = items[filetype],
    all = items.all,
  }
end

---Pick boilerplate template
---@param items boiler.Cache available templates
---@param preference boiler.config.Picker picker preference
---@param filetype any
function M.pick(items, preference, filetype)
  local picker = get_picker(preference)
  if filetype then
    items = M.filter_items(items, filetype)
  end
  picker.pick(items)
end

return M
