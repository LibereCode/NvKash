-- INFO: UI plugins.
-- ENABLED:
-- > Colorizer
-- > Alpha (dashboard)
-- > Lualine (GOAT)
-- > scope (tab-manager)
-- > bufferline (buffer-bar)
-- DISBLED:
-- > barbar (buffer/tab-bar)
-- > cokeline (buffer-bar)

return {
  require 'plugins.ui.alpha',
  require 'plugins.ui.bufferline',
  require 'plugins.ui.colorizer',
  require 'plugins.ui.indent-blankline',
  -- require 'plugins.ui.image',
  require 'plugins.ui.lualine',
}
