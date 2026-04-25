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
  lazy = true, -- dont think this does anything
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
  -- keys = {},
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
    local function leadmap(keys, cmd, description, modes)
      modes = modes or 'n'
      map(modes, '<leader>' .. keys, cmd, { desc = description })
    end

    -- Quick access
    leadmap('<leader>', builtin.live_grep, 'live[ ]grep')
    leadmap(':', builtin.command_history, '[:]command_history') -- maybe in find instead?
    map('n', '<C-/>', function() -- Override default behavior and theme when searching
      -- You can pass additional configuration to Telescope to change the theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown { -- INFO: theme like this
        winblend = 10,
        previewer = false,
      })
    end, { desc = 'Fzf [/] current buf' })
    leadmap(
      '/',
      function()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = true,
        })
      end,
      'Fzf [/] current buf'
    )

    -- search/select
    leadmap('st', builtin.builtin, '[t]elescope-builtins')
    leadmap('sd', builtin.diagnostics, 'diagnostics')
    leadmap('ss', builtin.live_grep, '[s]earch (live_grep)')
    leadmap('sr', builtin.resume, 'resume')
    leadmap('sb', function() --  See `:help telescope.builtin.live_grep()` for information about particular keys
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'LiveGrep open Buffers',
      }
    end, 'live_grep open_[b]ufs')
    leadmap('sf', function() --  See `:help telescope.builtin.live_grep()` for information about particular keys
      builtin.live_grep {
        cwd = vim.fn.expand '%:p:h', -- %:p = full-path ; %:h = directory name
        prompt_title = 'LiveGrep PWD',
      }
    end, 'live_grep pwd [f]iles')
    leadmap('sw', function() builtin.grep_string { grep_open_files = true } end, '[w]ord (bufs)', { 'n', 'v' })
    -- mapbuilt('sW', function() builtin.grep_string { search = vim.fn.expand '<cword>' } end, 'current [W]ord', { 'n' }) -- this is default...
    leadmap('sW', builtin.grep_string, '[W]ord', { 'n', 'v' })
    leadmap('sy', builtin.treesitter, 'Treesitter s[y]mbols')

    -- find/files
    leadmap('fb', builtin.buffers, 'buffers')
    leadmap('fc', function() builtin.find_files { cwd = vim.fn.stdpath 'config' } end, 'nvim [c]onfig') -- Shortcut for searching your Neovim configuration files
    leadmap('ff', builtin.fd, 'files') -- fd=find_files
    leadmap('fh', builtin.help_tags, 'help')
    leadmap('fk', builtin.keymaps, 'keymaps')
    leadmap('fr', builtin.oldfiles, 'recent Files')
    leadmap('ft', builtin.builtin, '[t]elescopes')
    leadmap('f:', builtin.commands, '[:]commands')

    -- buffer
    leadmap('bf', builtin.buffers, 'find')

    -- ui
    leadmap('uC', builtin.colorscheme, 'live preview Colorscheme')

    -- This runs on LSP attach per buffer (see main LSP attach function in 'neovim/nvim-lspconfig' config for more info,
    -- it is better explained there). This allows easily switching between pickers if you prefer using something else!
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('telescope-lsp-attach', { clear = true }),
      callback = function(event)
        local buf = event.buf
        local function lspmap(key_g, key_lead, cmd, descript)
          map('n', 'gr' .. key_g, cmd, { buffer = buf, desc = descript })
          map('n', '<leader>' .. key_lead, cmd, { buffer = buf, desc = descript })
        end -- why did I not lspmap+leadlspdmap(old) them from the start?

        lspmap('r', 'cr', builtin.lsp_references, '[r]eferences') -- Find references for the word under your cursor.
        -- Jump to the implementation of the word under your cursor.
        lspmap('i', 'ci', builtin.lsp_implementations, '[i]mplementation') -- Useful when your language has ways of declaring types without an actual implementation.
        -- Jump to the definition of the word under your cursor. This is where a variable was first declared, or where a function is defined, etc.
        lspmap('d', 'cd', builtin.lsp_definitions, '[d]efinition') -- To jump back, press <C-t>.
        -- Fuzzy find all the symbols in your current document.
        lspmap('s', 'sl', builtin.lsp_document_symbols, 'document [l]sp [s]ymbols') -- Symbols are things like variables, functions, types, etc.
        -- Fuzzy find all the symbols in your current workspace.
        lspmap('S', 'sL', builtin.lsp_dynamic_workspace_symbols, 'Workspace [L]SP [S]ymbols') -- Similar to document symbols, except searches over your entire project.
        -- Jump to the type of the word under your cursor.
        lspmap('y', 'cy', builtin.lsp_type_definitions, 't[y]pe definition') -- Useful when you're not sure what type a variable is and you want to see the definition of its *type*, not where it was *defined*.
        -- calls
        lspmap('ci', 'cCi', builtin.lsp_incoming_calls, 'incomming') -- Useful when you're not sure what type a variable is and you want to see the definition of its *type*, not where it was *defined*.
        lspmap('co', 'cCo', builtin.lsp_outgoing_calls, 'outgoing') -- Useful when you're not sure what type a variable is and you want to see the definition of its *type*, not where it was *defined*.
        -- which-key group-add
        require('which-key').add {
          -- { '<leader>sl', group = 'LSP' },
          { '<leader>cC', group = 'Calls' },
          { 'grC', group = 'Calls' },
        }
      end,
    })
  end,
}
