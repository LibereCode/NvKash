-- For example, in the following configuration, we use:
--  event = 'VimEnter' which loads which-key before all the UI elements are loaded. Events can be
-- normal autocommands events (`:help autocmd-events`).
-- Then, because we use the `opts` key (recommended), the configuration runs
-- after the plugin has been loaded as `require(MODULE).setup(opts)`.

return {
  'folke/which-key.nvim',
  event = 'VimEnter',
  opts = {
    preset = 'helix', -- false|"classic"|"modern"|"helix"
    defaults = {},
    icons = { mappings = vim.g.have_nerd_font },
    delay = 0, -- delay between pressing a key and opening which-key (milliseconds)
    spec = {
      { -- Document existing key chains

        -- { '<leader><tab>', group = 'tabs' },
        { '<leader>c', group = 'code[c]' },
        { '<leader>d', group = 'debug[d]' },
        { '<leader>dp', group = 'profiler[p]' },
        { '<leader>q', group = 'session/[q]uit' },
        { '<leader>u', group = 'ui[u]' },
        { 'z', group = 'fold[z]' },
        { '<leader>x', group = 'diagnostics/quickfi[x]' },

        { '[', group = '[prev', mode = { 'n', 'v', 'x' } },
        { ']', group = 'next]', mode = { 'n', 'v', 'x' } },
        { 'g', group = '[g]oto', mode = { 'n', 'v', 'x' } },

        { '<leader>f', group = 'find/[f]ile' }, -- TODO: ändra namn så jag får symboler
        { '<leader>s', group = 'search/[s]elect', mode = { 'n', 'v' } },

        { '<leader>g', group = 'git[g]', mode = { 'n', 'v' } }, -- wtf is git Hunk ?? Removed it
        { 'gr', group = 'LSP [r]efer', mode = { 'n', 'v' } }, -- Not needed

        { '<leader>m', group = '[m]markdown', mode = { 'n', 'v' } },
        { 'gs', group = '[s]surround', mode = { 'n', 'v' } },
        -- { '<leader>l', group = '[l]sp' },
        { '<leader>n', group = '[n]otication/News' },
        { '<leader>o', group = '[o]rg-mode' },
        { '<leader>t', group = 'terminal[t]' },
        { '<leader>l', group = 'lazy[l]' },
        { '<leader>W', group = '[W]hich?' },

        { '<leader>gh', group = 'github[h]' }, -- Github
        { '<leader>ca', group = 'c[a]lls' }, -- code calls
        { '<leader>gt', group = 'gi[t]toggle' }, -- git
        { '<leader>sn', group = 'noice' }, -- search

        {
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

        -- better descriptions
        { 'gx', desc = '[x]dg-open' },
      },
    },
  },
}
