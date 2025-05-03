local M = {}

local util = require("boiler.util")

---@type boiler.Config
local default_config = {
  picker = "vim",
  paths = {
    vim.fn.stdpath("config") .. "/boilerplate",
    vim.fn.stdpath("data") .. "/boilerplate",
  },
}

---@type boiler.Config
M.config = M.config or default_config

---Merge user & default options
---@param opts? boiler.Config user options
function M.setup(opts)
  assert(vim.fn.has("nvim-0.10"), "boiler.nvim: Requires nvim 0.10+")
  M.config = vim.tbl_deep_extend("force", {}, M.config, opts or {})
  M.config.paths = vim.iter(M.config.paths)
      :map(vim.fs.normalize)
      :filter(vim.uv.fs_stat)
      :totable()
end

return M
