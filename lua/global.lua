_G.is_windows = vim.loop.os_uname().version:match 'Windows'
_G.path_separator = is_windows and '\\' or '/'
_G.diagnostic_icons = {
  Error = ' ',
  Warn = ' ',
  Hint = ' ',
  Info = ' '
}
_G.popup_filetypes = {
  'TelescopePrompt',
  'lsp-installer',
  'lspinfo',
  'null-ls-info',
  'DressingInput'
}
