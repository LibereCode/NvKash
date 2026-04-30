--  Journal 

-- Rewritten version of `~/.local/scripts/shell/journal`(.zsh) to lua

--version 2.0
-- Don't `return` no more, instead
-- instead handle commands within script

-- local M = {}
-- local buf_jrnl = require('custom.modules.window').buf
-- local win_jrnl = require('custom.modules.window').win

local state = {
  floating = {
    buffer = -1,
    window = -1,
  },
}
local sfbuf = state.floating.buffer
local sfwin = state.floating.window

local function jrnl()
  local target_dir = vim.fn.expand('$HOME/Notes/Journal/' .. os.date '%Y/%m/') -- Calculate target file path
  local target_file = target_dir .. os.date '%d.md'

  vim.fn.mkdir(target_dir, 'p') -- Create directory if it doesn't exist

  if vim.fn.filereadable(target_file) == 0 then vim.fn.writefile({ os.date '# %F', '' }, target_file) end -- Create file with header if it doesn't exist

  vim.fn.writefile({ '', os.date '## %X', '', '' }, target_file, 'a') -- Append new entry

  vim.cmd('badd ' .. vim.fn.fnameescape(target_file)) -- fnameescape generates \ for 'bad' filename char (ex: %+ $ -> \%\+\ \$)
  return vim.fn.bufnr(target_file)
end

-- function M.main()
local toggle_jrnl = function()
  if vim.api.nvim_win_is_valid(sfwin) then -- Hide if visible
    vim.api.nvim_win_close(sfwin, true)
    -- sfwin = nil -- not needed?
    return -- enables toggle... why?
  end

  if not sfbuf or not vim.api.nvim_buf_is_valid(sfbuf) then -- if no buf then
    sfbuf = jrnl()
  end

  sfwin = vim.api.nvim_open_win(sfbuf, true, require 'custom.modules.dimension'(0.9))
end

vim.api.nvim_create_user_command('Journal', toggle_jrnl, {})

-- leadmap('oj', require 'custom.journal', '[j]ournal') -prev command in `mappings.lua`
vim.keymap.set('n', '<leader>oj', '<CMD>Journal<CR>')
