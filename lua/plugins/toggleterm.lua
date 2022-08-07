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

require 'toggleterm'.setup {
  highlights = {
    Normal = {
      guibg = require 'github-theme.palette.dark_default' ().bg2
    }
  },
  shade_terminals = false
}

return M
