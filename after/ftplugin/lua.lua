local map = vim.keymap.set

map({ 'n', 'x' }, '<localleader>r', function() vim.cmd 'source' end, { desc = 'Run Lua' })

map('n', '<localleader>h', function()
  local hword = vim.fn.expand '<cword>'
  vim.cmd('h ' .. hword)
end, { desc = 'help <cword>', remap = true })

local o = vim.opt_local
o.softtabstop = 2 -- . :h 'sts' -- Will only be applied at config because :...
-- ... I have a ~/.config/stylua saying tab = 4, so stylua here don't apply globally
