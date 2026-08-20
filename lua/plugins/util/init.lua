return {
  require 'plugins.util.sudo',

  require 'plugins.util.gitsigns',
  -- require 'plugins.util.neogit', -- Use lazygit instead
  require 'plugins.util.lazygit', -- until I fix my custom-lazygit (or itegrate into my toggleTerm)

  -- require 'plugins.util.flash', -- XXX: dont work with 'nvim 0.13'
  require 'plugins.util.leap',
  -- NOTE Also see: ../mini.lua (mini.jump & mini.jump2d)
}
