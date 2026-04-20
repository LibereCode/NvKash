return { -- https://github.com/jakewvincent/mkdnflow.nvim?tab=readme-ov-file#-installation
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
}
