return { -- Useful plugin to show you pending keybinds.
  'folke/which-key.nvim',
  event = 'VimEnter',
  ---@module 'which-key'
  ---@type wk.Opts
  ---@diagnostic disable-next-line: missing-fields
  opts = {
    -- delay between pressing a key and opening which-key (milliseconds)
    delay = 0,
    icons = { mappings = vim.g.have_nerd_font },

    -- Document existing key chains
    spec = {
      { '<leader>s', group = 'search', mode = { 'n', 'v' } },
      -- { '<leader>t', group = 'toggle' },
      { '<leader>gh', group = 'Git [H]unk', mode = { 'n', 'v' } }, -- Enable gitsigns recommended keymaps first
      { 'gr', group = 'LSP Actions', mode = { 'n' } },

      -- HACK: add more groups below

      -- <leader>
      { '<leader>b', group = 'buffer', mode = { 'n' } },
      { '<leader>c', group = 'code', mode = { 'n' } },
      { '<leader>d', group = 'debug', mode = { 'n' } },
      { '<leader>g', group = 'git', mode = { 'n' } },
      { '<leader>i', group = 'insert', mode = { 'n' } },
      { '<leader>l', group = 'lazy', mode = { 'n' } },
      { '<leader>m', group = 'markdown', mode = { 'n' } },
      { '<leader>t', group = 'terminal' },
      { '<leader>u', group = 'ui', mode = { 'n' } },
      { '<leader><tab>', group = 'tab', mode = { 'n' } },

      -- goto
    },
  },
}
