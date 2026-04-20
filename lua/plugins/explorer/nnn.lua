return { -- nnn -- https://github.com/luukvbaal/nnn.nvim?tab=readme-ov-file --
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
} -- Don't need, and does not match terminal nnn
