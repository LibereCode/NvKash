return { -- NOTE: oil🦅 -- good
  'stevearc/oil.nvim',
  opts = function()
    local oil = require 'oil'
    vim.keymap.set('n', '<leader>O', function() oil.open(nil, { preview = { vertical = true } }) end) -- '<CMD>Oil<CR>'
    vim.keymap.set('n', '<leader>e', function() oil.toggle_float() end, { desc = '󰏇 [O]il🦅' })
    return {
      columns = {
        -- 'permissions',
        -- 'size',
        -- 'mtime',
        'icon',
      },
      keymaps = { -- add/append new keymaps
        -- Fast quit
        ['q'] = 'actions.close',
        ['<C-ESC>'] = 'actions.close',
        ['<leader>O'] = 'actions.close', -- toggle

        -- from docs `:h oil-actions`
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
        ['~'] = '<cmd>edit $HOME<CR>',
        ['<localleader>;'] = {
          'actions.open_cmdline',
          opts = {
            shorten_path = true,
            modify = ':h',
          },
          desc = ':ex-mode <cDir>',
        },

        ['<C-d>'] = 'actions.preview_scroll_down',
        ['<C-u>'] = 'actions.preview_scroll_up',
        ['<C-f>'] = 'actions.preview_scroll_right',
        ['<C-b>'] = 'actions.preview_scroll_left',

        ['H'] = { 'actions.parent', mode = 'n' },
        ['L'] = { 'actions.select', mode = 'n' },
        -- ['J'] = { 'actions.show_help', mode = 'n' }, -- ?? idk
        ['K'] = { 'actions.preview', mode = 'n' },
      },

      -- preview_win = {
      --   preview_method = 'load', -- SLOW
      -- },

      delete_to_trash = true, -- :h oil-trash
      default_file_explorer = true, -- false, -- Oil is really good
      view_options = { show_hidden = true },
    }
  end,
}
