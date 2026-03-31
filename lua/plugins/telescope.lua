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

    -- -- Useful for getting pretty icons, but requires a Nerd Font.
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
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
      pickers = {
        colorscheme = {
          enable_preview = true,
        },
      },
    }

    -- Enable Telescope extensions if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    -- See `:help telescope.builtin`

    local map = vim.keymap.set
    local builtin = require 'telescope.builtin'
    local function mapbuilt(keys, cmd, description, modes)
      modes = modes or 'n'
      map(modes, '<leader>' .. keys, cmd, { desc = description })
    end

    -- search/select
    mapbuilt('<leader>ss', function() --  See `:help telescope.builtin.live_grep()` for information about particular keys
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live_[s]earch open_bufs',
      }
    end, 'Live grep[/] open files')
    map({ 'n', 'v' }, '<leader>sw', builtin.grep_string, { desc = 'word' })
    mapbuilt('<leader>sg', builtin.live_grep, 'grep')
    mapbuilt('<leader>sd', builtin.diagnostics, 'diagnostics')
    mapbuilt('<leader>sr', builtin.resume, 'resume')
    mapbuilt('<leader>sb', builtin.builtin, 'Telescope-[b]uiltins')
    mapbuilt('<leader>sy', builtin.treesitter, 'Treesitter s[y]mbols')

    -- find/file
    mapbuilt('<leader>fb', builtin.buffers, 'buffers')
    mapbuilt('<leader>fc', function() builtin.find_files { cwd = vim.fn.stdpath 'config' } end, 'nvim [c]onfig') -- Shortcut for searching your Neovim configuration files
    mapbuilt('<leader>ff', builtin.fd, 'files') -- fd=find_files
    mapbuilt('<leader>fh', builtin.help_tags, 'help')
    mapbuilt('<leader>fk', builtin.keymaps, 'keymaps')
    mapbuilt('<leader>fr', builtin.oldfiles, 'recent Files')
    mapbuilt('<leader>f:', builtin.commands, '[:]commands')

    mapbuilt('<leader>bf', builtin.buffers, 'find')

    mapbuilt('<leader><leader>', builtin.live_grep, 'live[ ]grep')

    -- ui

    mapbuilt('<leader>uC', builtin.colorscheme, 'live preview Colorscheme')

    -- This runs on LSP attach per buffer (see main LSP attach function in 'neovim/nvim-lspconfig' config for more info,
    -- it is better explained there). This allows easily switching between pickers if you prefer using something else!
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('telescope-lsp-attach', { clear = true }),
      callback = function(event)
        local buf = event.buf

        -- Find references for the word under your cursor.
        map('n', 'grr', builtin.lsp_references, { buffer = buf, desc = 'references' })

        -- Jump to the implementation of the word under your cursor.
        -- Useful when your language has ways of declaring types without an actual implementation.
        map('n', 'gri', builtin.lsp_implementations, { buffer = buf, desc = 'implementation' })

        -- Jump to the definition of the word under your cursor.
        -- This is where a variable was first declared, or where a function is defined, etc.
        -- To jump back, press <C-t>.
        map('n', 'grd', builtin.lsp_definitions, { buffer = buf, desc = 'definition' })

        -- Fuzzy find all the symbols in your current document.
        -- Symbols are things like variables, functions, types, etc.
        map('n', 'gO', builtin.lsp_document_symbols, { buffer = buf, desc = '[O]pen document Symbols' })

        -- Fuzzy find all the symbols in your current workspace.
        -- Similar to document symbols, except searches over your entire project.
        map('n', 'gW', builtin.lsp_dynamic_workspace_symbols, { buffer = buf, desc = 'open [W]orkspace Symbols' })

        -- Jump to the type of the word under your cursor.
        -- Useful when you're not sure what type a variable is and you want to see
        -- the definition of its *type*, not where it was *defined*.
        map('n', 'grt', builtin.lsp_type_definitions, { buffer = buf, desc = 'type definition' })
      end,
    })

    -- Override default behavior and theme when searching
    map('n', '<C-/>', function()
      -- You can pass additional configuration to Telescope to change the theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown { -- INFO: theme like this
        winblend = 10,
        previewer = false,
      })
    end, { desc = 'Fzf [/] current buf' })
    mapbuilt(
      '/',
      function()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = true,
        })
      end,
      'Fzf [/] current buf'
    )
  end,
}
