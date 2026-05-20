return { -- NOTE: Colorizer (give color to #ff7200 hex codes) https://github.com/norcalli/nvim-colorizer.lua
  'catgoose/nvim-colorizer.lua', -- 'norcalli/nvim-colorizer.lua', OG lowkey unmentained
  event = 'BufReadPre', -- BufReadPre not working -- Lazyload until event "BufREadPre"
  -- Remember kids, TO DELETE THE OLD VERSION BEFORE INSTALLING A NEW!
  opts = function(_, opts)
    vim.keymap.set('n', '<leader>uc', ':ColorizerToggle<CR>')
    -- vim.keymap.set('n', '<leader>tc', ':ColorizerToggle<CR>')
    return { -- INFO: https://github.com/catgoose/nvim-colorizer.lua?tab=readme-ov-file#default-configuration
      options = {
        parsers = {
          css = true, -- preset: enables names, hex, rgb, hsl, oklch, css_var
          -- css_fn = true,
          names = { extra_word_chars = '' }, -- '-_'
          xterm = { -- xterm 256-color codes (#xNN, \e[38;5;255m) (>255)
            enable = true, -- OR \e[38;2;255;99;9m (38|48) OR \e[33;1m (0|1)(3n/4n)
          },
          hex = {
            rgb = false, -- #911
            rgba = false, -- #f067
          },
        },

        display = {
          mode = { 'background', 'virtualtext' }, -- foreground
          virtualtext = {
            -- position = 'before', -- default='eol'
            char = '󰚍', -- '', -- '■', -- character used for virtualtext
          },
        },
      },
    }
  end,
}
