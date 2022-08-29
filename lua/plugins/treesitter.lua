local ts_configs = require 'nvim-treesitter.configs'
local ts_parsers = require 'nvim-treesitter.parsers'

ts_configs.setup {
  ensure_installed = {
    'javascript',
    'typescript',
    'tsx',
    'vue',
    'python',
    'dart',
    'go',
    'rust',
    'bash',
    'lua',
    'html',
    'css',
    'scss',
    'json',
    'yaml',
    'toml'
  },
  highlight = {
    enable = true
  },
  indent = {
    enable = true
  },
  context_commentstring = {
    enable = true
  },
  autotag = {
    enable = true
  },
  matchup = {
    enable = true
  },
  rainbow = {
    enable = true,
    extended_mode = false
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['aC'] = '@class.outer',
        ['iC'] = '@class.inner',
        ['ac'] = '@call.outer',
        ['ic'] = '@call.inner'
      }
    }
  }
}
require 'nvim-autopairs'.setup {
  check_ts = true
}
require 'Comment'.setup {
  pre_hook = function(ctx)
    -- Only calculate commentstring for tsx filetypes
    if vim.bo.filetype == 'typescriptreact' then
      local U = require 'Comment.utils'

      -- Determine whether to use linewise or blockwise commentstring
      local type = ctx.ctype == U.ctype.linewise and '__default' or '__multiline'

      -- Determine the location where to calculate commentstring from
      local location = nil
      if ctx.ctype == U.ctype.blockwise then
        location = require 'ts_context_commentstring.utils'.get_cursor_location()
      elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
        location = require 'ts_context_commentstring.utils'.get_visual_start_location()
      end

      return require 'ts_context_commentstring.internal'.calculate_commentstring {
        key = type,
        location = location
      }
    end
  end
}

vim.api.nvim_create_autocmd({ 'TextChanged', 'TextChangedI' }, {
  pattern = '*',
  callback = function()
    local lang = ts_parsers.ft_to_lang(vim.bo.filetype)
    local parser = ts_parsers.get_parser(vim.fn.bufnr(), lang)
    if parser then
      parser:parse()
    end
  end
})
