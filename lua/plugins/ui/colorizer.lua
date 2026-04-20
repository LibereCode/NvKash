return { -- NOTE: Colorizer (give color to #ff7200 hex codes) https://github.com/norcalli/nvim-colorizer.lua
  'catgoose/nvim-colorizer.lua', -- 'norcalli/nvim-colorizer.lua', OG lowkey unmentained
  event = 'BufReadPre', -- BufReadPre not working -- Lazyload until event "BufREadPre"
  -- Remember kids, TO DELETE THE OLD VERSION BEFORE INSTALLING A NEW!
  opts = function(_, opts)
    vim.keymap.set('n', '<leader>uc', ':ColorizerToggle<CR>')
    return { -- INFO: https://github.com/catgoose/nvim-colorizer.lua?tab=readme-ov-file#default-configuration
      options = {
        parsers = {
          css = true, -- preset: enables names, hex, rgb, hsl, oklch, css_var
          -- css_fn = true,
          names = { extra_word_chars = '' }, -- '-_'
          xterm = { enable = true }, -- xterm 256-color codes (#xNN, \e[38;5;NNNm) \e[32;1m
        },
        display = {
          mode = { 'foreground', 'virtualtext' },
          virtualtext = {
            -- position = 'before', -- default='eol'
            char = '󰚍', -- '', -- '■', -- character used for virtualtext
          },
        },
      },
    }
  end,
}
