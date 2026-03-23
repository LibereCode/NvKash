--  Journal 

-- version 1.0
local M = {}
local buf_jrnl = require('custom.window').buf
local win_jrnl = require('custom.window').win

local function jrnl() -- INFO: Rewritten version of `~/.local/scripts/journal`(.zsh) to lua
   local target_dir = vim.fn.expand('$HOME/Notes/Journal/' .. os.date '%Y/%m/') -- Calculate target file path
   local target_file = target_dir .. os.date '%d.md'

   vim.fn.mkdir(target_dir, 'p') -- Create directory if it doesn't exist

   if vim.fn.filereadable(target_file) == 0 then vim.fn.writefile({ os.date '# %F', '' }, target_file) end -- Create file with header if it doesn't exist

   vim.fn.writefile({ '', os.date '## %X', '', '' }, target_file, 'a') -- Append new entry

   vim.cmd('badd ' .. vim.fn.fnameescape(target_file)) -- fnameescape generates \ for 'bad' filename char (ex: %+ $ -> \%\+\ \$)
   return vim.fn.bufnr(target_file)
end

function M.main()
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

return M.main
