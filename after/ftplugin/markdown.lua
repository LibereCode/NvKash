local function map(keys, cmd, opts, modes)
  modes = modes or 'n'
  local options = vim.tbl_extend('error', { buf = 0 }, opts) -- INFO: peak
  vim.keymap.set(modes, keys, cmd, options)
end
local function localmap(keys, cmd, opts, modes) map('<localleader>' .. keys, cmd, opts, modes) end

-- localmap('t', 'o| h1 | h2 |<Escape>o| -- | -- |<Escape>o| i1 | i2 |<Escape>"')
localmap('c', 'o ```lua<CR>```<ESCAPE>ko', { desc = 'ins [c]odeblock' })

local ol = vim.opt_local -- local is the GOAT here

ol.wrap = true

-- Because no tags in .md, instead markdown links
map('gl', 'gx', { desc = 'Go to header/local link', remap = true }) -- remap was needed
