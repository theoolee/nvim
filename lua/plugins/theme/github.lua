require 'github-theme'.setup {
  colors = {
    border = '#4e4e4e',
    bg_visual = '#383d45',
    bg_visual_selection = '#2d3139'
  },
  theme_style = 'dark_default',
  hide_end_of_buffer = false
}

vim.api.nvim_set_hl(0, 'CmpSelection', { bg = '#2d3139' })
vim.api.nvim_set_hl(0, 'Folded', { bg = '#151b21' })
vim.api.nvim_set_hl(0, 'TreesitterContext', { bg = '#151b21' })
vim.api.nvim_set_hl(0, 'NvimTreeIndentMarker', { fg = '#262a33' })
vim.api.nvim_set_hl(0, 'IndentBlanklineChar', { fg = '#262a33' })
vim.api.nvim_set_hl(0, 'LspSignatureActiveParameter', { fg = '#77acf9' })
