require 'github-theme'.setup {
  colors = {
    bg_visual = '#383d45',
    border = '#4e4e4e'
  },
  theme_style = 'dark_default',
  hide_end_of_buffer = false
}

vim.highlight.create('CmpSelection', { guibg = '#163356' })
vim.highlight.create('NvimTreeGitIgnored', { guifg = '#535962' })
vim.highlight.create('NvimTreeIndentMarker', { guifg = '#262a33' })
vim.highlight.create('IndentBlanklineChar', { guifg = '#262a33' })
vim.highlight.create('IndentBlanklineContextChar', { guifg = '#383d45' })
vim.highlight.create('LspSignatureActiveParameter', { guifg = '#77acf9' })
