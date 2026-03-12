return {

  -- Load the colorscheme here.
  -- Like many other themes, this one has different styles, and you could load
  -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
  -- You can easily change to a different colorscheme.
  -- Change the name of the colorscheme plugin below, and
  -- and then change the command in the config to whatever the
  -- the name of that colorscheme is.
  -- `:Telescope colorscheme` to see aldready installed colorschemes
  --
  {
    'rebelot/kanagawa.nvim',
    priority = 1000,
    lazy = false,
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      ---@diagnostic disable-next-line: missing-fields
      require('kanagawa').setup {
        styles = {
          theme = 'dragon', -- or "lotus", "dragon" (or wave)
          comments = { italic = true },
          -- comments = { italic = false }, -- Disable italics in comments
        },
      }
      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      vim.cmd.colorscheme 'kanagawa-dragon'
      vim.cmd.set 'termguicolors'
      vim.cmd.set 'background=dark'
    end,
  },
  --
  -- INFO: Not imported into init.lua.
  -- colorscheme in ../chadrc.lua
}
