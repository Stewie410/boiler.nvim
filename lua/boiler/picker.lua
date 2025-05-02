---@class boiler.Picker
local M = {}

local util = require("boiler.util")

---@param items boiler.Cache
---@param filter? string
---@return Iter
local function filter_items(items, filter)
  local iter = vim.iter(pairs(items))
  if filter then
    iter:filter(function(ft, _) return ft == "all" or ft == filter end)
  end
  return iter
end

---Select boilerplate with vim.ui.select
---@param items boiler.Cache
---@param filetype? string filetype filter
function M.select(items, filetype)
  local iter = filter_items(items, filetype)
      :map(function(_, files) return files end)
      :flatten()

  vim.ui.select(iter:totable(), {
    prompt = "boiler.nvim",
    kind = "boiler.picker",
  }, function(choice)
    if choice == nil then return end
    util.insert(util.read(choice))
  end)
end

---Select boilerplate with Snacks.picker.pick
---@param items boiler.Cache
---@param filetype? string filetype filter
function M.snacks(items, filetype)
  local opts = filter_items(items, filetype):fold({}, function(acc, ft, files)
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
  end)

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
