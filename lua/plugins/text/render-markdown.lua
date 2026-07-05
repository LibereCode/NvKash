return {
  'MeanderingProgrammer/render-markdown.nvim',

  ft = { 'markdown' }, -- TEST: I think it works (even in lsp-window)

  dependencies = {
    'nvim-treesitter/nvim-treesitter',

    -- 'nvim-mini/mini.nvim',      -- if you use the mini.nvim suite
    -- 'nvim-mini/mini.icons',     -- if you use standalone mini plugins
    'nvim-tree/nvim-web-devicons', -- if you prefer nvim-web-devicons
  },

  ---@module 'render-markdown'
  ---@type render.md.UserConfig  -- INFO: <https://github.com/MeanderingProgrammer/render-markdown.nvim/wiki>
  opts = {
    enabled = true,
  },
}
