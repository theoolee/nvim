local colorizer = require 'colorizer'

colorizer.setup {
  ['*'] = {
    RGB = true,
    RRGGBB = true,
    names = true,
    RRGGBBAA = true,
    rgb_fn = true,
    hsl_fn = true,
    css = true,
    css_fn = true,
    mode = 'background'
  }
}

vim.api.nvim_create_autocmd({ 'TextChanged', 'TextChangedI' }, {
  pattern = '*',
  callback = colorizer.reload_all_buffers
})
