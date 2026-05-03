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

      opts = function(_, opts)
        local ls = require 'luasnip'

        local lsmap = function(key, cmd, mapOpts, mode)
          mode = mode or 'n'
          vim.keymap.set(mode, key, cmd, mapOpts)
        end
        lsmap('<M-e>'--[['<C-l>' '<C-k'>]], function() ls.expand() end, { silent = true }, 'i') --
        lsmap('<M-n>'--[['<C-k>' '<C-l'>]], function() ls.jump(1) end, { silent = true }, { 'i', 's' })
        lsmap('<M-p>'--[['<C-j>']], function() ls.jump(-1) end, { silent = true }, { 'i', 's' })
        lsmap('<M-c>'--[['<C-e>']], function() -- What is this? Change-active-choice?
          if ls.choice_active() then ls.change_choice(1) end
        end, { silent = true }, { 'i', 's' })

        --   local s = ls.snippet
        --   local t = ls.text_node
        --   local i = ls.insert_node
        --   ls.add_snippets( -- TODO: get to work
        --     'all',
        --     s('helloSnip', { t 'test ', i(1), t 'test again', i(2) })
        --   )
        --   return vim.tbl_extend('force', opts, {})
      end,
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

      ['<Up>'] = { 'select_prev', 'fallback' },
      ['<Down>'] = { 'select_next', 'fallback' },
      ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
      ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },

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

    snippets = { preset = 'luasnip' },

    sources = {
      default = { 'lsp', 'lazydev', 'path', 'snippets', 'buffer' },
      -- TODO Find out how to Lower prio of 'buffer'
      providers = {
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
