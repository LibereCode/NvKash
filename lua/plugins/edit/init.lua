return {
  require 'plugins.edit.dial',
  require 'plugins.edit.autopairs',
  require 'plugins.edit.undotree',
  -- require 'plugins.edit.grug',

  -- Plugins can be added via a link or github org/name. To run setup automatically, use `opts = {}`
  { 'NMAC427/guess-indent.nvim', opts = { enabled = false } },
}
