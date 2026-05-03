-- NOTE: This plugin is for developing `plugins.nvim`
-- Especially `lazy.nvim` compatible plugins
-- Use lazy.nvim spec `path` or `dev` for the plugins.
-- https://lazy.folke.io/spec

-- NOW THEY ARE REAL PLUGINS !!

return {
  {
    --   'toggleTerm.nvim',
    dev = true,
    'LibereCode/toggleTerm.nvim',
    opts = function()
      local toggle = require('toggleTerm').toggle_term
      vim.keymap.set({ 'n', 't' }, '<M-t>', function() toggle { border = 'single' } end, { desc = 'toggleTerm' })
      vim.keymap.set({ 'n', 't' }, '<leader>tt', function() toggle { border = 'shadow', x = 0.95, y = 0.95 } end, { desc = 'larger Term' })
      vim.keymap.set({ 'n', 't' }, '<C-/>', function() toggle { border = 'shadow', x = 0.95, y = 0.95 } end, { desc = 'larger Term' })
    end,
    --   -- config = function() require 'foobar' end, -- NOTE: option 1 (load)
  },

  {
    -- 'journal.nvim',
    dev = true,
    'LibereCode/journal.nvim',
    opts = function()
      local toggle = require('journal').toggle_jrnl
      vim.keymap.set('n', '<leader>oj', function() toggle { x = 0.9, border = 'double' } end, { desc = '[j]ournal' })
    end,
  },

  {
    -- 'lazygit.nvim',
    -- dev = true,
    'LibereCode/lazygit.nvim',
  },

  {
    -- 'todo-sh.nvim',
    -- dev = true,
    'LibereCode/todo-sh.nvim',
  },
}
