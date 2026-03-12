return {
  -- Add indentation guides even on blank lines (kickstart extra)
  -- { 'lukas-reineke/indent-blankline.nvim', main = 'ibl', opts = {} }, -- See `:help ibl` -- something enables this auto, but use enabled by NvChad
  { 'lukas-reineke/indent-blankline.nvim', enabled = false }, -- See `:help ibl` -- something enables this auto, but use enabled by NvChad

  -- autopairs https://github.com/windwp/nvim-autopairs
  { 'windwp/nvim-autopairs', event = 'InsertEnter', opts = {} },

  -- Plugins can be added via a link or github org/name. To run setup automatically, use `opts = {}`
  { 'NMAC427/guess-indent.nvim', opts = {} },

  -- sudo if write passwd in a non-root nvim -- https://github.com/lambdalisue/vim-suda
  { 'lambdalisue/suda.vim', lazy = false, conf = {} },
}
