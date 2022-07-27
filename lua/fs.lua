local watch_utils = require 'utils.watch'
local handle = nil
local update_id = 0

vim.api.nvim_create_user_command('CwdFileChange',
  function()
    local _update_id = update_id + 1
    if _update_id > 10000 then
      _update_id = 0
    end
    update_id = _update_id
    local timer
    timer = vim.fn.timer_start(100,
      function()
        vim.fn.timer_stop(timer)
        if _update_id == update_id then
          vim.cmd 'NvimTreeRefresh'
          local bufs = vim.api.nvim_list_bufs()
          for _, buf in ipairs(bufs) do
            vim.cmd('checktime ' .. buf)
          end
        end
      end)
  end,
  {}
)

local function callback()
  if handle then
    watch_utils.unwatch(handle)
  end
  handle = watch_utils.watch(vim.fn.getcwd(), 'CwdFileChange')
end

callback()
vim.api.nvim_create_autocmd('DirChanged', {
  pattern = '*',
  callback = callback
})
