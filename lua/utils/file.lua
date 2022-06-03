local uv = vim.loop

local M = {}

function M.exists(path)
  return uv.fs_stat(path) and true or false
end

function M.read_file(path)
  -- permissions: rrr
  local fd = assert(uv.fs_open(path, 'r', tonumber('0444', 8)))
  local stat = assert(uv.fs_fstat(fd))
  -- read from offset 0.
  local buf = assert(uv.fs_read(fd, stat.size, 0))
  uv.fs_close(fd)

  return buf
end

function M.json_decode(data)
  local status, result = pcall(vim.json.decode, data)
  if status then
    return result
  else
    return nil, result
  end
end

function M.read_json(path)
  if not M.exists(path) then
    return nil, 'File does not exist'
  end
  local data = M.read_file(path)
  return M.json_decode(data)
end

return M
