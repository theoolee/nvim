require 'dressing'.setup {
  input = {
    insert_only = false,
    winblend = 0
  },
  select = {
    backend = { 'telescope' },
    get_config = function(opts)
      if opts.kind == 'codeaction' then
        return {
          telescope = require 'telescope.themes'.get_cursor()
        }
      end
    end
  }
}
