return {
  'OXY2DEV/markview.nvim',
  lazy = false,
  dependencies = { 'saghen/blink.cmp' }, -- Completion for `blink.cmp`
  keys = function() -- NOTE: see keybinds in config/keymaps.lua
    return {
      { -- map('n', '<leader>ms', '<CMD>Markview splitToggle<CR>', { desc = 'toggle split' })
        '<localleader>s',
        mode = 'n',
        '<CMD>Markview splitToggle<CR>',
        desc = 'toggle [s]plit',
        ft = 'markdown', -- ft = { 'markdown', 'telekasten' },
      },
      { -- map('n', '<leader>mt', '<CMD>Markview Toggle<CR>', { desc = 'toggle markview' })
        '<localleader>m',
        mode = 'n',
        '<CMD>Markview Toggle<CR>',
        desc = 'toggle [m]arkview',
        ft = 'markdown',
      },
    }
  end,
  opts = {
    preview = {
      enable = true,
      icon_provider = 'devicons', -- "mini" or "devicons"
      hybrid_modes = { 'n' },
      -- linewise_hybrid_mode = true, -- default is basically a better version
    },
  },
}
