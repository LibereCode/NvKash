return {
  opt = {
    keymap = {
      -- For an understanding of why the 'default' preset is recommended,
      -- you will need to read `:help ins-completion`
      -- No, but seriously. Please read `:help ins-completion`, it is really good!
      --
      -- All presets have the following mappings:
      -- <tab>/<s-tab>: move to right/left of your snippet expansion
      -- <c-space>: Open menu or open docs if already open
      -- <c-n>/<c-p> or <up>/<down>: Select next/previous item
      -- <c-e>: Hide menu
      -- <c-k>: Toggle signature help
      --
      -- and presets also have:
      -- {default}
      -- <C-y>: select_and_accept
      -- {super-tab}
      -- <TAB>: function accept else select_and_accept ?
      -- {enter}(CR=enter)
      -- <CR>: accept
      --
      -- See :h blink-cmp-config-keymap for defining your own keymap
      -- NOTE: see: presets under `:h blink-cmp-config-keymap`
      preset = 'default', -- "default" | 'super-tab' | 'enter' | 'none'
      ['<TAB>'] = { 'snippet_forward', 'select_next', 'fallback' },
      ['<S-TAB>'] = { 'snippet_backward', 'select_prev', 'show', 'fallback' }, -- fallback will prolly never happen
      ['<C-y>'] = { 'select_and_accept', 'show' },
      ['<CR>'] = { 'accept', 'fallback' },

      -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
      --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
    },

    appearance = {
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono',
    },

    completion = {
      -- By default, you may press `<c-space>` to show the documentation.
      -- Optionally, set `auto_show = true` to show the documentation after a delay.
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 333,
      },
      menu = { -- LazyVim ref
        draw = {
          treesitter = { 'lsp' },
        },
      },
      ghost_text = {
        enabled = true,
        show_without_selection = true,
      },
      triggers = { -- `:h blink-cmp-config-reference`
        show_on_backspace = true,
        show_on_insert = true,
      },
    },

    sources = {
      default = { 'lsp', 'path', 'snippets' }, -- 'buffer' "buffer" show autocomplete of buffer text
      -- HACK: If I figure out how to give low prio, then maybe add 'buffer'
      providers = {
        mkdnflow = {
          name = 'Mkdnflow',
          module = 'mkdnflow.completion.blink',
        },
      },
    },

    cmdline = { -- LazyVim
      enabled = true,
      keymap = {
        preset = 'cmdline',
        ['<Right>'] = false,
        ['<Left>'] = false,
      },
      completion = {
        list = { selection = { preselect = false } },
        menu = { -- NOTE: I think this enables autosuggest -- GOATED
          auto_show = function(ctx) return vim.fn.getcmdtype() == ':' end, -- show only on :command and not elsewhere (else where exactly?)
        },
        ghost_text = { enabled = true },
      },
    },

    snippets = { preset = 'luasnip' },

    -- See :h blink-cmp-config-fuzzy for more information
    -- fuzzy = { implementation = 'lua' },
    fuzzy = { implementation = 'prefer_rust_with_warning' },

    -- Shows a signature help window while you type arguments for a function
    signature = { enabled = true },
  },
}
