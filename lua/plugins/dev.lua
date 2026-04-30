-- NOTE: This plugin is for developing `plugins.nvim`
-- Especially `lazy.nvim` compatible plugins
-- Use lazy.nvim spec `path` or `dev` for the plugins.
-- https://lazy.folke.io/spec

return {
  -- {
  --   'toggleTerm.nvim',
  --   dev = true,
  --   -- config = function() require 'foobar' end, -- NOTE: option 1 (load)
  -- },
  { -- TEST:
    'LibereCode/toggleTerm.nvim',
  },

  {
    'journal.nvim',
    dev = true,
  },

  {
    'lazygit.nvim',
    dev = true,
  },

  {
    'todo-sh.nvim',
    dev = true,
  },
}
