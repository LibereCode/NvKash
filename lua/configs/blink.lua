return { -- NOTE: Autocompletion
  'saghen/blink.cmp',
  event = 'VimEnter',
  version = '1.*',
  dependencies = {
    -- Snippet Engine
    {
      'L3MON4D3/LuaSnip',
      version = '2.*',
      build = (function()
        -- Build Step is needed for regex support in snippets.
        -- This step is not supported in many windows environments.
        -- Remove the below condition to re-enable on windows.
        if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then return end
        return 'make install_jsregexp'
      end)(),
      dependencies = { -- deps inside deps
        -- `friendly-snippets` contains a variety of premade snippets.
        --    See the README about individual language/framework/plugin snippets:
        --    https://github.com/rafamadriz/friendly-snippets
        {
          'rafamadriz/friendly-snippets',
          config = function() require('luasnip.loaders.from_vscode').lazy_load() end,
        },
      },
      opts = {
        -- NOTE: see plugins/util/luasnip.lua (put the snippets here)
      },
    },

    { 'folke/neodev.nvim', enabled = false }, -- make sure to uninstall or disable neodev.nvim
    {
      'folke/lazydev.nvim',
      ft = 'lua', -- only load on lua files
      opts = {
        library = {
          -- See the configuration section for more details
          -- Load luvit types when the `vim.uv` word is found
          { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
        },
        -- enabled = function(root_dir)
        --   return not vim.uv.fs_stat(root_dir .. "/.luarc.json")
        -- end,
      },
      keys = {
        { '<leader>ld', '<CMD>LazyDev lsp<CR>' },
      },
      -- enabled = function(root_dir) return not vim.uv.fs_stat(root_dir .. '/.luarc.json') end, -- WARN: bricks config
    },

    { -- NOTE: https://github.com/mikavilpas/blink-ripgrep.nvim#minimal-config
      'mikavilpas/blink-ripgrep.nvim',
      version = '*',
    },
  },
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      -- For an understanding of why the 'default' preset is recommended,
      -- you will need to read `:help ins-completion`
      -- No, but seriously. Please read `:help ins-completion`, it is really good!
      -- NOTE: See :h blink-cmp-config-keymap for defining your own keymap
      --
      preset = 'none', -- 'default' -- 'default'|'super-tab'|'enter'|'none'
      -- TEST: Just disable presets and copy over entire preset 'DEFAULT'

      -- ['<CR>'] = { 'accept', 'fallback' },
      ['<C-CR>'] = { 'accept_and_enter', 'fallback' },
      ['<C-c>'] = { 'cancel', 'fallback' },

      -- ['<C-space>'] = { function(cmp) cmp.show { providers = { 'snippets' } } end }, -- show only specific cmp
      ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
      ['<C-e>'] = { 'show', 'cancel', 'fallback' },
      ['<C-y>'] = { 'select_and_accept', 'show', 'fallback' },
      -- ['<C-j>'] = { 'select_and_accept', 'fallback' }, -- NOTE: remaps C-j (was newline). use C-m instead for newline (by default)

      ['<C-l>' --[['<C-;>']]] = { 'select_and_accept', 'fallback' }, -- TEST: instead of C-j

      ['<Up>'] = { 'select_prev', 'fallback' },
      ['<Down>'] = { 'select_next', 'fallback' },
      ['<C-p>'] = { 'select_prev', 'snippet_backward', 'fallback_to_mappings' },
      ['<C-n>'] = { 'select_next', 'snippet_forward', 'fallback_to_mappings' },

      ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
      ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

      -- ['<TAB>'] = { 'snippet_forward','select_next', 'fallback' },
      -- ['<S-TAB>'] = { 'snippet_backward','select_prev', 'show', 'fallback' },
      ['<Tab>'] = { 'snippet_forward', 'fallback' },
      ['<S-Tab>'] = { 'snippet_backward', 'fallback' },

      [ --[['<C-k>']]'<C-h>'] = { 'show_signature', 'hide_signature', 'fallback' }, -- default

      -- ['<Esc>'] = { 'cancel', 'fallback' }, -- hated it

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
        auto_show_delay_ms = 345,
      },
      menu = { -- LazyVim ref
        draw = {
          treesitter = { 'lsp' },
        },
        auto_show = false, -- TEST: see :h blink-cmp-config-completion # GHOST TEXT
      },
      ghost_text = {
        enabled = true,
        show_without_selection = true,
      },
      trigger = { -- `:h blink-cmp-config-reference`
        show_on_backspace_in_keyword = true,
        -- show_on_insert = true,
      },
    },
    snippets = { -- :h blink-cmp-config-snippets
      preset = 'luasnip',
    },

    sources = {
      default = {
        'lazydev',
        'lsp',
        'path',
        'snippets',
        'buffer',
        'ripgrep',
      },
      providers = {
        snippets = {
          opts = { -- :h blink-cmp-config-reference # PROVIDERS # snippets
            -- Whether to use show_condition for filtering snippets
            use_show_condition = true,
            -- Whether to show autosnippets in the completion list
            show_autosnippets = true,
            -- Whether to prefer docTrig placeholders over trig when expanding regTrig snippets
            prefer_doc_trig = false,
            -- Whether to put the snippet description in the label description
            use_label_description = false, -- false
          },
        },

        path = { opts = { show_hidden_files_by_default = true } },

        buffer = { score_offset = -100 }, -- TEST: lower prio (was a bit spammy, and ripgrep instead)

        mkdnflow = {
          name = 'Mkdnflow',
          module = 'mkdnflow.completion.blink',
        },

        lazydev = {
          name = 'LazyDev',
          module = 'lazydev.integrations.blink',
          -- make lazydev completions top priority (see `:h blink.cmp`)
          score_offset = 100,
        },

        ripgrep = {
          module = 'blink-ripgrep',
          name = 'Ripgrep',
          -- See full config at: https://github.com/mikavilpas/blink-ripgrep.nvim#minimal-config
          ---@module "blink-ripgrep"
          ---@type blink-ripgrep.Options
          opts = {
            prefix_min_len = 2, -- 3
            backend = {
              use = 'gitgrep-or-ripgrep', -- ripgrep
              ripgrep = {
                search_casing = '--smartcase',
              },
            },
            project_root_marker = { '.git', '.luarc.json', '.editorconfig', 'pyproject.toml' },
            -- debug = true, -- false
          },
          score_offset = -50, -- prio other completions
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

    -- See :h blink-cmp-config-fuzzy for more information
    fuzzy = { implementation = 'prefer_rust_with_warning' },

    -- Shows a signature help window while you type arguments for a function
    signature = { enabled = true },
  },
}
