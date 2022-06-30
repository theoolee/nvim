require 'telescope'.setup {
  defaults = {
    borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
    mappings = {
      n = {
        ['q'] = 'close',
        ['<c-n>'] = 'cycle_history_next',
        ['<c-p>'] = 'cycle_history_prev'
      }
    }
  },
  extensions = {
    project = {
      base_dirs = {
        '~/code'
      }
    }
  }
}

require 'telescope'.load_extension 'project'
require 'todo-comments'.setup {
  highlight = {
    pattern = [[.*<(KEYWORDS)\s*]]
  },
  search = {
    pattern = [[\b(KEYWORDS)]]
  }
}
require 'neoclip'.setup {
  enable_persistent_history = true,
  continuous_sync = true,
  default_register = 'unnamed',
  on_paste = {
    set_reg = true
  },
  on_replay = {
    set_reg = true
  },
  keys = {
    telescope = {
      n = {
        replay = 'r'
      },
      i = {
        replay = '<c-r>'
      }
    }
  }
}
