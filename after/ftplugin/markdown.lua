local function localmap(keys, cmd, opts, modes)
  modes = modes or 'n'
  opts = opts or {}
  vim.keymap.set(modes, '<localleader>' .. keys, cmd, opts)
end

-- localmap('t', 'o| h1 | h2 |<Escape>o| -- | -- |<Escape>o| i1 | i2 |<Escape>"')
