-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(
-- Dir/file is ~/.local/share/nvim.dev/lazy/ui/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = 'obsidian-ember', -- 'kanagawa-dragon',
  transparency = false,
  -- theme_toggle = { 'obsidian-ember', 'solarized_osaka' },

  hl_override = {
    Comment = { italic = true },
    ['@comment'] = { italic = true },
  },
}

M.ui = {
  statusline = {
    theme = 'default', -- default/vscode/vscode_colored/minimal
    separator_style = 'block', -- default{default|round|block|arrow} || minimal{round|block}
    order = nil,
    modules = nil,
  },

  telescope = { style = 'bordered' }, -- NOTE: mycket bättre

  tabufline = {
    order = { 'treeOffset', 'buffers', 'tabs', 'foobar' }, -- 'btns',
    modules = {
      foobar = function() return 'sug kuk' end,
    },
    treeOffsetFt = 'neo-tree',
    bufwidth = 21,
  },
}

M.nvdash = {
  load_on_startup = true,
  header = {
    '*------------------------------------------------*',
    '|    .-----------------------.                   |',
    '|    |  ▄▄         ▄       ▄▄|    .-----.        |',
    '|    |▄▀███▄     ▄██     ▄███|    | === |        |',
    '|    |██▄▀███▄   ███   ▄███▀ |    |-----|        |',
    '|    |███  ▀███▄ ███ ▄███▀   |    | === |        |',
    '|    |███    ▀██ ███ ███▄    |    |-----|        |',
    '|    |███      ▀ ███  ▀███▄  |    |:::::|        |',
    '|    |▀██        ▀██    ▀███▄|    | ::: |        |',
    '|    |  ▀          ▀      ▀▀▀|    |____o|        |',
    "|    ')---------------------('  ____________     |",
    "|    '::::::::::'  '::::::::::' '  no mouse '    |",
    "|   ':::========'  '==hjkl==:::' '  required '   |",
    "|  '------------'  '------------' '-----------'  |",
    '|              Powered by  eovim              |',
    '*-------------------------------------------------*',
  },
  buttons = {
    { txt = '  [n]ew file', keys = 'n', cmd = 'enew' },
    { txt = '  [f]ind files', keys = 'f', cmd = 'Telescope find_files' },
    { txt = '  [o]ld files', keys = 'o', cmd = 'Telescope oldfiles' },
    { txt = '󰈭  [g]rep', keys = 'g', cmd = 'Telescope live_grep' },
    { txt = '󱥚  [t]hemes', keys = 't', cmd = "lua require('nvchad.themes').open()" },
    { txt = '  Nv[c]heatSheet', keys = 'c', cmd = 'NvCheatsheet' },
    { txt = '󰒲  [l]azy', keys = 'l', cmd = 'Lazy' },
    { txt = '󰩈  [q]uit', keys = 'q', cmd = 'quit' },
    -- TODO: add options:
    -- - [?] New file
    -- - [ ] Config

    { txt = '─', hl = 'NvDashFooter', no_gap = true, rep = true },

    {
      txt = function()
        local stats = require('lazy').stats()
        local ms = math.floor(stats.startuptime) .. ' ms'
        return '  Loaded ' .. stats.loaded .. '/' .. stats.count .. ' plugins in ' .. ms
      end,
      hl = 'NvDashFooter',
      no_gap = true,
      content = 'fit',
    },

    { txt = '─', hl = 'NvDashFooter', no_gap = true, rep = true },
  },
}

return M
