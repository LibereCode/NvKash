return { -- file-managers/explorersexpl
  -- Neo-tree is a Neovim plugin to browse the file system
  -- https://github.com/nvim-neo-tree/neo-tree.nvim
  ---@module 'lazy'
  ---@type LazySpec

  require 'plugins.explorer.neo-tree',
  -- require('plugins.explorer.nnn'),
  require 'plugins.explorer.oil',
  -- require 'plugins.explorer.yazi',
}
