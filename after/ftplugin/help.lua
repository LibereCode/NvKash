local map = vim.keymap.set

-- INFO: Simply a copy of the same mapping in `lua.lua`, but put here
-- so that if you open help from a non-lua file, you still get access

map('n', '<localleader>h', function()
  local hword = vim.fn.expand '<cword>'
  vim.cmd('h ' .. hword)
end, { desc = 'help <cword>', remap = true })
