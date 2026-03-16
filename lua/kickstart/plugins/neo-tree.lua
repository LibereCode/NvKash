-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

-- INFO: modified in `plugins.kickstart_plugified`

---@module 'lazy'
---@type LazySpec
return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  lazy = false,
  keys = {
    -- { '<leader>e', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true }, -- HACK:
  },
  ---@module 'neo-tree'
  ---@type neotree.Config
  opts = {
    filesystem = {
      window = {
        mappings = {
          -- ['\\'] = 'close_window',   -- HACK:
          -- ['<leader>e'] = 'close_window',
          ['<C-e>'] = 'close_window',
          ['q'] = 'close_window',
          ['l'] = 'open',
          ['h'] = 'close_node',
          ['L'] = 'set_root',
          ['H'] = 'navigate_up',
          ['.'] = 'toggle_hidden',
        },
      },
    },
  },
}
