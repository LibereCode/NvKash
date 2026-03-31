--  Journal 

-- Rewritten version of `~/.local/scripts/journal`(.zsh) to lua

-- version 2.0
-- Don't `return` no more, instead
-- instead handle commands within script

-- local M = {}
local buf_jrnl = require('custom.window').buf
local win_jrnl = require('custom.window').win

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
  if win_jrnl and vim.api.nvim_win_is_valid(win_jrnl) then -- Hide if visible
    vim.api.nvim_win_close(win_jrnl, true)
    win_jrnl = nil
    return -- enables toggle... why?
  end

  if not buf_jrnl or not vim.api.nvim_buf_is_valid(buf_jrnl) then -- if no buf then
    buf_jrnl = jrnl()
  end

  win_jrnl = vim.api.nvim_open_win(buf_jrnl, true, require 'custom.dimension'(0.9))
end

vim.api.nvim_create_user_command('Journal', toggle_jrnl, {})

-- leadmap('oj', require 'custom.journal', '[j]ournal') -prev command in `mappings.lua`
vim.keymap.set('n', '<leader>oj', '<CMD>Journal<CR>')
