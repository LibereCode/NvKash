--
return {
  'mbbill/undotree',
  lazy = false,
  init = function() -- This is how you can implement viml-code-block in lua
    vim.cmd [[
        if has("persistent_undo")
          " let target_path = expand('~/.undodir')
          let target_path = stdpath('state') . "/undo" " Path set in options.lua, seems2work?

          " create the directory and any parent directories
          " if the location does not exist.
          if !isdirectory(target_path)
            call mkdir(target_path, "p", 0700)
          endif

          let &undodir=target_path
          set undofile
        endif
      ]]
    vim.g.undotree_WindowLayout = 3
    -- vim.keymap.set('n', '<LEADER>U', ':UndotreeToggle<CR>', { desc = '[U]ndoTree' })
    vim.keymap.set( -- TEST:
      'n',
      -- '<LEADER>r',
      '<LEADER>u',
      ':UndotreeToggle<CR>',
      -- { desc = 'UndoT[r]ee' }
      { desc = '[u]ndoTree' }
    )
  end,
}
