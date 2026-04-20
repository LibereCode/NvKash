return { -- Useful plugin to show you pending keybinds.
  'folke/which-key.nvim',
  event = 'VimEnter',
  ---@module 'which-key'
  -- ---@type wk.Opts
  ---@diagnostic disable-next-line: missing-fields
  opts = function(_, opts)
    -- vim.keymap.set('n', 'W', '<CMD>WhichKey<CR>', { desc = 'WhichKey[W]all' }) -- no leader?
    vim.keymap.set('n', '<leader>?', '<CMD>WhichKey<CR>', { desc = 'WhichKey[?]' })
    return {
      preset = 'helix', -- false|"classic"|"modern"|"helix"
      -- delay between pressing a key and opening which-key (milliseconds)
      delay = 21,
      icons = { mappings = vim.g.have_nerd_font },

      -- Document existing key chainswhic
      spec = {
        -- { '<leader>s', group = 'search', mode = { 'n', 'v' } },
        -- { '<leader>t', group = 'toggle' },
        { '<leader>gh', group = 'Git [H]unk', mode = { 'n', 'v' } }, -- Enable gitsigns recommended keymaps first
        { 'gr', group = 'LSP Actions', mode = { 'n' } },

        -- HACK: add more groups below

        -- <leader>
        { '<leader>c', group = 'code', mode = { 'n', 'v' } },
        { '<leader>d', group = 'debug', mode = { 'n' } },
        { '<leader>g', group = 'git', mode = { 'n' } },
        { '<leader>i', group = 'insert', mode = { 'n' } },
        { '<leader>l', group = 'lazy', mode = { 'n' } },
        -- { '<leader>m', group = 'text/[m]arkdown', mode = { 'n' } }, -- I use <localleader> instead
        { '<leader>o', group = 'open/[o]rganize', mode = { 'n' } }, -- includes my `custom.journal`
        { '<leader>t', group = 'terminal' },
        { '<leader>u', group = 'ui', mode = { 'n' } },
        { '<leader><tab>', group = 'tab', mode = { 'n' } },
        { '<leader>s', group = 'search/[s]elect', mode = { 'n', 'v' } },
        { '<leader>f', group = 'find/[f]iles', mode = { 'n' } },
        { '<leader>q', group = 'session/[q]uit', mode = { 'n' } },

        -- <leader> subgroups
        { '<leader>bo', group = 'order', mode = { 'n' } },
        { '<leader>sl', group = 'LSP actions', mode = { 'n' } },

        -- goto
        { 'gs', group = 'surround', mode = { 'n', 'v' } },

        { -- create <leader>b{n} where {n} is other buffers
          '<leader>b',
          group = '[b]buffer',
          expand = function() return require('which-key.extras').expand.buf() end,
        },
        {
          '<leader>w',
          group = '[w]windows',
          proxy = '<c-w>',
          expand = function() return require('which-key.extras').expand.win() end,
        },
        -- TODO: Move (most) groups to their respective plugin with
        --    `require('which-key').add({
        --      { '<leader>key', group = "foobar" },
        --    })`
      },
    }
  end,
}
