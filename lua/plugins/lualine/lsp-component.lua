return function()
  local ignore_list = { 'null-ls', 'gitsigns' }
  local buf_clients = vim.lsp.get_active_clients { bufnr = 0 }
  if next(buf_clients) == nil then
    return '[LS Inactive]'
  end
  local buf_ft = vim.bo.filetype
  local buf_client_names = {}

  for _, client in pairs(buf_clients) do
    if not vim.tbl_contains(ignore_list, client.name) then
      table.insert(buf_client_names, client.name)
    end
  end

  local available_source = require 'null-ls.sources'.get_available(buf_ft)
  local null_ls_names = {}

  for _, source in pairs(available_source) do
    if not vim.tbl_contains(null_ls_names, source.name) and not vim.tbl_contains(ignore_list, source.name) then
      table.insert(null_ls_names, source.name)
    end
  end

  vim.list_extend(buf_client_names, null_ls_names)

  if #buf_client_names == 0 then
    return '[LS Inactive]'
  end

  table.sort(buf_client_names)

  return table.concat(buf_client_names, ' | ')
end
