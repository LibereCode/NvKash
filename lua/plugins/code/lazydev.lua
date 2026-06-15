return {
  'folke/lazydev.nvim',
  ft = 'lua', -- only load on lua files
  -- dependencies = {
  --   { 'folke/neodev.nvim', enabled = false }, -- make sure to uninstall or disable neodev.nvim
  -- },

  opts = {
    library = {
      -- -- Library paths can be absolute
      -- "~/projects/my-awesome-lib",

      -- Or relative, which means they will be resolved from the plugin dir.
      'lazy.nvim',

      -- See the configuration section for more details
      -- Load luvit types when the `vim.uv` word is found
      { path = '${3rd}/luv/library', words = { 'vim%.uv' } },

      -- -- Only load the lazyvim library when the `LazyVim` global is found
      -- { path = 'LazyVim', words = { 'LazyVim' } },

      -- Load the wezterm types when the `wezterm` module is required
      { path = 'wezterm-types', mods = { 'wezterm' } },

      -- Load the xmake types when opening file named `xmake.lua`
      -- Needs `LelouchHe/xmake-luals-addon` to be installed
      { path = 'xmake-luals-addon/library', files = { 'xmake.lua' } },
    },

    enabled = function(root_dir) -- INFO: disable if ./luarc.json(|c) is found
      return not (vim.uv.fs_stat(root_dir .. '/.luarc.json') or vim.uv.fs_stat(root_dir .. '/.luarc.jsonc'))
        or (vim.g.lazydev_enabled == nil and true or vim.g.lazydev_enabled) -- or if manually specified
    end,
  },
}
