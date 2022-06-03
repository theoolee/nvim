vim.api.nvim_create_autocmd('FileType', {
  pattern = vim.tbl_filter(function(pattern) return pattern ~= 'TelescopePrompt' end, popup_filetypes),
  callback = function()
    vim.keymap.set('n', 'q', '<cmd>close<cr>', { noremap = true, silent = true, buffer = true })
  end
})

-- Normal
vim.keymap.set({ 'n', 'v' }, '<space>', '<nop>', { noremap = true, silent = true })
vim.keymap.set({ 'n', 'v' }, '<space><space>', '<nop>', { noremap = true, silent = true })
vim.keymap.set({ 'n', 'v' }, '<space><space><space>', '<nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '

vim.keymap.set('i', 'jk', '<esc>', { noremap = true, silent = true })
vim.keymap.set('i', 'kj', '<esc>', { noremap = true, silent = true })

vim.keymap.set('v', 'p', 'pgvy', { noremap = true, silent = true })

vim.keymap.set('', '<c-h>', '<c-w>h', { noremap = true, silent = true })
vim.keymap.set('', '<c-j>', '<c-w>j', { noremap = true, silent = true })
vim.keymap.set('', '<c-k>', '<c-w>k', { noremap = true, silent = true })
vim.keymap.set('', '<c-l>', '<c-w>l', { noremap = true, silent = true })

vim.keymap.set('n', '<', '<c-w><', { noremap = true })
vim.keymap.set('n', '>', '<c-w>>', { noremap = true })
vim.keymap.set('n', '-', '<c-w>-', { noremap = true })
vim.keymap.set('n', '+', '<c-w>+', { noremap = true })

vim.keymap.set('n', '<leader>w', '<cmd>w!<cr>', { desc = 'Save' })
vim.keymap.set('n', '<leader>c', '<cmd>Bdelete!<cr>', { desc = 'Close Buffer' })
vim.keymap.set('n', '<leader>q', '<cmd>q!<cr>', { desc = 'Quit Window' })
vim.keymap.set('n', '<leader>Q', '<cmd>qa!<cr>', { desc = 'Quit All' })
vim.keymap.set('n', '<leader>h', '<cmd>nohlsearch<cr>', { desc = 'No Highlight' })

-- Hop
vim.keymap.set('n', 'f', require 'hop'.hint_char1, { desc = 'Find' })
vim.keymap.set('n', 'F', require 'hop'.hint_char1, { desc = 'Find' })
vim.keymap.set('n', 's', require 'hop'.hint_char2, { desc = 'Search' })
vim.keymap.set('n', 'S', require 'hop'.hint_char2, { desc = 'Search' })
vim.keymap.set('n', '<space><space>w', require 'hop'.hint_words, { desc = 'Word' })
vim.keymap.set('n', '<space><space>/', require 'hop'.hint_patterns, { desc = 'Pattern' })
vim.keymap.set(
  'n',
  '<space><space>j',
  function()
    require 'hop'.hint_lines { direction = require 'hop.hint'.HintDirection.AFTER_CURSOR }
  end,
  { desc = 'Line Down' }
)
vim.keymap.set(
  'n',
  '<space><space>k',
  function()
    require 'hop'.hint_lines { direction = require 'hop.hint'.HintDirection.BEFORE_CURSOR }
  end,
  { desc = 'Line Up' }
)

-- Comment
vim.keymap.set('n', '<leader>/', require 'Comment.api'.toggle_current_linewise, { desc = 'Comment Line' })
vim.keymap.set('n', '<leader>?', require 'Comment.api'.toggle_current_blockwise, { desc = 'Comment Block' })
vim.keymap.set(
  'v',
  '<leader>/',
  '<esc><cmd>lua require"Comment.api".toggle_linewise_op(vim.fn.visualmode())<cr>',
  { desc = 'Comment Line' }
)
vim.keymap.set(
  'v',
  '<leader>?',
  '<esc><cmd>lua require"Comment.api".toggle_blockwise_op(vim.fn.visualmode())<cr>',
  { desc = 'Comment Block' }
)

-- Buffer
vim.keymap.set('n', '<s-h>', '<cmd>BufferLineCyclePrev<cr>', { noremap = true, silent = true })
vim.keymap.set('n', '<s-l>', '<cmd>BufferLineCycleNext<cr>', { noremap = true, silent = true })

-- Terminal
vim.keymap.set({ '', 't' }, '<c-t>', require 'plugins.toggleterm'.toggle_term, { desc = 'Terminal' })
vim.api.nvim_create_autocmd('TermOpen', {
  pattern = 'term://*toggleterm#*',
  callback = function(arg)
    vim.opt.signcolumn = 'no'
    local opts = { noremap = true, buffer = true }
    vim.keymap.set('t', 'jk', [[<c-\><c-n>]], opts)
    vim.keymap.set('t', 'kj', [[<c-\><c-n>]], opts)
    vim.keymap.set('t', '<c-h>', [[<c-\><c-n><c-w>h]], opts)
    vim.keymap.set('t', '<c-j>', [[<c-\><c-n><c-w>j]], opts)
    vim.keymap.set('t', '<c-k>', [[<c-\><c-n><c-w>k]], opts)
    vim.keymap.set('t', '<c-l>', [[<c-\><c-n><c-w>l]], opts)
  end
})

-- Git
vim.keymap.set('n', '<leader>gg', '<cmd>LazyGit<cr>', { desc = 'LazyGit' })
vim.keymap.set('n', '<leader>gd', require 'gitsigns'.diffthis, { desc = 'Diff File' })
vim.keymap.set('n', '<leader>gp', require 'gitsigns'.preview_hunk, { desc = 'Preview Hunk' })
vim.keymap.set('n', '<leader>gj', require 'gitsigns'.next_hunk, { desc = 'Next Hunk' })
vim.keymap.set('n', '<leader>gk', require 'gitsigns'.prev_hunk, { desc = 'Previous Hunk' })

-- Explorer
vim.keymap.set(
  'n',
  '<leader>e',
  function()
    if vim.bo.filetype == 'NvimTree' then
      vim.api.nvim_command 'NvimTreeClose'
    else
      vim.api.nvim_command 'NvimTreeOpen'
    end
  end,
  { desc = 'Explorer' }
)

-- Telescope
vim.keymap.set('n', '<leader>T', '<cmd>Telescope<cr>', { desc = 'Telescope' })
vim.keymap.set('n', '<leader>t', require 'telescope'.extensions['todo-comments'].todo, { desc = 'Todo' })
vim.keymap.set('n', '<leader>f', require 'telescope.builtin'.find_files, { desc = 'Find File' })
vim.keymap.set(
  'n',
  '<leader>p',
  function() require 'telescope'.extensions.project.project { display_type = 'full' } end,
  { desc = 'Project' }
)
vim.keymap.set('n', '<leader>s', require 'telescope.builtin'.live_grep, { desc = 'Search Text' })
vim.keymap.set('n', '<leader>k', require 'telescope.builtin'.keymaps, { desc = 'Key Mapping' })
vim.keymap.set('n', '<leader>y', require 'telescope'.extensions.neoclip.default, { desc = 'Yank History' })
vim.keymap.set('n', '<leader>m', require 'telescope'.extensions.macroscope.default, { desc = 'Macro History' })

-- LSP
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover' })
vim.keymap.set({ 'n', 'v' }, '<leader>lf', function() vim.lsp.buf.format { async = true } end, { desc = 'Format' })
vim.keymap.set('n', '<leader>lj', vim.diagnostic.goto_next, { desc = 'Next Diagnostic' })
vim.keymap.set('n', '<leader>lk', vim.diagnostic.goto_prev, { desc = 'Previous Diagnostic' })
vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, { desc = 'Code Action' })
vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, { desc = 'Rename' })
vim.keymap.set('n', '<leader>ld', require 'telescope.builtin'.diagnostics, { desc = 'Diagnostics' })
vim.keymap.set('n', 'gl', vim.diagnostic.open_float, { desc = 'Line Diagnostic' })
vim.keymap.set('n', 'gd', require 'telescope.builtin'.lsp_definitions, { desc = 'Definitions' })
vim.keymap.set('n', 'gr', require 'telescope.builtin'.lsp_references, { desc = 'References' })

-- Copilot
vim.keymap.set('i', '<c-h>', '<nop>')
vim.keymap.set('i', '<c-j>', '<nop>')
vim.keymap.set('i', '<c-k>', '<nop>')
vim.keymap.set('i', '<c-l>', '<nop>')
vim.keymap.set('i', '<c-l>', [[copilot#Accept('<cr>')]], { script = true, expr = true, silent = true })
vim.g.copilot_no_tab_map = true
