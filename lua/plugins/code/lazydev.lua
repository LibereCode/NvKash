return {
  'folke/lazydev.nvim',
  -- ft = 'lua', -- only load on lua files
  -- dependencies = {
  --   { 'folke/neodev.nvim', enabled = false }, -- make sure to uninstall or disable neodev.nvim
  -- },

  ---@class lazydev.Config
  opts = {
    ---@type lazydev.Library.spec[]
    library = {
      -- See the configuration section for more details
      -- Load luvit types when the `vim.uv` word is found
      { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
    },
    -- enabled = function(root_dir)
    --   return not vim.uv.fs_stat(root_dir .. "/.luarc.json")
    -- end,

    { path = 'LazyVim', words = { 'LazyVim' } }, -- Only loads LazyVim lib if LazyVim global is found
    { path = 'wezterm-types', mods = { 'wezterm' } }, -- Load the wezterm types when the `wezterm` module is required
  },

  keys = {
    { '<leader>ld', '<CMD>LazyDev lsp<CR>' },
  },
  -- enabled = function(root_dir) return not vim.uv.fs_stat(root_dir .. '/.luarc.json') end, -- WARN: bricks config
}
