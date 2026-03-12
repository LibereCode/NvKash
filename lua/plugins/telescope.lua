-- NOTE: Plugins can specify dependencies.
--
-- The dependencies are proper plugin specifications as well - anything
-- you do for a plugin at the top level, you can do for a dependency.
--
-- Use the `dependencies` key to specify the dependencies of a particular plugin

return { -- Fuzzy Finder (files, lsp, etc)
  'nvim-telescope/telescope.nvim',
  -- By default, Telescope is included and acts as your picker for everything.

  -- If you would like to switch to a different picker (like snacks, or fzf-lua)
  -- you can disable the Telescope plugin by setting enabled to false and enable
  -- your replacement picker by requiring it explicitly (e.g. 'custom.plugins.snacks')

  -- Note: If you customize your config for yourself,
  -- it’s best to remove the Telescope plugin config entirely
  -- instead of just disabling it here, to keep your config clean.
  enabled = true,
  event = 'VimEnter',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { -- If encountering errors, see telescope-fzf-native README for installation instructions
      'nvim-telescope/telescope-fzf-native.nvim',

      -- `build` is used to run some command when the plugin is installed/updated.
      -- This is only run then, not every time Neovim starts up.
      build = 'make',

      -- `cond` is a condition used to determine whether this plugin should be
      -- installed and loaded.
      cond = function() return vim.fn.executable 'make' == 1 end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },

    -- Useful for getting pretty icons, but requires a Nerd Font.
    {
      'nvim-tree/nvim-web-devicons',
      enabled = vim.g.have_nerd_font,
      lazy = false,
    },
  },
  -- HACK: `require` >config< like this
  config = function()
    -- Telescope is a fuzzy finder that comes with a lot of different things that
    -- it can fuzzy find! It's more than just a "file finder", it can search
    -- many different aspects of Neovim, your workspace, LSP, and more!
    --
    -- The easiest way to use Telescope, is to start by doing something like:
    --  :Telescope help_tags
    --
    -- After running this command, a window will open up and you're able to
    -- type in the prompt window. You'll see a list of `help_tags` options and
    -- a corresponding preview of the help.
    --
    -- Two important keymaps to use while in Telescope are:
    --  - Insert mode: <c-/>
    --  - Normal mode: ?
    --
    -- This opens a window that shows you all of the keymaps for the current
    -- Telescope picker. This is really useful to discover what Telescope can
    -- do as well as how to actually do it!

    -- [[ Configure Telescope ]]
    -- See `:help telescope` and `:help telescope.setup()`
    require('telescope').setup {
      -- You can put your default mappings / updates / etc. in here
      --  All the info you're looking for is in `:help telescope.setup()`
      --
      -- defaults = {
      --   mappings = {
      --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
      --   },
      -- },
      -- pickers = {}
      extensions = {
        ['ui-select'] = { require('telescope.themes').get_dropdown() },
      },
    }

    -- Enable Telescope extensions if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    -- See `:help telescope.builtin`
    -- TODO: move as many plugins from snacks.lua as possible to here
    local builtin = require 'telescope.builtin'
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[h]help' })
    vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = '[k]keymaps' })
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[f]files' })
    vim.keymap.set('n', '<leader>S', builtin.builtin, { desc = '[S]elect Telescope' }) -- >sf --> >S
    vim.keymap.set({ 'n', 'v' }, '<leader>sw', builtin.grep_string, { desc = 'current [w]ord' })
    vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = 'live [g]grep' })
    vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[d]diagnostics' })
    vim.keymap.set('n', '<leader>sR', builtin.resume, { desc = '[R]resume' })
    vim.keymap.set('n', '<leader>fo', builtin.oldfiles, { desc = '[o]old Files' })
    vim.keymap.set('n', '<leader>f;', builtin.commands, { desc = '[;]cmds' })
    vim.keymap.set('n', '<leader>bf', builtin.buffers, { desc = '[f]find' }) -- Buffer

    -- This runs on LSP attach per buffer (see main LSP attach function in 'neovim/nvim-lspconfig' config for more info,
    -- it is better explained there). This allows easily switching between pickers if you prefer using something else!
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('telescope-lsp-attach', { clear = true }),
      callback = function(event)
        local buf = event.buf

        -- Find references for the word under your cursor.
        vim.keymap.set('n', 'gR', builtin.lsp_references, { buffer = buf, desc = 'telescope[R]references' })

        -- Jump to the implementation of the word under your cursor.
        -- Useful when your language has ways of declaring types without an actual impJementation.
        vim.keymap.set('n', 'gI', builtin.lsp_implementations, { buffer = buf, desc = 'telescope[I]Implementation' })

        -- Jump to the definition of the word under your cursor.
        -- This is where a variable was first declared, or where a function is defined, etc.
        -- To jump back, press <C-t>.
        vim.keymap.set('n', 'gd', builtin.lsp_definitions, { buffer = buf, desc = 'telescope[d]definition' })

        -- Fuzzy find all the symbols in your current document.
        -- Symbols are things like variables, functions, types, etc.
        vim.keymap.set('n', 'gs', builtin.lsp_document_symbols, { buffer = buf, desc = '[s]ymbols' })

        -- Fuzzy find all the symbols in your current workspace.
        -- Similar to document symbols, except searches over your entire project.
        vim.keymap.set('n', 'gS', builtin.lsp_dynamic_workspace_symbols, { buffer = buf, desc = 'Workspace [S]ymbols' })

        -- Jump to the type of the word under your cursor.
        -- Useful when you're not sure what type a variable is and you want to see
        -- the definition of its *type*, not where it was *defined*.
        vim.keymap.set('n', 'gy', builtin.lsp_type_definitions, { buffer = buf, desc = 'T[y]pe Definition' })
      end,
    })

    -- Override default behavior and theme when searching
    vim.keymap.set('n', '<leader>/', function()
      -- You can pass additional configuration to Telescope to change the theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = '[/]fzf buffer' })

    -- It's also possible to pass additional configuration options.
    --  See `:help telescope.builtin.live_grep()` for information about particular keys
    -- vim.keymap.set(
    --   'n',
    --   '<leader>s/',
    --   function()
    --     builtin.live_grep {
    --       grep_open_files = true,
    --       prompt_title = 'Live Grep in Open Files',
    --     }
    --   end,
    --   { desc = '[/] in Open Files' }
    -- )

    -- Shortcut for searching your Neovim configuration files
    vim.keymap.set('n', '<leader>fc', function() builtin.find_files { cwd = vim.fn.stdpath 'config' } end, { desc = 'Neovim [C]onfig' })
  end,
}
