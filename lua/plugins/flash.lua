return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  vscode = true,
  ---@type Flash.Config
  opts = {}, -- omg, jag glömde denna och det fucka mig så länge
  -- keys = function() -- NOTE: see keybinds in config/keymaps.lua
  --   return {
  keys = {
    { -- wtf, detta fungerade superenkelt? flyttade hit ifrån config/keymaps.lua
      's',
      mode = { 'n', 'v' },
      function() require('flash').jump() end,
      desc = 'flash󰉁',
    },
    {
      'S',
      mode = { 'n', 'v' },
      function() require('flash').treesitter { actions = { ['S'] = 'next', ['s'] = 'prev' } } end,
      desc = 'Simulate󰉁treesitter󰉁incremental󰉁selection',
    },

    { -- Vad fan är remote, och vad är mode='o' ??
      'r',
      mode = 'o',
      function() require('flash').remote() end,
      desc = '[r]emote Flash',
    },
    {
      'R',
      mode = { 'o', 'x' },
      function() require('flash').treesitter_search() end,
      desc = 't[R]eesitter Search',
    },

    { -- och vad är detta?
      '<C-f>',
      mode = 'c',
      function() require('flash').toggle() end,
      desc = 'Toggle [f]lash Search',
    },

    -- { "s", mode = { "n", "x", "o" }, false }, -- disable the default flash keymap -- not needed
  },
  -- end,
}
