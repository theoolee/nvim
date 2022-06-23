require 'plugins.theme.github'

vim.api.nvim_create_autocmd('FileType', {
  pattern = vim.tbl_filter(function(x) return x ~= 'TelescopePrompt' end, popup_filetypes),
  callback = function()
    vim.api.nvim_win_set_config(0, { border = 'single' })
  end
})

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = 'single'
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

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
