-- LazyGit💤

-- version 2.0

local state = {
  floating = {
    buf = -1,
    win = -1,
  },
}

local toggle_lazygit = function()
  if vim.api.nvim_win_is_valid(state.floating.win) then -- if visible
    vim.api.nvim_win_hide(state.floating.win) -- hide
  else
    state.floating = require('custom.toggle_float').toggle_float { x = 0.8, y = 0.8, buf = state.floating.buf } -- tells it to use the same buffer
    if vim.bo[state.floating.buf].buftype ~= 'terminal' then -- if buftype isn't terminal
      vim.cmd.terminal 'lazygit' -- enter terminal
    end
  end
  vim.cmd 'startinsert'
end

vim.api.nvim_create_user_command('Lazygit', toggle_lazygit, {})
vim.keymap.set({ 'n', 't' }, '<leader>lg', '<CMD>Lazygit<CR>')
vim.keymap.set({ 'n', 't' }, '<leader>gg', '<CMD>Lazygit<CR>')

-- vim.keymap.set({ 'n', 't' }, '<leader>lg', function() require('custom.lazygit').toggle() end, { desc = 'LazyGit' })
-- vim.keymap.set({ 'n', 't' }, '<leader>gg', function() require('custom.lazygit').toggle() end, { desc = 'LazyGit' })

-- -- version 1.23 -- ClankerGPT is fucking retarded
-- local M = {}
-- local buf_lg = nil
-- local win_lg = nil
--
-- function M.toggle() -- Close window and buffer if window exists if win_lg and vim.api.nvim_win_is_valid(win_lg) then -- is really both statements needed?
--       vim.api.nvim_win_close(win_lg, true)
--       if buf_lg and vim.api.nvim_buf_is_valid(buf_lg) then vim.api.nvim_buf_delete(buf_lg, { force = true }) end
--       win_lg = nil
--       buf_lg = nil
--       return -- XXX: enables toggle?
--    end
--
--    if not buf_lg or not vim.api.nvim_buf_is_valid(buf_lg) then -- if no lg_buf (always true) then
--       buf_lg = vim.api.nvim_create_buf(false, true) -- NOTE: Create fresh (unlisted, scratch) buffer and return bufnr
--    end
--
--    win_lg = vim.api.nvim_open_win(buf_lg, true, require 'custom.dimension'(0.9)) -- Open floating window
--
--    vim.cmd 'terminal lazygit' -- Run lazygit in terminal buf
--    vim.cmd 'startinsert'
-- end
--
-- return M
