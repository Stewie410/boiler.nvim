local M = {}

---Get path to stack item, relative to cwd
---@param stack? integer stack item (default: 2)
---@return string|nil
function M.script_path(stack)
  local ok, t = pcall(debug.getinfo, stack or 2, "S")
  return ok and t.source:sub(2) or nil
end

---Insert template content, replacing all lines
---@param lines string[] file content to insert
function M.insert(lines)
  local bufnr = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
end

---Read contents of file
---@param path string file path
---@return string[]
function M.read(path)
  assert(vim.uv.fs_stat(path), "cannot locate path: " .. path)
  local ok, f = pcall(io.lines, path)
  if not ok then
    error("boiler.util.read: failed to read file content: " .. path)
  end
  return vim.iter(f):totable()
end

---Push notification
---@param message string
---@param level? "debug"|"error"|"info"|"trace"|"warn"|nil
function M.log(message, level)
  level = (level or "info"):gsub("%l", string.upper)
  vim.notify(message, vim.log.levels[level], {
    title = "boiler.nvim",
    timeout = 3000,
  })
end

---Scan paths for template files
---@param paths string[] top-level paths to search
---@return table<string, string[]>
function M.find_templates(paths)
  local glib = require("glib")

  return vim.iter(paths):fold({}, function(acc, root)
    acc.all = acc.all or {}
    for file in glib.glob(root .. "/*") do
      table.insert(acc.all, file)
    end

    for dir in glib.glob(root .. "/*/") do
      local ft = vim.fs.basename(vim.fs.normalize(dir))
      acc[ft] = acc[ft] or {}
      for file in glib.glob(dir .. "/**/*") do
        table.insert(acc[ft], file)
      end
    end

    return acc
  end)
end

return M
