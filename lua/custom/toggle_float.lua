local M = {}

function M.toggle_float(opts)
  opts = opts or {}
  local x = opts.x or 0.9
  local y = opts.y or 0.9

  local buf = nil
  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true) -- buffer be like
  end

  local win_conf = require("custom.dimension")(x, y) -- use custom.dimension to get window stats
  local win = vim.api.nvim_open_win(buf, true, win_conf)

  return { buf = buf, win = win }
end

return M
