require 'gitsigns'.setup {
  attach_to_untracked = false,
  current_line_blame = true,
  current_line_blame_opts = {
    delay = 300
  },
  update_debounce = 300
}
