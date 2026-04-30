-- NOTE: This plugin is for developing `plugins.nvim`
-- Especially `lazy.nvim` compatible plugins
-- Use lazy.nvim spec `path` or `dev` for the plugins.
-- https://lazy.folke.io/spec

-- NOW THEY ARE REAL PLUGINS !!

return {
  {
    --   'toggleTerm.nvim',
    --   dev = true,
    'LibereCode/toggleTerm.nvim', -- TEST:
    --   -- config = function() require 'foobar' end, -- NOTE: option 1 (load)
  },

  {
    -- 'journal.nvim',
    -- dev = true,
    'LibereCode/journal.nvim',
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
