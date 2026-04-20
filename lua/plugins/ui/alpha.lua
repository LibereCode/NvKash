return { -- NOTE: DASHBOARD https://github.com/goolord/alpha-nvim/blob/main/lua/alpha/themes/dashboard.lua
  'goolord/alpha-nvim',
  enabled = false, -- HACK:
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

    vim.opt.shortmess:append 'I' -- disables default dashboard/:intro

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
}
