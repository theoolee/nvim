require 'nvim-tree'.setup {
  auto_reload_on_write = false,
  disable_netrw = true,
  hijack_cursor = true,
  hijack_netrw = true,
  hijack_unnamed_buffer_when_opening = true,
  update_cwd = true,
  filesystem_watchers = {
    enable = true,
    interval = 1000
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    icons = {
      hint = diagnostic_icons.Hint,
      info = diagnostic_icons.Info,
      warning = diagnostic_icons.Warn,
      error = diagnostic_icons.Error
    }
  },
  git = {
    ignore = false
  },
  view = {
    width = 40,
    hide_root_folder = true,
    mappings = {
      list = {
        { key = { 'l', '<cr>', 'o' }, action = 'edit' },
        { key = 'h', action = 'close_node' },
        { key = 'u', action = 'dir_up' },
        { key = '-', action = '', },
        { key = '+', action = '', },
        { key = '<', action = '', },
        { key = '>', action = '', },
        {
          key = '<c-t>',
          action = 'open_in_term',
          action_cb = function(node)
            require 'plugins.toggleterm'.new_term(node.absolute_path)
          end
        }
      }
    }
  },
  renderer = {
    highlight_git = true,
    indent_markers = {
      enable = true
    },
    icons = {
      git_placement = 'after',
      glyphs = {
        git = {
          unstaged = 'M',
          staged = 'A',
          unmerged = 'U',
          renamed = 'R',
          deleted = 'D',
          untracked = '?',
          ignored = '!'
        }
      }
    },
    special_files = { 'package.json', 'Cargo.toml', 'Makefile', 'README.md', 'readme.md' }
  },
  actions = {
    change_dir = {
      enable = true,
      global = true
    }
  },
  update_focused_file = {
    enable = true
  }
}
