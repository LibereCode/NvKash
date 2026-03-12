-- These are some examples, uncomment them if you want to see them work!
return {
  {
    'stevearc/conform.nvim',
    event = 'BufWritePre', -- uncomment for format on save
    opts = require 'config.conforming',
  },

  -- These are some examples, uncomment them if you want to see them work!
  { -- kashmodified
    'neovim/nvim-lspconfig',
    -- config = require('config.lspconf').confkick, -- Kickstart
    dependencies = require('config.lspconf').deps,
    config = require('config.lspconf').confchad, -- NvChad
  },

  -- test new blink
  -- { import = 'nvchad.blink.lazyspec' },
  { -- Kashmodified
    { 'hrsh7th/nvim-cmp', enabled = false },
    {
      -- import = 'config.blink', -- moved to below:
      'saghen/blink.cmp',
      version = '1.*',
      event = { 'InsertEnter', 'CmdLineEnter' },
      -- dependencies = require 'config.blink_deps',
      dependencies = require('config.blink').deps,
      opts_extend = { 'sources.default' },
      -- opts = function() return require 'config.blink_opts' end,
      opts = function() return require('config.blink').opts end,
    },
  },

  { -- kashmodified
    'nvim-treesitter/nvim-treesitter',
    opts = require('config.treesitter').opts,
  },

  { -- DAP
    'mfussenegger/nvim-dap', -- Yes, you can install new plugins here!
    dependencies = require('config.dapper').deps,
    keys = require('config.dapper').keys,
    config = require('config.dapper').conf,
  },

  { -- Linting
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = require 'config.linting',
  },
}
