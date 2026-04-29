return { -- NOTE: oil🦅 -- good
  'stevearc/oil.nvim',
  opts = function()
    vim.keymap.set('n', '<leader>O', '<CMD>Oil<CR>')
    vim.keymap.set('n', '<leader>e', function() require('oil').toggle_float() end, { desc = '󰏇 [O]il🦅' })
    return {
      columns = {
        -- 'permissions',
        -- 'size',
        -- 'mtime',
        'icon',
      },
      keymaps = { -- add/append new keymaps
        ['<localleader>f'] = { -- from :h oil-actions -- Changes <leader>ff for just oil-buffer
          function()
            require('telescope.builtin').find_files {
              cwd = require('oil').get_current_dir(),
            }
          end,
          mode = 'n',

          nowait = true,
          desc = '[f]iles (oil)',
        },

        -- Fast quit
        ['q'] = 'actions.close',
        ['<ESC><ESC>'] = 'actions.close',
        ['<leader>O'] = 'actions.close',

        ['<localleader>:'] = {
          'actions.open_cmdline',
          opts = {
            shorten_path = true,
            modify = ':h',
          },
          desc = ':ex-mode <cDir>',
        },
      },
      delete_to_trash = true, -- :h oil-trash
      default_file_explorer = true, -- false, -- Oil is really good
      view_options = { show_hidden = true },
    }
  end,
}
