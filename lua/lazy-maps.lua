local map = vim.keymap.set

-- NOTE: /plugins/

-- Lazy
map('n', '<leader>ll', '<cmd>Lazy<CR>', { desc = 'Lazy󰒲 ' })
map({ 'n', 't' }, '<leader>lg', function() require('custom.lazygit').toggle() end, { desc = 'LazyGit' })
map({ 'n', 't' }, '<leader>gg', function() require('custom.lazygit').toggle() end, { desc = 'LazyGit' })

-- NOTE: NAVIGATION
--
-- Neo-tree -- see: `kickstart.plugins.neo-tree`
-- NetRw
-- map('n', '<leader>e', '<cmd>Lex<CR>', { desc = 'Toggle Left Explorer' })
-- map('n', '<leader>E', function()
--   if vim.fn.exists ':Rex' == 1 then
--     vim.cmd.Rex()
--   else
--     vim.cmd.Explore()
--   end
-- end, { desc = 'Toggle (R)[E]xplorer' })
