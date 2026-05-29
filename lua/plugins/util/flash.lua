return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  vscode = true,
  ---@type Flash.Config
  opts = { -- HACK: omg, jag glömde denna och det fucka mig så länge (den fixa att `f` och `t` keys ej använde flash)

    search = {
      -- mode = 'fuzzy',
      -- incremental = true,
    },
    label = {
      -- style = 'inline', ---@type "eol" | "overlay" | "right_align" | "inline"
      -- min_pattern_length = 2,
      -- rainbow = { enabled = true, shade = 9 },
    },
    ---@type Flash.Config.jump
    jump = {
      nohlsearch = true,
    },
  },

  keys = {
    { -- wtf, detta fungerade superenkelt? flyttade hit ifrån config/keymaps.lua
      's',
      mode = { 'n', 'v', 'o' },
      function() require('flash').jump() end,
      desc = 'flash󰉁',
    },
    {
      'S',
      mode = { 'n', 'v', 'o' },
      function() require('flash').treesitter { actions = { ['S'] = 'next', ['s'] = 'prev' } } end,
      desc = 'flash󰉁tree[S]itter', -- 'Simulate󰉁treesitter󰉁incremental󰉁selection',
    },

    { -- 'o' = [o]perator-mode (d/c/y{motion})
      'r',
      mode = 'o',
      function() require('flash').remote() end,
      desc = '[r]emote󰉁Flash',
    },
    { -- 'x' = visual-mode (still mad that v isnt visual, but instead viusual+selection)
      'R',
      mode = { 'o', 'x' },
      function() require('flash').treesitter_search() end,
      desc = 'TreeSitte[R]󰉁Search',
    },

    { -- use flash during [/]search[?]
      '<C-s>',
      mode = { 'c' },
      function() require('flash').toggle() end,
      desc = 'Toggle Flash [s]earch',
    },

    -- { "s", mode = { "n", "x", "o" }, false }, -- disable the default flash keymap -- not needed
  },
  -- end,
}
