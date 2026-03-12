dofile(vim.g.base46_cache .. 'lsp') -- Ensures that lsp follows theme
-- ~/.local/share/nvim.dev/lazy/base46/lua/base46/integrations/lsp.lua

return {
  deps = {
    -- Automatically install LSPs and related tools to stdpath for Neovim
    -- Mason must be loaded before its dependents so we need to set it up here.
    -- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`

    { 'mason-org/mason.nvim', opts = {} },
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    -- Useful status updates for LSP.
    { 'j-hui/fidget.nvim', opts = {} },
    -- Allows extra capabilities provided by blink.cmp
    'saghen/blink.cmp',
  },
  confkick = function() -- HACK: Kickstart version
    --
    -- Brief aside: **What is LSP?**
    --
    -- LSP is an initialism you've probably heard, but might not understand what it is.
    --
    -- LSP stands for Language Server Protocol. It's a protocol that helps editors
    -- and language tooling communicate in a standardized fashion.
    --
    -- In general, you have a "server" which is some tool built to understand a particular
    -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
    -- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
    -- processes that communicate with some "client" - in this case, Neovim!
    --
    -- LSP provides Neovim with features like:
    --  - Go to definition
    --  - Find references
    --  - Autocompletion
    --  - Symbol Search
    --  - and more!
    --
    -- Thus, Language Servers are external tools that must be installed separately from
    -- Neovim. This is where `mason` and related plugins come into play.
    --
    -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
    -- and elegantly composed help section, `:help lsp-vs-treesitter`

    --  This function gets run when an LSP attaches to a particular buffer.
    --    That is to say, every time a new file is opened that is associated with
    --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
    --    function will be executed to configure the current buffer
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
      callback = function(event)
        -- NOTE: Remember that Lua is a real programming language, and as such it is possible
        -- to define small helper and utility functions so you don't have to repeat yourself.
        --
        -- In this case, we create a function that lets us more easily define mappings specific
        -- for LSP related items. It sets the mode, buffer and description for us each time.
        local map = function(keys, func, desc, mode)
          mode = mode or 'n'
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        -- Rename the variable under your cursor.
        --  Most Language Servers support renaming across files, etc.
        map('grn', vim.lsp.buf.rename, '[R]e[n]ame')

        -- Execute a code action, usually your cursor needs to be on top of an error
        -- or a suggestion from your LSP for this to activate.
        map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })

        -- WARN: This is not Goto Definition, this is Goto Declaration.
        --  For example, in C this would take you to the header.
        map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

        -- The following two autocommands are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        --    See `:help CursorHold` for information about when this is executed
        -- When you move your cursor, the highlights will be cleared (the second autocommand).
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client:supports_method('textDocument/documentHighlight', event.buf) then
          local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })

          vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
            end,
          })
        end

        -- The following code creates a keymap to toggle inlay hints in your
        -- code, if the language server you are using supports them
        -- This may be unwanted, since they displace some of your code
        if client and client:supports_method('textDocument/inlayHint', event.buf) then
          map('<leader>th', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }) end, '[T]oggle Inlay [H]ints')
        end
      end,
    })

    -- LSP servers and clients are able to communicate to each other what features they support.
    --  By default, Neovim doesn't support everything that is in the LSP specification.
    --  When you add blink.cmp, luasnip, etc. Neovim now has *more* capabilities.
    --  So, we create new capabilities with blink.cmp, and then broadcast that to the servers.
    local capabilities = require('blink.cmp').get_lsp_capabilities()

    -- Enable the following language servers
    --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
    --  See `:help lsp-config` for information about keys and how to configure
    local servers = {
      clangd = {},
      gopls = {},
      pyright = {},
      -- rust_analyzer = {}, -- finns inte ??
      marksman = {},
      stylua = {},
      -- Some languages (like typescript) have entire language plugins that can be useful: https://github.com/pmizio/typescript-tools.nvim
      -- But for many setups, the LSP (`ts_ls`) will work just fine
      ts_ls = {},
      -- bash-language-server = {}, -- funkar ej?
      flake8 = {},
      beautysh = {},
      spellcheck = {},
      shfmt = {},
      ruff = {},
      debugpy = {},
      kdlfmt = {},
    } -- TODO: Add more (inspiration from current lazyvim Mason)

    -- Ensure the servers and tools above are installed
    --
    -- To check the current status of installed tools and/or manually install
    -- other tools, you can run
    --    :Mason
    --
    -- You can press `g?` for help in this menu.
    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      'lua_ls', -- Lua Language server
      'lua-language-server',
      'stylua', -- Used to format Lua code
      -- You can add other tools here that you want Mason to install
      'rust-analyzer',
      'marksman',
      'black',
      'isort',
      'prettier',
      'prettierd',
      'bash-language-server',
      'bash-debug-adapter',
      'beautysh',
      'flake8',
      'spellcheck',
      'shfmt',
      'ruff',
      'debugpy',
      'kdlfmt',
    }) -- TODO: Add more (inspiration from current lazyvim Mason)

    require('mason-tool-installer').setup { ensure_installed = ensure_installed }
    for name, server in pairs(servers) do
      server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
      vim.lsp.config(name, server)
      vim.lsp.enable(name)
    end

    -- Special Lua Config, as recommended by neovim help docs
    -- use new vim.lsp.config api for neovim 0.11+ -- HACK: NvChad
    vim.lsp.config('lua_ls', { -- INFO: Config for just lua
      on_init = function(client)
        if client.workspace_folders then
          local path = client.workspace_folders[1].name
          if path ~= vim.fn.stdpath 'config' and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then return end
        end

        client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
          runtime = {
            version = 'LuaJIT',
            path = { 'lua/?.lua', 'lua/?/init.lua' },
          },
          workspace = {
            checkThirdParty = false,
            -- NOTE: this is a lot slower and will cause issues when working on your own configuration.
            --  See https://github.com/neovim/nvim-lspconfig/issues/3189
            -- library = vim.api.nvim_get_runtime_file('', true),
            library = {
              vim.fn.expand '$VIMRUNTIME/lua',
              vim.fn.stdpath 'data' .. '/lazy/ui/nvchad_types',
              vim.fn.stdpath 'data' .. '/lazy/lazy.nvim/lua/lazy',
              '${3rd}/luv/library',
            },
          },
        })
      end,
      -- settings = {
      --   Lua = {},
      -- },
      -- settings = { -- HACK: NvChad -- I think above is a better way
      --   Lua = {
      --     runtime = { version = 'LuaJIT' },
      --     workspace = {
      --       library = {
      --         vim.fn.expand '$VIMRUNTIME/lua',
      --         vim.fn.stdpath 'data' .. '/lazy/ui/nvchad_types',
      --         vim.fn.stdpath 'data' .. '/lazy/lazy.nvim/lua/lazy',
      --         '${3rd}/luv/library',
      --       },
      --     },
      --   },
      -- },
    })
    vim.lsp.enable 'lua_ls'

    require('nvchad.lsp').diagnostic_config() -- HACK: From NvChad
  end,

  confchad = function() -- HACK: NvChad version
    require('nvchad.configs.lspconfig').defaults()

    local map = vim.keymap.set
    -- map('n', 'gD', vim.lsp.buf.declaration, opts 'Go to declaration')
    -- map('n', 'gd', vim.lsp.buf.definition, opts 'Go to definition')
    -- map('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts 'Add workspace folder')
    -- map('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts 'Remove workspace folder')
    -- map('n', '<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts 'List workspace folders')
    -- map('n', '<leader>D', vim.lsp.buf.type_definition, opts 'Go to type definition')
    -- map('n', '<leader>ra', require 'nvchad.lsp.renamer', opts 'NvRenamer')

    local servers = {
      'html',
      'cssls',
      -- Added
      'lua_ls', -- Lua Language server
      'lua-language-server',
      'stylua', -- Used to format Lua code
      'rust-analyzer',
      'marksman',
      'black',
      'isort',
      'prettier',
      'prettierd',
      'bash-language-server',
      'bash-debug-adapter',
      'beautysh',
      'flake8',
      'spellcheck',
      'shfmt',
      'ruff',
      'debugpy',
      'kdlfmt',
    }
    vim.lsp.enable(servers)
    -- read :h vim.lsp.config for changing options of lsp servers
  end,
}
