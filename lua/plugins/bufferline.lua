require 'bufferline'.setup {
  options = {
    offsets = {
      {
        filetype = 'NvimTree',
        text = 'Explorer',
        highlight = 'PanelHeading',
        padding = 1
      },
      {
        filetype = 'toggleterm',
        text = 'Terminal',
        highlight = 'PanelHeading',
        padding = 1
      }
    },
    diagnostics = 'nvim_lsp',
    diagnostics_indicator = function(_, _, diagnostics_dict, _)
      local s = ''
      for e, n in pairs(diagnostics_dict) do
        local sym = (e == 'error' and diagnostic_icons.Error)
            or (e == 'warning' and diagnostic_icons.Warn)
            or (e == 'hint' and diagnostic_icons.Hint)
            or (e == 'info' and diagnostic_icons.Info)
        s = s .. ' ' .. sym .. n
      end
      return s
    end,
    show_close_icon = false,
    show_buffer_close_icons = false,
    separator_style = { '', '' }
  }
}
