return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    -- 'nvim-mini/mini.icons', -- HACK:
    'MunifTanjim/nui.nvim',
    '3rd/image.nvim', -- See plugins.ui
  },
  lazy = false,
  keys = {
    { '<C-e>', ':Neotree float reveal_force_cwd toggle<CR>', desc = 'float N[e]oTree', silent = true },
    { '<leader>e', ':Neotree left reveal_force_cwd toggle<CR>', desc = 'left N[e]oTree', silent = true },
    -- { '<leader>E', ':Neotree current reveal_force_cwd toggle<CR>', desc = 'N[E]O-NetRC', silent = true },
  },
  ---@module 'neo-tree'
  ---@type neotree.Config
  opts = { -- https://github.com/nvim-neo-tree/neo-tree.nvim?tab=readme-ov-file#configuration
    close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
    enable_git_status = true,
    enable_diagnostics = true,
    filesystem = {
      window = {
        mappings = {
          ['<C-e>'] = 'close_window',
          ['l'] = 'open',
          ['h'] = 'close_node',
          ['L'] = 'set_root',
          ['H'] = 'navigate_up',
          ['.'] = 'toggle_hidden',
          ['q'] = 'close_window',
          ['P'] = {
            'toggle_preview',
            config = {
              use_float = false,
              -- use_snacks_image = false,
              use_image_nvim = true,
            },
          },
        },
      },
      hijack_netrw_behavior = 'disabled', -- 'disabled'|'open_default'|'open_current' -- weird ass name -- 'disabled' = allows to open yazi by default
    },
  },
}
