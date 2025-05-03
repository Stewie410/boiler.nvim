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
        -- file = f,
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
---@param items table<string, string[]>
function M.pick(items)
  require("snacks").picker.pick({
    source = "boiler.nvim",
    items = format_items(items),
    preview = "preview",
    format = "text",
    confirm = function(picker, item)
      picker:close()
      util.insert(vim.split(item.preview.text, "\n"))
    end,
  })
end

return M
