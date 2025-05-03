---@class boiler.picker.Snacks
local M = {}

local util = require("boiler.util")
local snacks = require("snacks")

---Format available items to be consumed by Snacks.picker.pick
---@param items table<string, string[]> available boilerplate templates
---@return snacks.picker.Item[]
local function format_items(items)
  return vim.iter(pairs(items)):fold({}, function(acc, ft, files)
    ft = ft == "all" and "text" or ft

    for _, f in ipairs(files) do
      table.insert(acc, {
        text = f:gsub(vim.env.HOME, "~"),
        preview = {
          text = table.concat(util.read(f), "\n"),
          ft = ft,
          loc = false,
        },
      })
    end

    return acc
  end)
end

---Pick boilerplate
---@param items table<string, string[]> tempaltes to choose from
---@param callback fun(choice: string) on_choice action
function M.pick(items, callback)
  snacks.picker.pick({
    source = "boiler.nvim",
    items = format_items(items),
    preview = "preview",
    format = "text",
    confirm = function(picker, item)
      picker:close()
      callback(vim.fs.normalize(item.text))
    end,
  })
end

return M
