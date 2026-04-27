return {
  ---@type LazySpec
  'mikavilpas/yazi.nvim',
  version = '*', -- use the latest stable version
  event = 'VeryLazy',
  dependencies = {
    { 'nvim-lua/plenary.nvim', lazy = true },
    -- {
    --   'princejoogie/chafa.nvim', -- Image preview fallback -- funkar... typ... (pretty badly)
    --   dependencies = {
    --     'nvim-lua/plenary.nvim',
    --     'm00qek/baleia.nvim',
    --   },
    --   opts = {},
    -- },
  },
  keys = { -- 👇 in this section, choose your own keymappings!
    { -- Open in the current working directory
      '<leader>y',
      '<cmd>Yazi toggle<cr>',
      desc = 'toggle [y]azi',
    },
    { -- 1000iq move -- smoort (I can toogle noow)
      '<leader>y',
      'q',
      mode = { 't' },
    },
    { -- "<C-->", -- "<c-up>",
      '<C-y>',
      '<cmd>Yazi cwd<cr>',
      desc = '[y]azi',
    },
  },
  opts = {
    keymaps = {
      show_help = '<f1>',
      -- cycle_open_buffers = false,
      -- OR
      cycle_open_buffers = '<S-Tab>',
    },
    -- open_for_directories = true, 👈 if you want to open yazi instead of netrw
    -- cd on quit
    change_neovim_cwd_on_close = true,
    yazi_floating_window_winblend = 10, -- 0-100
    yazi_floating_window_border = 'rounded',
  },
  -- init = function() -- 👇 if you use `open_for_directories=true`, this is recommended
  --   -- mark netrw as loaded so it's not loaded at all. -- https://github.com/mikavilpas/yazi.nvim/issues/802
  --   vim.g.loaded_netrwPlugin = 1
  -- end,
}
