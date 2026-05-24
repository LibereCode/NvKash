return {
  { -- INFO: install the theme
    "rebelot/kanagawa.nvim",
    opts = {}, -- for more: https://github.com/rebelot/kanagawa.nvim
  },

  { -- INFO: load the theme
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "kanagawa-dragon",
    },
  },
}
