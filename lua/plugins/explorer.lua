return { -- file-managers/explorers
  {
    ---@type LazySpec
    'mikavilpas/yazi.nvim',
    version = '*', -- use the latest stable version
    event = 'VeryLazy',
    dependencies = {
      { 'nvim-lua/plenary.nvim', lazy = true },
      -- {
      --   'princejoogie/chafa.nvim', -- Image preview fallback -- funkar... typ... (pretty badly)
      --   dependencies = {
      --     'nvim-lua/plenary.nvim',
      --     'm00qek/baleia.nvim',
      --   },
      --   opts = {},
      -- },
    },
    keys = { -- 👇 in this section, choose your own keymappings!
      { -- Open in the current working directory
        '<leader>y',
        '<cmd>Yazi toggle<cr>',
        desc = 'toggle [y]azi',
      },
      { -- 1000iq move -- smoort (I can toogle noow)
        '<leader>y',
        'q',
        mode = { 't' },
      },
      { -- "<C-->", -- "<c-up>",
        '<C-y>',
        '<cmd>Yazi cwd<cr>',
        desc = '[y]azi',
      },
    },
    opts = {
      keymaps = {
        show_help = '<f1>',
        -- cycle_open_buffers = false,
        -- OR
        cycle_open_buffers = '<S-Tab>',
      },
      -- 👇 if you want to open yazi instead of netrw
      open_for_directories = true,
      -- cd on quit
      change_neovim_cwd_on_close = true,
      yazi_floating_window_winblend = 10, -- 0-100
      -- yazi_floating_window_border =
    },
    init = function() -- 👇 if you use `open_for_directories=true`, this is recommended
      -- mark netrw as loaded so it's not loaded at all. -- https://github.com/mikavilpas/yazi.nvim/issues/802
      vim.g.loaded_netrwPlugin = 1
    end,
  },

  -- Neo-tree is a Neovim plugin to browse the file system
  -- https://github.com/nvim-neo-tree/neo-tree.nvim
  ---@module 'lazy'
  ---@type LazySpec
  {
    'nvim-neo-tree/neo-tree.nvim',
    version = '*',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      -- 'nvim-mini/mini.icons', -- HACK:
      'MunifTanjim/nui.nvim',
      '3rd/image.nvim', -- See plugins.ui
    },
    lazy = false,
    keys = {
      { '<C-e>', ':Neotree float reveal_force_cwd toggle<CR>', desc = 'float N[e]oTree', silent = true },
      { '<leader>e', ':Neotree left reveal_force_cwd toggle<CR>', desc = 'left N[e]oTree', silent = true },
      -- { '<leader>E', ':Neotree current reveal_force_cwd toggle<CR>', desc = 'N[E]O-NetRC', silent = true },
    },
    ---@module 'neo-tree'
    ---@type neotree.Config
    opts = { -- https://github.com/nvim-neo-tree/neo-tree.nvim?tab=readme-ov-file#configuration
      close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
      enable_git_status = true,
      enable_diagnostics = true,
      filesystem = {
        window = {
          mappings = {
            ['<C-e>'] = 'close_window',
            ['l'] = 'open',
            ['h'] = 'close_node',
            ['L'] = 'set_root',
            ['H'] = 'navigate_up',
            ['.'] = 'toggle_hidden',
            ['q'] = 'close_window',
            ['P'] = {
              'toggle_preview',
              config = {
                use_float = false,
                -- use_snacks_image = false,
                use_image_nvim = true,
              },
            },
          },
        },
        hijack_netrw_behavior = 'disabled', -- 'disabled'|'open_default'|'open_current' -- weird ass name -- 'disabled' = allows to open yazi by default
      },
    },
  },

  -- { 'stevearc/oil.nvim', keys = { { '<leader>o', '<CMD>Oil<CR>' } }, opts = { default_file_explorer = false } }, -- NOTE: oil🦅 -- good, but doesn't fit

  { -- nnn -- https://github.com/luukvbaal/nnn.nvim?tab=readme-ov-file
    'luukvbaal/nnn.nvim',
    opts = function(_, opts) -- conf options: https://github.com/luukvbaal/nnn.nvim?tab=readme-ov-file
      vim.keymap.set('n', '<leader>p', '<CMD>NnnPicker<CR>')
      vim.keymap.set('n', '<leader>n', '<CMD>NnnExplorer<CR>')

      local nbn = require('nnn').builtin
      return {
        explorer = {
          cmd = 'nnn -Ure',
        },
        picker = {
          -- cmd = 'tmux new-session nnn -Pp', -- What?
          cmd = 'nnn -Pp -Urde',
          style = { border = 'shadow' },
          session = 'shared',
          -- fullscreen = false,
        },
        -- auto_close = true, -- fucked me
        -- replace_netrw = 'picker',
        mappings = {
          { '<C-t>', nbn.open_in_tab }, -- open file(s) in tab
          { '<C-s>', nbn.open_in_split }, -- open file(s) in split
          { '<C-v>', nbn.open_in_vsplit }, -- open file(s) in vertical split
          { '<C-p>', nbn.open_in_preview }, -- open file in preview split keeping nnn focused
          { '<C-y>', nbn.copy_to_clipboard }, -- copy file(s) to clipboard
          { '<C-w>', nbn.cd_to_path }, -- cd to file directory
          { '<C-e>', nbn.populate_cmdline }, -- populate cmdline (:) with file(s)
        },
        windownav = {
          left = '<C-h>',
          right = '<C-l>',
        },
        quitcd = 'cd',
        -- offset = true,
      }
    end,
  },
}
