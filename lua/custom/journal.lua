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

-- INFO: Old and replaced
--
-- local M = {}
--
-- function M.toggle() -- INFO require('custom.journal').toggle
--    if jrnl_win and vim.api.nvim_win_is_valid(jrnl_win) then -- Hide if visible
--       vim.api.nvim_win_close(jrnl_win, true)
--       jrnl_win = nil
--       return -- XXX enables toggle?
--    end
--
--    if not jrnl_buf or not vim.api.nvim_buf_is_valid(jrnl_buf) then -- Create buffer if missing
--       jrnl_buf = jrnl() -- INFO lua is cool that way (will run `jrnl()`, and get the value of the `return jrnl_bufnr`)
--    end
--
--    jrnl_win = vim.api.nvim_open_win(jrnl_buf, true, { -- Open floating window
--       relative = 'editor',
--       width = math.floor(vim.o.columns * 0.9),
--       height = math.floor(vim.o.lines * 0.9),
--       col = math.floor(vim.o.columns * 0.05),
--       row = math.floor(vim.o.lines * 0.05),
--       border = 'rounded',
--    })
-- end
--
-- return M
--
-- Open the file in the current buffer
-- vim.cmd('edit ' .. vim.fn.fnameescape(target_file)) -- fnameescape generates \ for 'bad' filename char (ex: %+ $ -> \%\+\ \$)
-- return jrnl_bufnr
-----
-- if not jrnl_buf or not vim.api.nvim_buf_is_valid(jrnl_buf) then -- Create buffer if missing
--    jrnl() -- fn jrnl() called here
--    jrnl_buf = vim.api.nvim_get_current_buf()
-- end
--
--
-- Calculate target file path
-- local Y_m = os.date '%Y/%m/'
-- local d_md = os.date '%d.md'
-- local target_dir = vim.fn.expand('$HOME/Notes/Journal/' .. Y_m)
-- local target_file = target_dir .. d_md -- v1
-----
-- Create file with header if it doesn't exist
-- if vim.fn.filereadable(target_file) == 0 then
-- local header = '# ' .. os.date '%F' .. '\n'
-- vim.fn.writefile({ header }, target_file) -- v1
-- vim.fn.writefile({ os.date '# %F\n' }, target_file) -- v2
-- end
-----
-- Append new entry
-- local entry = '\n## ' .. os.date '%X' .. '\n\n'
-- vim.fn.writefile({ entry }, target_file, 'a') -- v1
-- vim.fn.writefile({ os.date '\n## %X\n\n' }, target_file, 'a') -- v2
--
--
-- -- version 0.1
-- local M = {}
-- local jrnl_buf = nil
-- local jrnl_win = nil
--
-- function M.toggle()
--    -- Hide if visible
--    if jrnl_win and vim.api.nvim_win_is_valid(jrnl_win) then
--       vim.api.nvim_win_close(jrnl_win, true)
--       jrnl_win = nil
--       return
--    end
--
--    -- -- Create fresh buffer
--    -- jrnl_buf = vim.api.nvim_create_buf(false, true)
--    --
--    -- Create buffer if missing
--    if not jrnl_buf or not vim.api.nvim_buf_is_valid(jrnl_buf) then jrnl_buf = vim.api.nvim_create_buf(false, true) end
--
--    -- Open floating window
--    jrnl_win = vim.api.nvim_open_win(jrnl_buf, true, {
--       relative = 'editor',
--       width = math.floor(vim.o.columns * 0.9),
--       height = math.floor(vim.o.lines * 0.9),
--       row = math.floor(vim.o.lines * 0.05),
--       col = math.floor(vim.o.columns * 0.05),
--       border = 'rounded',
--    })
--
--    -- Check if terminal buffer exists and is valid -- NOTE: improved/simplyfied with `mistral.ai`
--    local chan = vim.b[jrnl_buf] and vim.b[jrnl_buf].terminal_job_id
--    if chan then
--       -- Focus existing terminal
--       vim.fn.bufwinid(jrnl_buf)
--       -- Enter terminal mode
--       vim.cmd 'startinsert'
--       -- Send Enter to fix UI
--       vim.schedule(function() vim.api.nvim_chan_send(chan, '\n') end) -- \n vs \r ? -- NOTE: clears term each entry after the first
--    else
--       -- Open new terminal
--       vim.cmd 'terminal journal'
--       -- Enter terminal mode
--       vim.cmd 'startinsert'
--    end
-- end
-- return M
--
-- TODO be like `./toggle_term.lua` instead of closing
-- if jrnl_win and vim.api.nvim_win_is_valid(jrnl_win) then
--    vim.api.nvim_win_close(jrnl_win, true)
--    if jrnl_buf and vim.api.nvim_buf_is_valid(jrnl_buf) then vim.api.nvim_buf_delete(jrnl_buf, { force = true }) end
--    jrnl_win = nil
--    jrnl_buf = nil
--    return
-- end
--
-- -- Run `~/.local/scripts/journal` directly in the terminal buffer
-- vim.cmd 'terminal journal'
-- -- vim.cmd 'startinsert'
