-- INFO: UI plugins.
-- ENABLED:
-- > Colorizer
-- > Alpha (dashboard)
-- > Lualine (GOAT)
-- > scope (tab-manager)
-- DISBLED:
-- > barbar (buffer/tab-bar)
-- > cokeline (buffer-bar)
-- > bufferline (buffer-bar)

return {
   { -- NOTE: Colorizer (give color to #ff7200 hex codes) https://github.com/norcalli/nvim-colorizer.lua
      'norcalli/nvim-colorizer.lua',
      config = function() require('colorizer').setup() end,
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
         --
         local butt = dash.button -- (sc, txt, keybind, keybind_opts)
         dash.section.buttons.val = {
            butt('e', '  N[e]w buffer', '<cmd>enew<CR>'),
            butt('f', '  Find [f]ile', '<CMD>Telescope find_files<CR>'),
            butt('r', '  [r]ecent files', '<CMD>Telescope oldfiles<CR>'),
            butt('g', '󰈬  live [g]rep', '<CMD>Telescope live_grep<CR>'),
            butt('h', '󰋖  find [h]elp', '<CMD>Telescope help_tags<CR>'),
            butt('c', ' find [c]onfig', function() require('telescope.builtin').find_files { cwd = vim.fn.stdpath 'config' } end), -- NOTE: ignore diagnose, it's wrong
            butt('C', '  [C]olorschemes', '<CMD>Telescope colorscheme<CR>'),
            butt('l', '󰒲  [l]azy', '<CMD>Lazy<CR>'),
            -- butt('SPC f m', '  Jump to bookmarks'),
            -- butt('SPC s l', '  Open last session'),
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

      config = function() -- opts = {},
         require('lualine').setup {
            options = {
               icons_enabled = true,
               theme = 'auto',
               -- component_separators = { left = '', right = '' },
               -- section_separators = { left = '', right = '' },
               component_separators = { left = '|', right = '|' },
               section_separators = { left = '', right = '' },
               disabled_filetypes = {
                  -- statusline = { 'lua' },
                  statusline = {},
                  winbar = {},
               },
               ignore_focus = {},
               always_divide_middle = true,
               always_show_tabline = true,
               globalstatus = false,
               refresh = {
                  -- Update if auto if no event
                  statusline = 1000,
                  tabline = 100,
                  winbar = 1000,
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
               lualine_a = { 'mode' },
               lualine_b = { 'branch', 'diff', 'diagnostics' },
               lualine_c = { 'filename' },
               lualine_x = { 'encoding', 'fileformat', 'filetype' },
               lualine_y = { 'progress' },
               lualine_z = { 'location' },
            },
            inactive_sections = {
               lualine_a = {},
               lualine_b = {},
               lualine_c = { 'filename' },
               lualine_x = { 'location' },
               lualine_y = {},
               lualine_z = {},
            },

            -- tabline = {},
            tabline = { -- TODO: replace with bufferline (or barbar)
               lualine_a = { 'buffers' },
               -- lualine_b = { 'branch' },
               -- lualine_c = { 'filename' },
               lualine_b = {},
               lualine_c = {},
               lualine_x = {},
               lualine_y = {},
               lualine_z = { 'tabs' },
            },

            -- winbar = {},
            -- inactive_winbar = {},
            winbar = {
               lualine_a = {},
               lualine_b = {},
               lualine_c = { 'filename' },
               lualine_x = {},
               lualine_y = {},
               lualine_z = {},
            },
            inactive_winbar = {
               lualine_a = {},
               lualine_b = {},
               lualine_c = { 'filename' },
               lualine_x = {},
               lualine_y = {},
               lualine_z = {},
            },

            extensions = {
               'neo-tree',
               'lazy',
               'man',
               'mason',
               'nvim-dap-ui',
            },
         }

         local map = vim.api.nvim_set_keymap
         local opts = { noremap = true, silent = true }
         -- Move to previous/next
         map('n', '<leader>bh', '<Cmd>bprev<CR>', opts)
         map('n', '<leader>bl', '<Cmd>bnext<CR>', opts)
         -- Close buffer
         map('n', '<leader>bd', '<Cmd>bnext | bdel #<CR>', opts)
      end,
   },
}
