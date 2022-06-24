require 'plugins.lsp.null-ls'
require 'plugins.lsp.servers'
require 'plugins.lsp.cmp'
require 'luasnip.loaders.from_vscode'.lazy_load {
  paths = { vim.fn.stdpath 'data' .. '/site/pack/packer/start/friendly-snippets' }
}
require 'luasnip'.filetype_extend('typescript', { 'javascript' })
require 'luasnip'.filetype_extend('typescriptreact', { 'javascriptreact' })
-- require 'lsp_signature'.setup {
--   hint_enable = false,
--   timer_interval = 300,
--   floating_window_above_cur_line = false
-- }
require 'fidget'.setup { text = { spinner = 'dots' } }
require 'ufo'.setup()

vim.g.Illuminate_ftblacklist = vim.list_extend({ 'NvimTree', 'toggleterm' }, popup_filetypes)

vim.diagnostic.config {
  float = {
    source = 'always'
  },
  signs = true,
  underline = true,
  severity_sort = true,
  update_in_insert = true
}

for type, icon in pairs(diagnostic_icons) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
