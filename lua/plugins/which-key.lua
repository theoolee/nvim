local which_key = require 'which-key'
local M = require 'which-key.view'
local Keys = require 'which-key.keys'
local Util = require 'which-key.util'

which_key.setup {
  key_labels = {
    ['<space>'] = 'SPC',
    ['<cr>'] = 'RET',
    ['<tab>'] = 'TAB'
  },
  window = {
    border = 'rounded'
  }
}
which_key.register({
  ['<space>'] = { name = 'Hop' },
  g = { name = 'Git' },
  l = { name = 'LSP' }
}, {
  mode = 'n',
  prefix = '<leader>',
})
which_key.register({
  l = { name = 'LSP' }
}, {
  mode = 'v',
  prefix = '<leader>',
})

local function on_keys(opts)
  local buf = vim.api.nvim_get_current_buf()

  while true do
    local results = Keys.get_mappings(M.mode, M.keys, buf)

    if results.mapping and not results.mapping.group and #results.mappings == 0 then
      if results.mapping.fn then
        results.mapping.fn()
      else
        vim.api.nvim_feedkeys(M.keys, M.mode, true)
      end
      return
    end

    if #results.mappings == 0 then
      if opts.auto then
        vim.api.nvim_feedkeys(M.keys, M.mode, true)
      end
      return
    end

    local c = M.getchar()
    M.keys = M.keys .. c
  end
end

local function open(keys, opts)
  opts = opts or {}
  M.keys = keys or ''
  M.mode = opts.mode or Util.get_mode()
  M.count = vim.api.nvim_get_vvar 'count'
  M.reg = vim.api.nvim_get_vvar 'register'
  on_keys(opts)
end

local show = which_key.show
which_key.show = function(keys, opts)
  if vim.tbl_contains(popup_filetypes, vim.bo.filetype) then
    open(keys, opts)
    return
  else
    show(keys, opts)
  end
end
