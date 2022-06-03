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
    enable = true
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
    local U = require 'Comment.utils'

    local location = nil
    if ctx.ctype == U.ctype.block then
      location = require 'ts_context_commentstring.utils'.get_cursor_location()
    elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
      location = require 'ts_context_commentstring.utils'.get_visual_start_location()
    end

    return require 'ts_context_commentstring.internal'.calculate_commentstring {
      key = ctx.ctype == U.ctype.line and '__default' or '__multiline',
      location = location
    }
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
