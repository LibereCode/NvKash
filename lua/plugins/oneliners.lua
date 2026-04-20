return { -- oneliners (short plugs in one line)
  -- Plugins can be added via a link or github org/name. To run setup automatically, use `opts = {}`
  { 'NMAC427/guess-indent.nvim', opts = { enabled = false } },

  -- sudo if write passwd in a non-root nvim -- https://github.com/lambdalisue/vim-suda
  {
    'lambdalisue/suda.vim',
    lazy = false,
    -- has to be config caus it is a .vim plugin
    config = function() vim.api.nvim_create_user_command('W', 'echo "Just type :SudaWrite"', {}) end,
  },
}

-- TODO: I think I will remove this
