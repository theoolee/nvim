local M = {}

local Terminal = require 'toggleterm.terminal'.Terminal

function M.new_term(dir)
  if dir == nil then
    dir = vim.fn.getcwd()
  end
  if dir ~= nil then
    if vim.fn.isdirectory(dir) == 0 then
      dir = dir:match('(.*' .. path_separator .. ')')
    end
    local term = Terminal:new { dir = dir }
    term:toggle()
  end
end

function M.toggle_term()
  local terms = require 'toggleterm.terminal'.get_all()
  if vim.v.count ~= 0 then
    require 'toggleterm'.toggle(vim.v.count)
  elseif #terms > 0 then
    require 'toggleterm'.toggle_all()
  else
    M.new_term()
  end
end

require 'toggleterm'.setup {
  size = function(term)
    if term.direction == 'horizontal' then
      return 15
    elseif term.direction == 'vertical' then
      return 60
    end
  end,
  direction = 'horizontal',
  highlights = {
    Normal = {
      guibg = require 'github-theme.palette.dark_default' ().bg2
    }
  },
  shade_terminals = false
}

return M
