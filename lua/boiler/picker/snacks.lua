---@class boiler.picker.Snacks
local M = {}

local util = require("boiler.util")

---Iter:fold() impl
---@param acc table accumulator
---@param ft string filetype (key)
---@param files string[] boilerplate files
---@return table
local function format_items(acc, ft, files)
  local name = ft == "all" and "text" or ft

  for _, f in ipairs(files) do
    table.insert(acc, {
      text = f:gsub(vim.env.HOME, "~"),
      preview = {
        text = table.concat(util.read(f), "\n"),
        ft = name,
        loc = false,
      },
    })
  end

  return acc
end

---Pick boilerplate
---@param items boiler.Cache
function M.pick(items)
  local opts = vim.iter(pairs(items)):fold({}, format_items)

  require("snacks").picker.pick({
    source = "boiler.nvim",
    items = opts,
    preview = "preview",
    format = "text",
    confirm = function(picker, item)
      picker:close()
      util.insert(vim.split(item.preview.text, "\n"))
    end,
  })
end

return M
