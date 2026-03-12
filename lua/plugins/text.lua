return { -- "plaintext", like .txt, .md, .org
  -- Markdown.md
  {
    'jakewvincent/mkdnflow.nvim',
    ft = { 'markdown', 'rmd' },
    opts = {
      mappings = {
        MkdnFollowLink = false, -- Disable default
        MkdnEnter = false,
        MkdnYankAnchorLink = false,
        MkdnYankFileAnchorLink = false,
        MkdnToggleToDo = false,
        MkdnNewListItem = false,
        MkdnExtendList = false,
        MkdnUpdateNumbering = false,
        MkdnTableNextRow = false,
        MkdnTableNewRowBelow = false,
        MkdnTableNewRowAbove = false,
        MkdnTableNewColAfter = false,
        MkdnTableNewColBefore = false,
        MkdnTableDeleteRow = false,
        MkdnTableDeleteCol = false,
        MkdnFoldSection = false,
        MkdnUnfoldSection = false,
        MkdnTab = false,
        MkdnSTab = false,
        MkdnCreateLink = false,
        MkdnCreateLinkFromClipboard = false,
      },
    },
    keys = {
      { '<leader>ml', '<Cmd>MkdnFollowLink<CR>', ft = 'markdown', desc = 'Follow link' },
      { '<CR>', '<Cmd>MkdnEnter<CR>', ft = 'markdown', desc = 'Mkdn enter' },
      { '<leader>mya', '<Cmd>MkdnYankAnchorLink<CR>', ft = 'markdown', desc = 'Yank Anchorlink' },
      { '<leader>myf', '<Cmd>MkdnYankFileAnchorLink<CR>', ft = 'markdown', desc = 'Yank FileAnchorlink' },
      { '<leader>mt', '<Cmd>MkdnToggleToDo<CR>', ft = 'markdown', desc = 'Toggle TODO' },
      { '<leader>mn', '<Cmd>MkdnUpdateNumbering<CR>', ft = 'markdown', desc = 'Update Numbering' },
      { '<leader>mir', '<Cmd>MkdnTableNewRowBelow<CR>', ft = 'markdown', desc = 'Table new Row Down' },
      { '<leader>miR', '<Cmd>MkdnTableNewRowAbove<CR>', ft = 'markdown', desc = 'Table new Row Up' },
      { '<leader>mic', '<Cmd>MkdnTableNewColAfter<CR>', ft = 'markdown', desc = 'Table new Column Right' },
      { '<leader>miC', '<Cmd>MkdnTableNewColBefore<CR>', ft = 'markdown', desc = 'Table new Column Left' },
      { '<leader>mdr', '<Cmd>MkdnTableDeleteRow<CR>', ft = 'markdown', desc = 'Table Delete Row' },
      { '<leader>mdc', '<Cmd>MkdnTableDeleteCol<CR>', ft = 'markdown', desc = 'Table Delete Column' },
      { '<leader>mf', '<Cmd>MkdnFoldSection<CR>', ft = 'markdown', desc = 'md Fold' },
      { '<leader>mF', '<Cmd>MkdnUnfoldSection<CR>', ft = 'markdown', desc = 'md UnFold' },
      { '<leader>mp', '<Cmd>MkdnCreateLinkFromClipboard<CR>', ft = 'markdown', desc = 'Create Link Clipboard' },
    },
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    ft = { 'markdown', 'rmd' },
    opts = {
      code = {
        sign = true,
        width = 'block',
        right_pad = 1,
      },
      heading = {
        sign = true,
        icons = { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' },
      },
      checkbox = {
        enabled = true,
      },
    },
  },

  -- orgmode.org
  {
    'nvim-orgmode/orgmode',
    event = 'VeryLazy',
    ft = { 'org' },
    opts = {
      -- Setup orgmode
      org_agenda_files = '~/Notes/Org/**/*',
      org_default_notes_file = '~/Notes/Org/refile.org',
    },
  },
  -- {
  --     "nvim-neorg/neorg",
  --     -- lazy-load on filetype
  --     ft = "norg",
  --     -- options for neorg. This will automatically call `require("neorg").setup(opts)`
  --     opts = {
  --         load = {
  --             ["core.defaults"] = {},
  --         },
  --     },
  -- },
}
