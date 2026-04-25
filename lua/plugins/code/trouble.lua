return {
  'folke/trouble.nvim',
  cmd = 'Trouble',
  keys = {
    {
      '<leader>dx',
      '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
      desc = 'Buffer Diagnostics (Trouble)',
    },
    {
      '<leader>dX',
      '<cmd>Trouble diagnostics toggle<cr>',
      desc = 'Diagnostics (Trouble)',
    },
    {
      '<leader>cs',
      '<cmd>Trouble symbols toggle focus=false<cr>',
      desc = 'Symbols (Trouble)',
    },
    {
      '<leader>cl',
      '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
      desc = 'LSP Definitions / references / ... (Trouble)',
    },
    {
      '<leader>dO',
      function()
        vim.diagnostic.setloclist { open = false }
        vim.cmd [[Trouble loclist toggle]]
      end,
      desc = 'L[O]Clist (Trouble)',
    },
    {
      '<leader>dq',
      '<cmd>Trouble qflist toggle<cr>',
      desc = '[q]uickfix (Trouble)',
    },
  },
  opts = function(_, opts) -- There are more opts
    require('which-key').add { '<leader>d', group = 'debug (trouble)' }
    return {}
  end,
}
