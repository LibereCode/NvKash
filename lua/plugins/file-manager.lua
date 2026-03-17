return {
  {

    ---@type LazySpec
    'mikavilpas/yazi.nvim',
    version = '*', -- use the latest stable version
    event = 'VeryLazy',
    dependencies = {
      { 'nvim-lua/plenary.nvim', lazy = true },
    },
    keys = { -- 👇 in this section, choose your own keymappings!
      { -- Open in the current working directory
        '<leader>y',
        '<cmd>Yazi cwd<cr>',
        desc = 'Yazi cwd',
      },
      { -- "<C-->", -- "<c-up>",
        '<c-y>',
        '<cmd>Yazi toggle<cr>',
        desc = 'Resume the last yazi session',
      },
    },
    ---@type YaziConfig | {}
    opts = {
      keymaps = {
        show_help = '<f1>',
        -- cycle_open_buffers = false,
        -- OR
        cycle_open_buffers = '<S-Tab>',
      },
      -- 👇 if you want to open yazi instead of netrw
      open_for_directories = true,
    },
    init = function() -- 👇 if you use `open_for_directories=true`, this is recommended
      -- mark netrw as loaded so it's not loaded at all. -- https://github.com/mikavilpas/yazi.nvim/issues/802
      vim.g.loaded_netrwPlugin = 1
    end,
  },

  -- { 'stevearc/oil.nvim', keys = { { '<leader>o', '<CMD>Oil<CR>' } }, opts = { default_file_explorer = false } }, -- NOTE: oil🦅 -- good, but doesn't fit

  { -- NOTE: Neo-Tree (This is best way)
    require 'kickstart.plugins.neo-tree',
  },

  -- { 'luukvbaal/nnn.nvim', opts = {} }, -- NOTE: nnn -- pretty good, but doesnt fit this config
}
