-- floating window, works as a component for other `custom/*.lua`

-- version 0.?

-- HACK: BRICKED. Use for reference

local M = {} -- INFO: use: `require('custom.window').main(choice, win, buf, how, x, y)`

function M.dim(x, y) -- PERF: works, use `custom.dimension` instead
  x = x or 0.8
  y = y or x
  local conf = {
    relative = 'editor',
    width = math.floor(vim.o.columns * x),
    height = math.floor(vim.o.lines * y),
    col = math.floor(vim.o.columns * ((1 - x) / 2)),
    row = math.floor(vim.o.lines * ((1 - y) / 2)),
    border = 'rounded',
  }
  return conf
end

-- BUG: = don't work

function M.open_close(win, buf) -- BUG:
  if win and vim.api.nvim_win_is_valid(win) then -- close if existing
    vim.api.nvim_win_close(win, true)
    if buf and vim.api.nvim_buf_is_valid(buf) then vim.api.nvim_buf_delete(buf, { force = true }) end
    win = nil
    buf = nil
    print 'open_close activated'
  end
end

function M.toggle(win) -- BUG:
  if win and vim.api.nvim_win_is_valid(win) then -- Hide if visible
    vim.api.nvim_win_close(win, true)
    win = nil
    print 'toggle activated'
    return -- XXX: enables toggle... why?
  end
end

function M.main(win, buf, how, x, y) -- BUG:
  if not buf or not vim.api.nvim_buf_is_valid(buf) then -- if no buf then
    buf = how -- NOTE: if specified (which function/command to use), or default:
      or vim.api.nvim_create_buf(false, true) -- Create fresh (unlisted, scratch) buffer and return bufnr
  end

  win = vim.api.nvim_open_win(buf, true, require('custom.window').dim(x, y)) -- (0.9) -- Open floating window
end

return M
