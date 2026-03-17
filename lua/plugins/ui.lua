-- INFO: UI plugins.
-- currently includes:
-- > colorizer
-- > dashboard (alpha)
-- > buffer bar (barbar)

return {
  { -- Colorizer (give color to #ff7200 hex codes) https://github.com/norcalli/nvim-colorizer.lua
    'norcalli/nvim-colorizer.lua',
    config = function() require('colorizer').setup() end,
  },

  { -- INFO: DASHBOARD https://github.com/goolord/alpha-nvim/blob/main/lua/alpha/themes/dashboard.lua
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

  {
    'romgrk/barbar.nvim',
    dependencies = {
      'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
      'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    },
    init = function() vim.g.barbar_auto_setup = false end,
    -- opts = {
    --   -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
    --   -- animation = true,
    --   -- insert_at_start = true,
    --   -- …etc.
    -- },
    opts = function()
      local map = vim.api.nvim_set_keymap
      local opts = { noremap = true, silent = true }

      -- Move to previous/next
      map('n', '<leader>bh', '<Cmd>BufferPrevious<CR>', opts)
      map('n', '<leader>bl', '<Cmd>BufferNext<CR>', opts)

      -- Re-order to previous/next
      map('n', '<leader>bH', '<Cmd>BufferMovePrevious<CR>', opts)
      map('n', '<leader>bL', '<Cmd>BufferMoveNext<CR>', opts)

      -- Goto buffer in position...
      map('n', '<leader>b1', '<Cmd>BufferGoto 1<CR>', opts)
      map('n', '<leader>b2', '<Cmd>BufferGoto 2<CR>', opts)
      map('n', '<leader>b3', '<Cmd>BufferGoto 3<CR>', opts)
      map('n', '<leader>b4', '<Cmd>BufferGoto 4<CR>', opts)
      map('n', '<leader>b5', '<Cmd>BufferGoto 5<CR>', opts)
      map('n', '<leader>b6', '<Cmd>BufferGoto 6<CR>', opts)
      map('n', '<leader>b7', '<Cmd>BufferGoto 7<CR>', opts)
      map('n', '<leader>b8', '<Cmd>BufferGoto 8<CR>', opts)
      map('n', '<leader>b9', '<Cmd>BufferGoto 9<CR>', opts)
      map('n', '<leader>b0', '<Cmd>BufferLast<CR>', opts)

      -- Pin/unpin buffer
      map('n', '<leader>b.', '<Cmd>BufferPin<CR>', opts)

      -- Goto pinned/unpinned buffer
      --                 :BufferGotoPinned
      --                 :BufferGotoUnpinned

      -- Close buffer
      map('n', '<leader>bc', '<Cmd>BufferClose<CR>', opts)

      -- Wipeout buffer
      --                 :BufferWipeout

      -- Close commands
      --                 :BufferCloseAllButCurrent
      --                 :BufferCloseAllButPinned
      --                 :BufferCloseAllButCurrentOrPinned
      --                 :BufferCloseBuffersLeft
      --                 :BufferCloseBuffersRight

      -- Magic buffer-picking mode (select)
      map('n', '<leader>bp', '<Cmd>BufferPick<CR>', opts)
      map('n', '<leader>bd', '<Cmd>BufferPickDelete<CR>', opts)

      -- Sort automatically by... (order)
      map('n', '<leader>bob', '<Cmd>BufferOrderByBufferNumber<CR>', opts)
      map('n', '<leader>bon', '<Cmd>BufferOrderByName<CR>', opts)
      map('n', '<leader>bod', '<Cmd>BufferOrderByDirectory<CR>', opts)
      map('n', '<leader>bol', '<Cmd>BufferOrderByLanguage<CR>', opts)
      map('n', '<leader>bow', '<Cmd>BufferOrderByWindowNumber<CR>', opts)

      -- Other:
      -- :BarbarEnable - enables barbar (enabled by default)
      -- :BarbarDisable - very bad command, should never be used
    end,

    version = '^1.0.0', -- optional: only update when a new 1.x version is released
  },
}
