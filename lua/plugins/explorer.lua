return { -- file-managers/explorers
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
        '<cmd>Yazi toggle<cr>',
        desc = 'toggle [y]azi',
      },
      { -- "<C-->", -- "<c-up>",
        '<C-y>',
        '<cmd>Yazi cwd<cr>',
        desc = '[y]azi',
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
      -- cd on quit
      change_neovim_cwd_on_close = true,
      yazi_floating_window_winblend = 10, -- 0-100
      -- yazi_floating_window_border =
    },
    init = function() -- 👇 if you use `open_for_directories=true`, this is recommended
      -- mark netrw as loaded so it's not loaded at all. -- https://github.com/mikavilpas/yazi.nvim/issues/802
      vim.g.loaded_netrwPlugin = 1
    end,
  },

  { -- NOTE: Neo-Tree (This is best way)
    require 'kickstart.plugins.neo-tree',
  },

  -- { 'stevearc/oil.nvim', keys = { { '<leader>o', '<CMD>Oil<CR>' } }, opts = { default_file_explorer = false } }, -- NOTE: oil🦅 -- good, but doesn't fit

  -- { 'luukvbaal/nnn.nvim', opts = {} }, -- NOTE: nnn -- pretty good, but doesnt fit this config
}
