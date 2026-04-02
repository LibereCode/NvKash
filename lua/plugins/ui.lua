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
  { -- NOTE: Colorizer (give color to #ff7200 hex codes) https://github.com/norcalli/nvim-colorizer.lua
    'norcalli/nvim-colorizer.lua',
    config = function() require('colorizer').setup() end,
    -- opts = {}, -- didn't work?
  },

  { -- NOTE: DASHBOARD https://github.com/goolord/alpha-nvim/blob/main/lua/alpha/themes/dashboard.lua
    'goolord/alpha-nvim',
    dependencies = {
      -- 'nvim-mini/mini.icons',
      'nvim-tree/nvim-web-devicons',
      'nvim-lua/plenary.nvim',
    },
    -- config = function() require('alpha').setup(require('alpha.themes.theta').config) end,
    config = function()
      -- theta
      -- local dash = require 'alpha.themes.theta' -- theta with devicons instead of mini
      --
      -- dash.file_icons.provider = 'devicons'
      -- require('alpha').setup(theta.config)

      -- dashboard-nvim
      local dash = require 'alpha.themes.dashboard' -- theme dashboard
      local find_conf = '<CMD>lua confdir = vim.fn.stdpath("config") ; vim.cmd("cd" .. confdir) ; require("telescope.builtin").find_files({cwd = confdir})<CR>'
      --
      local butt = dash.button -- (sc, txt, keybind, keybind_opts)
      dash.section.buttons.val = {
        butt('n', '  [n]ew buffer', '<cmd>enew<CR>'),
        butt('f', '  Find [f]ile', '<CMD>Telescope find_files<CR>'),
        butt('r', '  [r]ecent files', '<CMD>Telescope oldfiles<CR>'),
        -- butt('g', '󰈬  live [g]rep', '<CMD>Telescope live_grep<CR>'),
        butt('h', '󰋖  find [h]elp', '<CMD>Telescope help_tags<CR>'),
        -- butt('m', '  find [m]an_pages', '<CMD>Telescope man_pages<CR>'),
        butt('c', '  cd+find [c]onfig', find_conf),
        -- butt('C', '  [C]olorschemes', '<CMD>Telescope colorscheme<CR>'),
        butt('l', '󰒲  [l]azy', '<CMD>Lazy<CR>'),
        -- butt('m', '󰒐  [m]ason', '<CMD>Mason<CR>'),
        -- butt('b', '  Jump to bookmarks'),
        -- butt('r', '  Open last session'),
        butt('q', '󰩈  [q]uit', '<cmd>q<CR>'),
      }
      dash.section.header.val = {
        [[*------------------------------------------------*]],
        [[|    .-----------------------.                   |]],
        [[|    |  ▄▄         ▄       ▄▄|    .-----.        |]],
        [[|    |▄▀███▄     ▄██     ▄███|    | === |        |]],
        [[|    |██▄▀███▄   ███   ▄███▀ |    |-----|        |]],
        [[|    |███  ▀███▄ ███ ▄███▀   |    | === |        |]],
        [[|    |███    ▀██ ███ ███▄    |    |-----|        |]],
        [[|    |███      ▀ ███  ▀███▄  |    |:::::|        |]],
        [[|    |▀██        ▀██    ▀███▄|    | ::: |        |]],
        [[|    |  ▀          ▀      ▀▀▀|    |____o|        |]],
        [[|    ')---------------------('  ____________     |]],
        [[|    '::::::::::'  '::::::::::' '  no mouse '    |]],
        [[|   ':::========'  '==hjkl==:::' '  required '   |]],
        [[|  '------------'  '------------' '-----------'  |]],
        [[|              Powered by  eovim              |]],
        [[*------------------------------------------------*]],
      }
      dash.section.footer.val = require 'alpha.fortune'() -- forture (https://github.com/goolord/alpha-nvim/blob/main/lua/alpha/fortune.lua)
      require('alpha').setup(dash.opts)

      -- -- startify
      -- local dash = require 'alpha.themes.startify' -- startify
      --
      -- dash.file_icons.provider = 'devicons'
      -- dash.section.mru.val = {} -- disable mru
      -- -- dash.section.mru_cwd.val = {}
      -- dash.section.footer.type = 'text' -- forture (https://github.com/goolord/alpha-nvim/blob/main/lua/alpha/fortune.lua)
      -- dash.section.footer.val = require 'alpha.fortune'() -- forture (https://github.com/goolord/alpha-nvim/blob/main/lua/alpha/fortune.lua)
      -- require('alpha').setup(dash.config)
    end,
  },

  { -- NOTE: Lualine https://github.com/nvim-lualine/lualine.nvim
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      { 'tiagovla/scope.nvim', config = true }, -- NOTE: Scope -- https://github.com/tiagovla/scope.nvim
    },

    init = function()
      vim.g.lualine_laststatus = vim.o.laststatus
      if vim.fn.argc(-1) > 0 then
        vim.o.statusline = ' ' -- set an empty statusline till lualine loads
      else
        vim.o.laststatus = 0 -- hide the statusline on the starter page
      end
    end,

    config = function() -- opts = {},
      require('lualine').setup {
        -- opts = function()
        --   local opts = {

        options = {
          icons_enabled = true,
          theme = 'auto',
          -- component_separators = { left = '', right = '' },
          -- section_separators = { left = '', right = '' },
          component_separators = { left = '|', right = '|' },
          section_separators = { left = '', right = '' },
          disabled_filetypes = {
            'alpha',
            'neo-tree',
            -- statusline = { 'alpha', 'neo-tree' },
            -- winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          always_show_tabline = true,
          globalstatus = false,
          refresh = {
            -- Update if auto if no event
            statusline = 1000,
            -- tabline = 100,
            -- winbar = 1000,
            -- speed
            refresh_time = 16, -- ~60fps
            events = { -- events
              'WinEnter',
              'BufEnter',
              'BufWritePost',
              'SessionLoadPost',
              'FileChangedShellPost',
              'VimResized',
              'Filetype',
              'CursorMoved',
              'CursorMovedI',
              'ModeChanged',
            },
          },
        },
        sections = { -- https://github.com/nvim-lualine/lualine.nvim?tab=readme-ov-file#component-options
          lualine_a = {
            'mode',
          },
          lualine_b = {
            'branch',
            'diff',
            'diagnostics',
          },
          lualine_c = {
            'filename',
          }, -- 'filename' = '%t%m'
          lualine_x = {
            -- 'encoding',
            -- 'fileformat',
            'lsp_status',
            'filetype',
          },
          lualine_y = {
            'selectioncount',
            'progress',
            'location',
          },
          lualine_z = {
            function() return ' ' .. os.date '%R' end,
          },
        },
        -- inactive_sections = {
        --   lualine_a = {},
        --   lualine_b = {},
        --   lualine_c = { 'filename' },
        --   lualine_x = { 'location' },
        --   lualine_y = {},
        --   lualine_z = {},
        -- },

        -- -- tabline = {},
        -- tabline = { -- TODO: replace with bufferline (or barbar)
        --   lualine_a = { 'buffers' },
        --   -- lualine_c = { '%=', '%t%m', '%3p' }, '%=' = ??? ; '%t%m' = filename,modified ; '%3p' = linenr/3
        --   -- lualine_x = { 'g:coc_status', 'bo:filetype' }, -- ignores abcxyz position and do whatever
        --   lualine_y = {},
        --   lualine_z = { 'tabs' },
        -- },

        -- winbar = {},
        -- inactive_winbar = {},
        -- -- winbar = {
        -- --    lualine_a = {},
        -- --    lualine_b = {},
        -- -- lualine_c = { 'filename' },
        -- --    lualine_x = {},
        -- --    lualine_y = {},
        -- --    lualine_z = {},
        -- -- },
        -- -- inactive_winbar = {
        -- --    lualine_a = {},
        -- --    lualine_b = {},
        -- -- lualine_c = { 'filename' },
        -- --    lualine_x = {},
        -- --    lualine_y = {},
        -- --    lualine_z = {},
        -- -- },

        extensions = {
          'neo-tree',
          'lazy',
          'man',
          'mason',
          'nvim-dap-ui',
        },
      }
      local function mapo(key, cmd, description, mode) -- modified version of regular `map()`
        mode = mode or 'n'
        vim.keymap.set(mode, key, cmd, { noremap = true, silent = true, desc = description })
      end
      mapo('<leader>bb', '<cmd>e #<cr>', 'Switch to other')
      mapo('<leader>bl', '<cmd>buffers<CR>', '[l]ist buffers')
      mapo('<leader>bn', '<cmd>enew<CR>', 'new buf-file')
      mapo('<leader>bd', '<cmd>bn<BAR>bd #<CR>', 'delete buf')
      mapo('H', '<cmd>bp<CR>', 'prev buf')
      mapo('L', '<cmd>bn<CR>', 'next buf')
    end,
  },

  {
    'akinsho/bufferline.nvim',
    version = '*',
    event = 'VeryLazy',
    dependencies = 'nvim-tree/nvim-web-devicons',
    keys = {
      { '<leader>bp', '<Cmd>BufferLineTogglePin<CR>', desc = 'toggle pin' },
      { '<leader>bP', '<Cmd>BufferLineGroupClose ungrouped<CR>', desc = 'delete non-pinned buffers' },
      { '<leader>bd', '<Cmd>bn <BAR> bd #<CR>', desc = 'delete buffer' },
      { '<leader>bD', '<Cmd>BufferLinePickClose<CR>', desc = 'pick buf2DEL' },
      -- TODO: for i in 1 10, "b<i>", "BufferLineGoToBuffer <i>", "goto buf <i>"
      { '<leader>bs', '<cmd>BufferLinePick<cr>', desc = 'select buf' },
      { '<S-M-h>', '<cmd>BufferLineMovePrev<cr>', desc = 'Move buffer prev' },
      { '<S-M-l>', '<cmd>BufferLineMoveNext<cr>', desc = 'Move buffer next' },
    },
    opts = {
      options = {
        -- can be a string | function, | false see "Mouse actions"
        close_command = 'bdelete! %d',
        right_mouse_command = 'BufferLineTogglePin %d',
        left_mouse_command = 'buffer %d',
        middle_mouse_command = 'bdelete! %d',

        indicator = {
          icon = '👉', -- '▎', -- this should be omitted if indicator style is not 'icon'
          style = 'icon', --'icon' | 'underline' | 'none',
        },
        modified_icon = ' ', -- '● ',
        max_name_length = 15,
        max_prefix_length = 12,
        tab_tab_size = 20,

        diagnostics = 'nvim_lsp',
        always_show_bufferline = true,
        offsets = {
          {
            filetype = 'neo-tree',
            text = 'Neo-tree',
            highlight = 'Directory',
            text_align = 'left',
          },
        },
        custom_filter = function(buf_number, buf_numbers)
          if vim.bo[buf_number].buftype ~= 'terminal' then return true end -- this hides terminal (buftype and not filetype, for some reason)
        end,
      },
    },
  },

  -- image viewer intergration:
  { -- TODO:
    '3rd/image.nvim', -- allows image view in preview
    build = false, -- so that it doesn't build the rock https://github.com/3rd/image.nvim/issues/91#issuecomment-2453430239
    opts = {
      processor = 'magick_cli',
    },
    -- INFO: Default: https://github.com/3rd/image.nvim?tab=readme-ov-file#default-configuration
  },
}
