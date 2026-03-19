-- clankerGPT floating terminal

-- idea from (goat) TJ https://inv.nadeko.net/watch?v=5PIiKDES_wc

-- FIX: (and simplify) vert/hori terminal (they are broken)
-- see below

-- expanded
local M = {}
-- Global state for reuse
local term_buf = nil
local term_win = nil

-- Base toggle function
-- layout_fn: a function that returns {width, height, row, col, border}
local function toggle_term(layout_fn)
   -- Hide if visible
   if term_win and vim.api.nvim_win_is_valid(term_win) then
      vim.api.nvim_win_close(term_win, true)
      term_win = nil
      return -- XXX: for some reason, this enables toggle
   end

   -- Create buffer if missing
   if not term_buf or not vim.api.nvim_buf_is_valid(term_buf) then term_buf = vim.api.nvim_create_buf(false, true) end

   -- Get layout details
   local layout = layout_fn()
   term_win = vim.api.nvim_open_win(term_buf, true, layout)

   -- Check if terminal buffer exists and is valid -- NOTE: improved/simplyfied with `mistral.ai`
   local chan = vim.b[term_buf] and vim.b[term_buf].terminal_job_id
   if chan then
      -- Focus existing terminal
      vim.fn.bufwinid(term_buf)
      -- Enter terminal mode
      vim.cmd 'startinsert'
   else
      -- Open new terminal
      vim.cmd 'terminal'
      -- Enter terminal mode
      vim.cmd 'startinsert'
   end
end

-- Layout: floating terminal (centered)
function M.float()
   toggle_term(function()
      local width = math.floor(vim.o.columns * 0.8)
      local height = math.floor(vim.o.lines * 0.8)
      local row = math.floor((vim.o.lines - height) / 2)
      local col = math.floor((vim.o.columns - width) / 2)
      return {
         relative = 'laststatus', -- 'editor', -- maybe better?
         width = math.floor(vim.o.columns * 0.8),
         height = math.floor(vim.o.lines * 0.8),
         col = math.floor(vim.o.columns * 0.1),
         row = math.floor(vim.o.lines * 0.1),
         border = 'rounded',
      }
   end)
end

-- FIXME: Below are trash: doesn't allow to use < C-hjkl > to refocus the window

-- -- Layout: horizontal terminal (bottom)
-- function M.horiz()
--   toggle_term(function()
--     local height = math.floor(vim.o.lines * 0.25)
--     local width = vim.o.columns
--     local row = vim.o.lines - height
--     local col = 0
--     return {
--       relative = 'editor',
--       width = width,
--       height = height,
--       row = row,
--       col = col,
--       border = 'rounded', -- 'none'
--     }
--   end)
-- end
--
-- -- Layout: vertical terminal (right)
-- function M.verti()
--   toggle_term(function()
--     local width = math.floor(vim.o.columns * 0.25)
--     local height = vim.o.lines
--     local row = 0
--     local col = vim.o.columns - width
--     return {
--       relative = 'editor',
--       width = width,
--       height = height,
--       row = row,
--       col = col,
--       border = 'rounded', -- 'none'
--     }
--   end)
-- end

return M

-- XXX: Old (and replaced)
--
--
-- if chan then
--    -- Focus existing terminal
--    vim.fn.bufwinid(term_buf)
--    -- Enter terminal mode
--    vim.cmd 'startinsert'
--    -- Send Enter to fix UI
--    vim.schedule(function() vim.api.nvim_chan_send(chan, '\n') end) -- \n vs \r ? -- NOTE clears term each entry after the first
-- else
--
-- -- CHANGED TO: local chan .... \n if chan then \n .... (removed vim.bo[term_buf]...)
-- -- Start terminal if not already
-- if vim.bo[term_buf].buftype ~= 'terminal' then -- INFO if the buftype of the buffer with buff_id of the terminal buffer watches 'terminal', then -- 100% understandable, makes sense
--    vim.cmd 'terminal'
--    -- Enter terminal mode
--    vim.cmd 'startinsert'
-- else
--    -- Enter terminal mode
--    vim.cmd 'startinsert'
--    -- send Enter to fix buffy ui -- version 2
--    vim.schedule(function()
--       local chan = vim.b[term_buf].terminal_job_id
--       if chan then vim.api.nvim_chan_send(chan, '\n') end -- NOTE clears term each entry after the first
--    end)
-- end
