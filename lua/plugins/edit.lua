return {
  {
    'MagicDuck/grug-far.nvim',
    -- Note (lazy loading): grug-far.lua defers all it's requires so it's lazy by default
    -- additional lazy config to defer loading is not really needed...
    -- config = function()
    --   -- optional setup call to override plugin options
    --   -- alternatively you can set options with vim.g.grug_far = { ... }
    --   require('grug-far').setup {
    --     -- options, see Configuration section below
    --     -- there are no required options atm
    --   }
    -- end,
    opts = function(_, opts) vim.keymap.set('n', '<leader>r', '<CMD>lua require("grug-far").open()<CR>', { desc = 'grug & [r]eplace' }) end,
  },

  -- dial
  { -- config from lazyvim https://www.lazyvim.org/extras/editor/dial#dialnvim
    'monaqa/dial.nvim',
    recommended = true,
    desc = 'Increment and decrement numbers, dates, and more',
    -- -- stylua: ignore -- comment(ignore) the comment that says to ignore formatting
    keys = {
      { '<C-a>', function() require('dial.map').manipulate('increment', 'normal') end, desc = 'dial [a]dd', silent = true },
      { '<C-x>', function() require('dial.map').manipulate('decrement', 'normal') end, desc = 'dial sub[x]act', silent = true },
      { 'g<C-a>', function() require('dial.map').manipulate('increment', 'gnormal') end, desc = 'dial [a]dd', silent = true },
      { 'g<C-x>', function() require('dial.map').manipulate('decrement', 'gnormal') end, desc = 'dial [a]dd', silent = true },
    },
    opts = function()
      local augend = require 'dial.augend'

      local logical_alias = augend.constant.new {
        elements = { '&&', '||' },
        word = false,
        cyclic = true,
      }

      local ordinal_numbers = augend.constant.new {
        -- elements through which we cycle. When we increment, we go down
        -- On decrement we go up 1
        elements = {
          'first',
          'second',
          'third',
          'fourth',
          'fifth',
          'sixth',
          'seventh',
          'eighth',
          'ninth',
          'tenth',
        },
        -- if true, it only matches strings with word boundary. firstDate wouldn't work for example
        word = false,
        -- do we cycle back and forth (tenth to first on increment, first to tenth on decrement).
        -- Otherwise nothing will happen when there are no further values
        cyclic = true,
      }

      local months = augend.constant.new {
        elements = {
          'January',
          'February',
          'March',
          'April',
          'May',
          'June',
          'July',
          'August',
          'September',
          'October',
          'November',
          'December',
        },
        word = true,
        cyclic = true,
      }

      return {
        dials_by_ft = {
          css = 'css',
          vue = 'vue',
          javascript = 'typescript',
          typescript = 'typescript',
          typescriptreact = 'typescript',
          javascriptreact = 'typescript',
          json = 'json',
          lua = 'lua',
          markdown = 'markdown',
          sass = 'css',
          scss = 'css',
          python = 'python',
        },
        groups = {
          default = {
            augend.integer.alias.decimal, -- nonnegative decimal number (0, 1, 2, 3, ...)
            augend.integer.alias.decimal_int, -- nonnegative and negative decimal number
            augend.integer.alias.hex, -- nonnegative hex number  (0x01, 0x1a1f, etc.)
            -- augend.date.alias['%Y/%m/%d'], -- date (2022/02/19, etc.)  -- HACK: 2001-09-11
            augend.date.alias['%Y-%m-%d'],
            augend.constant.alias.en_weekday, -- Mon, Tue, ..., Sat, Sun
            augend.constant.alias.en_weekday_full, -- Monday, Tuesday, ..., Saturday, Sunday
            ordinal_numbers,
            months,
            augend.constant.alias.bool, -- boolean value (true <-> false)
            augend.constant.alias.Bool, -- boolean value (True <-> False)
            logical_alias,
          },
          vue = {
            augend.constant.new { elements = { 'let', 'const' } },
            augend.hexcolor.new { case = 'lower' },
            augend.hexcolor.new { case = 'upper' },
          },
          typescript = {
            augend.constant.new { elements = { 'let', 'const' } },
          },
          css = {
            augend.hexcolor.new {
              case = 'lower',
            },
            augend.hexcolor.new {
              case = 'upper',
            },
          },
          markdown = {
            augend.constant.new {
              elements = { '[ ]', '[x]' },
              word = false,
              cyclic = true,
            },
            augend.misc.alias.markdown_header,
          },
          json = {
            augend.semver.alias.semver, -- versioning (v1.1.2)
          },
          lua = {
            augend.constant.new {
              elements = { 'and', 'or' },
              word = true, -- if false, "sand" is incremented into "sor", "doctor" into "doctand", etc.
              cyclic = true, -- "or" is incremented into "and".
            },
          },
          python = {
            augend.constant.new {
              elements = { 'and', 'or' },
            },
          },
        },
      }
    end,
    config = function(_, opts)
      -- copy defaults to each group
      for name, group in pairs(opts.groups) do
        if name ~= 'default' then vim.list_extend(group, opts.groups.default) end
      end
      require('dial.config').augends:register_group(opts.groups)
      vim.g.dials_by_ft = opts.dials_by_ft
    end,
  },
}
