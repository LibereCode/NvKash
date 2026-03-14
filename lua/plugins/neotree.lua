-- Main config in "kickstart.plugins.neo-tree"
return { -- HACK: Showcase that you can do settings for a plug on multiple places
  'nvim-neo-tree/neo-tree.nvim',
  keys = {
    { '<C-e>', ':Neotree toggle<CR>', desc = 'NeoTree toggle', silent = true },
  },
}
