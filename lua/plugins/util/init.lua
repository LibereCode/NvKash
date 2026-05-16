return {

  -- sudo if write passwd in a non-root nvim -- https://github.com/lambdalisue/vim-suda
  {
    'lambdalisue/suda.vim',
    lazy = false,
    -- has to be config caus it is a .vim plugin
    config = function() --
      -- vim.api.nvim_create_user_command('W', 'echo "Just type :SudaWrite"', {})
      vim.api.nvim_create_user_command('W', 'w', { desc = 'fix common typo of "w"' })
    end,
  },

  -- NOTE: -- GIT --

  require 'plugins.util.gitsigns',

  -- nvim v0.8.0
  -- { 'kdheepak/lazygit.nvim' } -- HACK: replaced with custom.lazygit

  require 'plugins.util.neogit', -- TEST:
}
