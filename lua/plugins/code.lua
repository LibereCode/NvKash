return {
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

  -- debug.lua
  -- Shows how to use the DAP plugin to debug your code.
  --
  -- Primarily focused on configuring the debugger for Go, but can
  -- be extended to other languages as well. That's why it's called
  -- kickstart.nvim and not kitchen-sink.nvim ;)
  ---@module 'lazy'
  ---@type LazySpec
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      -- Creates a beautiful debugger UI
      'rcarriga/nvim-dap-ui',

      -- Required dependency for nvim-dap-ui
      'nvim-neotest/nvim-nio',

      -- Installs the debug adapters for you
      'mason-org/mason.nvim',
      'jay-babu/mason-nvim-dap.nvim',

      -- Add your own debuggers here
      'leoluz/nvim-dap-go',
    },
    keys = {
      -- Basic debugging keymaps, feel free to change to your liking! -- HACK: changed to <leader>d*
      { '<leader>ds', function() require('dap').continue() end, desc = 'Debug: Start/Continue' }, -- <F5>
      { '<leader>di', function() require('dap').step_into() end, desc = 'Debug: Step [i]nto' }, -- <F1>
      { '<leader>dn', function() require('dap').step_over() end, desc = 'Debug: Step [n]ext' }, -- Over <F2>
      { '<leader>do', function() require('dap').step_out() end, desc = 'Debug: Step [o]ut' }, -- <F3>
      { '<leader>db', function() require('dap').toggle_breakpoint() end, desc = 'Debug: Toggle Breakpoint' },
      { '<leader>dB', function() require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ') end, desc = 'Debug: Set Breakpoint' },
      -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
      { '<leader>dr', function() require('dapui').toggle() end, desc = 'Debug: See last session [r]esult.' }, -- <F7>
    },
    config = function()
      local dap = require 'dap'
      local dapui = require 'dapui'

      require('mason-nvim-dap').setup {
        -- Makes a best effort to setup the various debuggers with
        -- reasonable debug configurations
        automatic_installation = true,

        -- You can provide additional configuration to the handlers,
        -- see mason-nvim-dap README for more information
        handlers = {},

        -- You'll need to check that you have the required things installed
        -- online, please don't ask me how to install them :)
        ensure_installed = {
          -- Update this to ensure that you have the debuggers for the langs you want
          'delve',
        },
      }

      -- Dap UI setup
      -- For more information, see |:help nvim-dap-ui|
      ---@diagnostic disable-next-line: missing-fields
      dapui.setup {
        -- Set icons to characters that are more likely to work in every terminal.
        --    Feel free to remove or use ones that you like more! :)
        --    Don't feel like these are good choices.
        icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
        ---@diagnostic disable-next-line: missing-fields
        controls = {
          icons = {
            pause = '⏸',
            play = '▶',
            step_into = '⏎',
            step_over = '⏭',
            step_out = '⏮',
            step_back = 'b',
            run_last = '▶▶',
            terminate = '⏹',
            disconnect = '⏏',
          },
        },
      }

      -- Change breakpoint icons
      -- vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
      -- vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })
      -- local breakpoint_icons = vim.g.have_nerd_font
      --     and { Breakpoint = '', BreakpointCondition = '', BreakpointRejected = '', LogPoint = '', Stopped = '' }
      --   or { Breakpoint = '●', BreakpointCondition = '⊜', BreakpointRejected = '⊘', LogPoint = '◆', Stopped = '⭔' }
      -- for type, icon in pairs(breakpoint_icons) do
      --   local tp = 'Dap' .. type
      --   local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
      --   vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
      -- end

      dap.listeners.after.event_initialized['dapui_config'] = dapui.open
      dap.listeners.before.event_terminated['dapui_config'] = dapui.close
      dap.listeners.before.event_exited['dapui_config'] = dapui.close

      -- Install golang specific config
      require('dap-go').setup {
        delve = {
          -- On Windows delve must be run attached or it crashes.
          -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
          detached = vim.fn.has 'win32' == 0,
        },
      }
    end,
  },

  -- { require('kickstart.plugins.autopairs') } -- NOTE: Autopairs

  -- Add indentation guides even on blank lines
  ---@module 'lazy'
  ---@type LazySpec
  {
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = 'ibl',
    ---@module 'ibl'
    ---@type ibl.config
    opts = function() -- NOTE: inspired by LazyVim https://www.lazyvim.org/extras/ui/indent-blankline#indent-blanklinenvim
      return {
        debounce = 100, -- ms(time) between refreshes
        indent = {
          char = { '┆' }, --   '┋''┊', '┆''┇', '╏''╎', '│',
          tab_char = { '╏', '┇', '┋' }, -- '╎', -- '│', -- what is this
        },
        -- whitespace = { -- ? ingen aning vad detta är...
        --   highlight = { 'Function', 'Label', 'Whitespace', 'NonText' },
        --   remove_blankline_trail = true,
        -- },
        scope = { -- INFO: `:h ibl.config.scope`
          include = {
            node_type = {
              ['*'] = {
                'return_statement', -- return {}
                'table_constructor', -- { tables },
                'if_statement', -- add the node 'if'
                'while_statement', -- add the node 'if'
              },
              -- { ['*'] = { '*' } }, -- adds all nodes for all file-types. WARN: BAD
              -- lua = { -- Adds some nodes to lua
              --   'return_statement', -- return {}
              --   'table_constructor', -- { tables },
              -- },
              -- python = { -- adds to python
              --   'if_statement', -- add the node 'if'
              --   'while_statement', -- add the node 'if'
              -- },
            },
          },
          -- exclude = { language = { 'lua' } } -- Disables scope for lua
        },
        exclude = { -- LazyVim
          filetypes = {
            'Trouble',
            'alpha',
            'dashboard',
            'help',
            'lazy',
            'mason',
            'neo-tree',
            'trouble',
          },
        },
        -- INFO: `:h ibl.config.scope` explains scope good
      }
    end,
    -- TODO:
    -- - [ ] :IBLToggle (make into keymap)
  },
}
