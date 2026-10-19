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
---@param level? vim.log.levels|nil
function M.log(message, level)
  level = level == nil and vim.log.levels.INFO or level
  vim.notify(message, level, {
    title = "boiler.nvim",
    timeout = 3000,
  })
end

---Scan globs for template files
---@param globs string[] globs to expand & search
---@return table<string, string[]>
function M.glob_templates(globs)
  return vim.iter(globs):fold({}, function(acc, glob)
    acc.all = acc.all or {}

    for _, path in ipairs(vim.fn.glob(glob, false, true)) do
      if vim.fn.isdirectory(path) == 0 then
        local ft = vim.fs.basename(vim.fs.dirname(path))
        acc[ft] = acc[ft] or {}
        table.insert(acc[ft], path)
        table.insert(acc.all, path)
      end
    end

    return acc
  end)
end

return M
