-- sudo if write passwd in a non-root nvim -- https://github.com/lambdalisue/vim-suda
return {
  -- {
  --   'lambdalisue/suda.vim',
  --   lazy = false,
  --   config = function() -- can't use opts = {} because it's a plugin.vim
  --     -- vim.api.nvim_create_user_command('W', 'echo "Just type :SudaWrite"', {})
  --   end,
  -- },
  { -- TEST:
    'denialofsandwich/sudo.nvim',
    cmd = { 'SudoRead', 'SudoWrite', 'SudoEdit' },
    dependencies = {
      'MunifTanjim/nui.nvim',
    },
    opts = {
      -- optional configuration
      commands = true,
    },
  },
}
