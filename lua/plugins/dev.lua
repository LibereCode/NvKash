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
      local map, tTerm = vim.keymap.set, require 'toggleTerm'
      local togterm = tTerm.new()

      map({ 'n', 't' }, '<M-t>', function() togterm:toggle_float { border = 'double' } end, { desc = 'toggleTerm' })
      map({ 'n', 't' }, '<leader>tt', function() togterm:toggle_float { x = 0.95, y = 0.95 } end, { desc = 'larger Term' })
      map({ 'n', 't' }, '<M-/>', function() togterm:toggle_hor() end, { desc = 'larger Term' }) -- '<C-/>'
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

  -- {
  --   -- 'lazygit.nvim',
  --   dev = true,
  --   'LibereCode/lazygit.nvim',
  --   opts = {},
  -- }, -- XXX: too yanky, will use <https://github.com/kdheepak/lazygit.nvim> instead
  --        ( or improve my toggleTerm and spawn it there ... ? )

  {
    -- 'todo-sh.nvim',
    -- dev = true,
    'LibereCode/todo-sh.nvim',
    opts = {},
  },

  {
    dev = true,
    'LibereCode/printTreeTable.nvim',
    opts = {},
  },

  {
    -- dev = true,
    'LibereCode/QoL.nvim',
    opts = {},
  },
}
