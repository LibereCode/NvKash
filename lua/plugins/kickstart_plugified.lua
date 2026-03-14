-- HACK: Showcase that you can do settings for a plug on multiple places
return {
  { -- Main config in "kickstart.plugins.neo-tree"
    'nvim-neo-tree/neo-tree.nvim',
    keys = {
      { '<leader>e', ':Neotree toggle<CR>', desc = 'NeoTree toggle', silent = true },
      { '<C-e>', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
    },
  },
}
