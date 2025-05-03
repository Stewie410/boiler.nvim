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

---@param choice? string selected item
local function on_choice(choice)
  if choice == nil then return end
  util.insert(util.read(choice))
end

---Filter boilerplate item table by filetype
---@param items table<string, string[]> boilerplate cache
---@param filetype string filetype name
function M.filter_items(items, filetype)
  return {
    [filetype] = items[filetype],
    all = items.all,
  }
end

---Pick boilerplate template
---@param items table<string, string[]> available templates
---@param preference boiler.config.Picker picker preference
---@param filetype? string
function M.pick(items, preference, filetype)
  local picker = get_picker(preference)
  if filetype then
    items = M.filter_items(items, filetype)
  end

  local all_items = vim.iter(vim.tbl_values(items)):flatten():totable()
  if #all_items < 2 then
    if #all_items == 1 then
      on_choice(all_items[1])
    else
      util.log("No boilerplate templates available", "warn")
    end
    return
  end

  picker.pick(items, on_choice)
end

return M
