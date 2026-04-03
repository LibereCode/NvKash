-- markdown.md, org.org, text.txt, ...
-- For `plugins/markview.lua` users.
return {
  {
    'OXY2DEV/markview.nvim',
    lazy = false,
    dependencies = { 'saghen/blink.cmp' }, -- Completion for `blink.cmp`
    keys = function() -- NOTE: see keybinds in config/keymaps.lua
      return {
        { -- map('n', '<leader>ms', '<CMD>Markview splitToggle<CR>', { desc = 'toggle split' })
          '<localleader>s',
          mode = 'n',
          '<CMD>Markview splitToggle<CR>',
          desc = 'toggle [s]plit',
          ft = 'markdown',
        },
        { -- map('n', '<leader>mt', '<CMD>Markview Toggle<CR>', { desc = 'toggle markview' })
          '<localleader>m',
          mode = 'n',
          '<CMD>Markview Toggle<CR>',
          desc = 'toggle [m]arkview',
          ft = 'markdown',
        },
      }
    end,
    opts = {
      preview = {
        enable = true,
        icon_provider = 'devicons', -- "mini" or "devicons"
        hybrid_modes = { 'n' },
        -- linewise_hybrid_mode = true, -- default is basically a better version
      },
    },
  },
  { -- https://github.com/jakewvincent/mkdnflow.nvim?tab=readme-ov-file#-installation
    'jakewvincent/mkdnflow.nvim',
    ft = { 'markdown', 'rmd' },
    opts = {
      modules = { completion = true },
      tables = {
        auto_extend_rows = true,
        -- auto_extend_cols = true,
      },
    },
    keys = function() -- replace with new table of mappings
      local function mmap(keys, cmd, desc) return { keys, cmd, ft = 'markdown', desc = desc } end
      return { -- TEST: <leader>m --> <localleader>
        mmap('<localleader>l', '<Cmd>MkdnFollowLink<CR>', 'Follow link'),
        mmap('<CR>', '<Cmd>MkdnEnter<CR>', 'Mkdn enter'),
        mmap('<localleader>y', '', 'yank'),
        mmap('<localleader>ya', '<Cmd>MkdnYankAnchorLink<CR>', 'Yank Anchorlink'),
        mmap('<localleader>yf', '<Cmd>MkdnYankFileAnchorLink<CR>', 'Yank FileAnchorlink'),
        mmap('<localleader>t', '<Cmd>MkdnToggleToDo<CR>', 'Toggle TODO'),
        mmap('<localleader>n', '<Cmd>MkdnUpdateNumbering<CR>', 'Update Numbering'),
        mmap('<localleader>i', '', 'insert table'),
        mmap('<localleader>ir', '<Cmd>MkdnTableNewRowBelow<CR>', 'Table new Row Down'),
        mmap('<localleader>iR', '<Cmd>MkdnTableNewRowAbove<CR>', 'Table new Row Up'),
        mmap('<localleader>ic', '<Cmd>MkdnTableNewColAfter<CR>', 'Table new Column Right'),
        mmap('<localleader>iC', '<Cmd>MkdnTableNewColBefore<CR>', 'Table new Column Left'),
        mmap('<localleader>d', '', 'table delete...'),
        mmap('<localleader>dr', '<Cmd>MkdnTableDeleteRow<CR>', 'Table Delete Row'),
        mmap('<localleader>dc', '<Cmd>MkdnTableDeleteCol<CR>', 'Table Delete Column'),
        mmap('<localleader>f', '<Cmd>MkdnFoldSection<CR>', 'md Fold'),
        mmap('<localleader>F', '<Cmd>MkdnUnfoldSection<CR>', 'md UnFold'),
        mmap('<localleader>L', '<Cmd>MkdnCreateLinkFromClipboard<CR>', 'Create [L]ink Clipboard'),
      }
    end,
  },

  { -- todo comments -- Highlight todo, notes, etc in comments
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    ---@module 'todo-comments'
    ---@type TodoOptions
    ---@diagnostic disable-next-line: missing-fields
    opts = function(_, opts)
      vim.keymap.set('n', '<leader>xt', '<CMD>TodoQuickFix<CR>', { desc = '[t]odo quickfix' })
      return {
        signs = true, -- HACK: false -> true
      }
    end,
  },

  -- orgmode.org
  --
  -- 'nvim-neorg/neorg', -- I fucking hate neorg -- https://github.com/nvim-neorg/neorg
  --
  { -- https://nvim-orgmode.github.io/
    'nvim-orgmode/orgmode',
    event = 'VeryLazy',
    ft = { 'org' },
    keys = { -- INFO: default: https://nvim-orgmode.github.io/configuration#mappings
      { '<leader>oh', mode = 'n', '<CMD>Org help<CR>', desc = '[h]elp' },
      { '<leader>oH', mode = 'n', '<CMD>Org helpgrep<CR>', desc = '[H]elpgrep' },
    },
    opts = {
      -- Setup orgmode
      org_agenda_files = '~/Notes/Org/**/*',
      org_default_notes_file = '~/Notes/Org/refile.org',
    },
  },
}
