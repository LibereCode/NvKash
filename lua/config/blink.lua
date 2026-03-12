-- ALPHA (ain't no beta)
--  TO use this put this in your plugins table
-- `{ import = "config.lazyspec" },`
-- HACK: Kashnomo modified version

dofile(vim.g.base46_cache .. 'blink') -- ~/.local/share/nvim.dev/lazy/base46/lua/base46/integrations/blink.lua

return {

  opts = {
    snippets = { preset = 'luasnip' },
    cmdline = { enabled = true },
    appearance = { nerd_font_variant = 'normal' },
    fuzzy = { implementation = 'prefer_rust' },
    sources = { default = { 'lsp', 'snippets', 'buffer', 'path' } },

    keymap = {
      preset = 'default',
      ['<C-y>'] = { 'accept', 'fallback' },
      ['<C-CR>'] = { 'accept', 'fallback' },
      ['<C-n>'] = { 'select_next', 'snippet_forward', 'fallback' },
      ['<C-p>'] = { 'select_prev', 'snippet_backward', 'fallback' },
    },

    completion = {
      -- ghost_text = { enabled = true },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
        window = { border = 'single' },
      },

      -- from nvchad/ui plugin
      -- exporting the ui config of nvchad blink menu
      -- helps non nvchad users
      menu = require('nvchad.blink').menu,
    },
  },
  deps = {
    'rafamadriz/friendly-snippets',
    {
      -- snippet plugin
      'L3MON4D3/LuaSnip',
      dependencies = 'rafamadriz/friendly-snippets',
      opts = { history = true, updateevents = 'TextChanged,TextChangedI' },
      config = function(_, opts)
        require('luasnip').config.set_config(opts)

        require 'config.luasnippy' -- INFO: needed to change name? was luasnip before
      end,
    },

    {
      'windwp/nvim-autopairs',
      opts = {
        fast_wrap = {},
        disable_filetype = { 'TelescopePrompt', 'vim' },
      },
    },
  },
}
