return {
  'NeogitOrg/neogit',
  lazy = true,
  dependencies = {
    'nvim-lua/plenary.nvim', -- required

    -- Only one of these is needed.
    'sindrets/diffview.nvim', -- Will test this one first  TEST:
    -- 'esmuellert/codediff.nvim', -- optional

    -- For a custom log pager
    'm00qek/baleia.nvim', -- optional

    -- Only one of these is needed.
    'nvim-telescope/telescope.nvim', -- optional
    -- 'ibhagwan/fzf-lua', -- optional
    -- 'nvim-mini/mini.pick', -- optional
    -- 'folke/snacks.nvim', -- optional
  },
  cmd = 'Neogit',
  keys = {
    { '<leader>gg', '<cmd>Neogit<cr>', desc = 'Neo[g]it' },
  },
} -- INFO: DEFAULT CONFIG => https://github.com/neogitorg/neogit#configuration
