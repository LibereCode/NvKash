local map = vim.keymap.set

map({ 'n', 'x' }, '<localleader>r', function() vim.cmd 'source' end, { desc = 'Run Lua' })

map('n', '<localleader>h', function()
  local hword = vim.fn.expand '<cword>'
  vim.cmd('h ' .. hword)
end, { desc = 'help <cword>', remap = true })
