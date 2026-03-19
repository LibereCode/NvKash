-- markdown.md, org.org, text.txt, ...
-- For `plugins/markview.lua` users.
return {
   {
      'OXY2DEV/markview.nvim',
      lazy = false,

      -- Completion for `blink.cmp`
      dependencies = { 'saghen/blink.cmp' },

      -- | Commands    | desc                        |
      -- |-------------|-----------------------------|
      -- | Toggle      | Toggles Markview            |
      -- | Enable      | Enables   -||-              |
      -- | Disable     | Disable   -||-              |
      -- | toggle      |   -||-    -||-  for buffer  |
      -- | enable      |   -||-    -||-              |
      -- | disable     |   -||-    -||-              |
      -- | splitToggle | Dual pane = edit/preview    |

      keys = function() -- NOTE: see keybinds in config/keymaps.lua
         return {
            { -- map('n', '<leader>ms', '<CMD>Markview splitToggle<CR>', { desc = 'toggle split' })
               '<leader>ms',
               mode = 'n',
               '<CMD>Markview splitToggle<CR>',
               desc = 'toggle split',
            },
            { -- map('n', '<leader>mt', '<CMD>Markview Toggle<CR>', { desc = 'toggle markview' })
               '<leader>mt',
               mode = 'n',
               '<CMD>Markview Toggle<CR>',
               desc = 'toggle markview',
            },
         }
      end,
   },

   -- todo comments -- Highlight todo, notes, etc in comments
   {
      'folke/todo-comments.nvim',
      event = 'VimEnter',
      dependencies = { 'nvim-lua/plenary.nvim' },
      ---@module 'todo-comments'
      ---@type TodoOptions
      ---@diagnostic disable-next-line: missing-fields
      opts = { signs = true }, -- HACK: false -> true
   },
}
