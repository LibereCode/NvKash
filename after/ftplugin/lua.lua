local map = vim.keymap.set

map({ 'n', 'x' }, '<localleader>r', function() vim.cmd 'source' end, { desc = 'Run Lua' })
