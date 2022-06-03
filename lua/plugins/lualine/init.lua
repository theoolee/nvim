require 'lualine'.setup {
  options = {
    component_separators = '',
    section_separators = ''
  },
  sections = {
    lualine_x = {
      {
        require 'plugins.lualine.lsp-component',
        cond = function()
          return require 'plugins.lualine.lsp-component' () ~= nil
        end
      }
    },
    lualine_y = {
      'encoding',
      'fileformat',
      'filetype'
    },
    lualine_z = { 'location' }
  },
  extensions = {
    'nvim-tree',
    'toggleterm'
  }
}
