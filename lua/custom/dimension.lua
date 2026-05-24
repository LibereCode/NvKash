return function(x, y)
  x = x or 0.8
  y = y or x
  local conf = {
    relative = "editor",
    width = math.floor(vim.o.columns * x),
    height = math.floor(vim.o.lines * y),
    col = math.floor(vim.o.columns * ((1 - x) / 2)),
    row = math.floor(vim.o.lines * ((1 - y) / 2)),
    style = "minimal",
    border = "rounded",
  }
  return conf
end
