-- LazyGit💤

-- version 3.4 -- HACK: ClankerGPT is fucking retarded
local M = {}
local lg_buf = nil
local lg_win = nil

function M.toggle()
   -- Close window and buffer if window exists
   if lg_win and vim.api.nvim_win_is_valid(lg_win) then -- is really both statements needed?
      vim.api.nvim_win_close(lg_win, true)
      if lg_buf and vim.api.nvim_buf_is_valid(lg_buf) then vim.api.nvim_buf_delete(lg_buf, { force = true }) end
      lg_win = nil
      lg_buf = nil
      return -- XXX: enable toggle?
   end

   if not lg_buf or not vim.api.nvim_buf_is_valid(lg_buf) then -- if no lg_buf (always true) then
      lg_buf = vim.api.nvim_create_buf(false, true) -- NOTE: Create fresh (unlisted, scratch) buffer and return bufnr
   end

   lg_win = vim.api.nvim_open_win(lg_buf, true, { -- Open floating window
      relative = 'editor',
      width = math.floor(vim.o.columns * 0.9),
      height = math.floor(vim.o.lines * 0.9),
      row = math.floor(vim.o.lines * 0.05),
      col = math.floor(vim.o.columns * 0.05),
      border = 'rounded',
   })

   -- Run lazygit directly in the terminal buffer
   vim.cmd 'terminal lazygit'
   vim.cmd 'startinsert'
end

return M
