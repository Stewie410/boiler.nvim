local M = {}

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

---Scan globs for templates matching filetype
---@param globs string[] globs to expand & search
---@param ft? string filetype string, nil to return all templates
---@return string[]
function M.find(globs, ft)
  return vim.iter(globs):fold({}, function(acc, glob)
    for _, path in ipairs(vim.fn.glob(glob, false, true)) do
      if vim.fn.isdirectory(path) == 0 then
        local pft = vim.fs.basename(vim.fs.dirname(path))
        if ft == nil or pft == ft then
          table.insert(acc, path)
        end
      end
    end
    return acc
  end)
end

---Insert choice (template) into current buffer
---@param choice? string selected item
function M.on_choice(choice)
  if choice ~= nil then
    local bufnr = vim.api.nvim_get_current_buf()
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, M.read(choice))
  end
end

return M
