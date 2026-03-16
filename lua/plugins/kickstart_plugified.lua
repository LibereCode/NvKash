-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

---@module 'lazy'
---@type LazySpec
return { -- INFO: put modifications of the kickstart/plugins/* plugins here
  -- HACK: Showcase that you can do settings for a plug on multiple places
  --
  { -- Main config in "kickstart.plugins.neo-tree"
    'nvim-neo-tree/neo-tree.nvim',
    keys = {
      -- { '<leader>e', ':Neotree toggle<CR>', desc = 'NeoTree toggle', silent = true },
      { '<C-e>', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
    },
  },
}
