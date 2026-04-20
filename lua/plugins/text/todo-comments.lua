return { -- todo comments -- Highlight todo, notes, etc in comments
  'folke/todo-comments.nvim',
  event = 'VimEnter',
  dependencies = { 'nvim-lua/plenary.nvim' },
  ---@module 'todo-comments'
  ---@type TodoOptions
  ---@diagnostic disable-next-line: missing-fields
  opts = function(_, opts)
    vim.keymap.set('n', '<leader>dq', '<CMD>TodoQuickFix<CR>', { desc = '[q]uickfix' })
    return {
      signs = true, -- HACK: false -> true
    }
  end,
}
