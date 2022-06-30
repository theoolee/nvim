require 'github-theme'.setup {
  colors = {
    border = '#4e4e4e',
    bg_visual = '#383d45',
    bg_visual_selection = '#2d3139'
  },
  theme_style = 'dark_default',
  hide_end_of_buffer = false
}

vim.highlight.create('CmpSelection', { guibg = '#2d3139' })
vim.highlight.create('NvimTreeIndentMarker', { guifg = '#262a33' })
vim.highlight.create('IndentBlanklineChar', { guifg = '#262a33' })
vim.highlight.create('IndentBlanklineContextChar', { guifg = '#383d45' })
vim.highlight.create('LspSignatureActiveParameter', { guifg = '#77acf9' })
