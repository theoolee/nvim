require 'plugins.theme.github'

local open_win = vim.api.nvim_open_win

vim.api.nvim_open_win = function(buf, enter, config)
  config = config or {}
  if config.border ~= nil and config.border ~= 'none' then
    config.border = 'single'
  end
  return open_win(buf, enter, config)
end

vim.api.nvim_create_autocmd('FileType', {
  pattern = vim.tbl_filter(function(x) return x ~= 'TelescopePrompt' end, popup_filetypes),
  callback = function()
    vim.api.nvim_win_set_config(0, { border = 'single' })
  end
})

vim.api.nvim_create_autocmd('TextYankPost', {
  pattern = '*',
  callback = function()
    vim.highlight.on_yank { timeout = 300 }
  end
})

local function set_titlestring()
  vim.opt.titlestring = vim.fn.getcwd():match('.*' .. path_separator .. '(.*)$')
end

set_titlestring()
vim.api.nvim_create_autocmd('DirChanged', {
  pattern = '*',
  callback = set_titlestring
})
