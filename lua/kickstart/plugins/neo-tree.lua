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
      -- 'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'nvim-mini/mini.icons', -- HACK:
      'MunifTanjim/nui.nvim',
      -- '3rd/image.nvim', -- allows image view in preview
   },
   lazy = false,
   keys = {
      { '<leader>e', ':Neotree float reveal toggle<CR>', desc = 'float-N[e]oTree toggle', silent = true },
      { '<C-e>', ':Neotree left reveal<CR>', desc = 'left N[e]oTree reveal', silent = true },
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
                     use_float = true,
                     use_snacks_image = false,
                     use_image_nvim = false,
                  },
               },
            },
         },
         hijack_netrw_behavior = 'disabled', -- weird ass name -- allows to open yazi by default
      },
   },
}
