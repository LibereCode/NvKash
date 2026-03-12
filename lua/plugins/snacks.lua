return { -- You can add your own plugins here or in other files in this directory!
  --  I promise not to create any merge conflicts in this directory :)
  -- See the kickstart.nvim README for more information

  -- INFO: Snacks.nvim
  -- https://github.com/folke/snacks.nvim
  --
  -- TODO:
  -- - [ ] Remove MANY of the plugins
  -- - [ ] Remove some of the sub-plugs

  -- recommended base config
  ---@class snacks.dashboard.Config
  ---@field enabled? true -- boolean
  ---@field sections snacks.dashboard.Section
  ---@field formats table<string, snacks.dashboard.Text|fun(item:snacks.dashboard.Item, ctx:snacks.dashboard.Format.ctx):snacks.dashboard.Text>
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = {
      -- INFO: Enabled
      notifier = { enabled = true, timeout = 2666 },
      picker = { enabled = true }, -- really good fzf
      scroll = { enabled = true, animate = {
        duration = { steps = 25, total = 200 },
      } }, -- smooth scroll
      bigfile = { enabled = true }, -- handles big (default >1.5MB) files
      quickfile = { enabled = true }, -- loads file before plugins
      scope = { enabled = true }, -- scope detection with treesitter or indent-based algorithm
      input = { enabled = true }, -- allows insert/normal mode in :cmd(sometimes)
      -- what is dis snack?
      words = { enabled = true }, -- auto-show LSP refs

      -- HACK: DISABLED
      dashboard = { enabled = false },
      explorer = { enabled = false },
      statuscolumn = { enabled = false }, -- status to ←left
      indent = { enabled = false }, -- visualize indent guides (the bright line)

      -- TODO: add?
      --
      -- [ ] image (kitty graphics)
      --

      styles = {
        notification = {
          wo = { wrap = true }, -- Wrap notifications
        },
      },
    },

    keys = {
      -- Top Pickers
      {
        '<leader>gg',
        function() Snacks.lazygit() end,
        desc = 'Lazy[G]it',
      },
      {
        '<leader>fs',
        function() Snacks.picker.smart() end,
        desc = '[s]mart',
      },
      {
        '<leader>bb',
        function() Snacks.picker.buffers() end,
        desc = 'op[b]en [b]uffers',
      },
      -- {
      --   '<leader>sg',
      --   function() Snacks.picker.grep() end,
      --   desc = 'live [g]rep',
      -- },
      {
        '<leader>:',
        function() Snacks.picker.command_history() end,
        desc = '[:]cmd History',
      },
      {
        '<leader>nn',
        function() Snacks.picker.notifications() end,
        desc = '[n]otifications',
      },

      -- find picker -- TODO: >s=search text | >f=find files
      -- {
      --   '<leader>bf',
      --   function() Snacks.picker.buffers() end,
      --   desc = '[f]ind',
      -- },
      -- {
      --   '<leader>fc',
      --   function() Snacks.picker.files { cwd = vim.fn.stdpath 'config' } end,
      --   desc = '[c]onfig Files',
      -- },
      -- {
      --   '<leader>ff', -- >sd
      --   function() Snacks.picker.files() end,
      --   desc = '[f]iles',
      -- },
      {
        '<leader>gf',
        function() Snacks.picker.git_files() end,
        desc = 'git-repo [f]iles',
      },
      {
        '<leader>gp',
        function() Snacks.picker.projects() end,
        desc = '[p]rojects',
      },
      {
        '<leader>fr',
        function() Snacks.picker.recent() end,
        desc = '[r]ecent',
      },
      -- git picker
      {
        '<leader>gb',
        function() Snacks.picker.git_branches() end,
        desc = '[b]ranches',
      },
      {
        '<leader>gl',
        function() Snacks.picker.git_log() end,
        desc = '[l]og',
      },
      {
        '<leader>gL',
        function() Snacks.picker.git_log_line() end,
        desc = 'Log [L]ine',
      },
      {
        '<leader>gs',
        function() Snacks.picker.git_status() end,
        desc = '[s]tatus',
      },
      {
        '<leader>gS',
        function() Snacks.picker.git_stash() end,
        desc = '[S]tash',
      },
      {
        '<leader>gd',
        function() Snacks.picker.git_diff() end,
        desc = '[d]iff',
      },
      {
        '<leader>gF',
        function() Snacks.picker.git_log_file() end,
        desc = 'Log [F]ile',
      },
      -- gh
      {
        '<leader>ghi',
        function() Snacks.picker.gh_issue() end,
        desc = 'Git[h]ub [i]ssues',
      },
      {
        '<leader>ghI',
        function() Snacks.picker.gh_issue { state = 'all' } end,
        desc = 'Git[h]ub [I]ssues(all)',
      },
      {
        '<leader>ghp',
        function() Snacks.picker.gh_pr() end,
        desc = 'Git[h]ub [p]ull',
      },
      {
        '<leader>ghP',
        function() Snacks.picker.gh_pr { state = 'all' } end,
        desc = 'Git[h]ub [P]ull(all)',
      },
      -- originally in "-- other" section
      {
        '<leader>gB',
        function() Snacks.gitbrowse() end,
        desc = '[B]rowse',
        mode = { 'n', 'v' },
      },

      -- Grep/search picker
      {
        '<leader>sb',
        function() Snacks.picker.lines() end,
        desc = 'Buffer [l]ines',
      },
      {
        '<leader>sb',
        function() Snacks.picker.grep_buffers() end,
        desc = 'Open [b]uffers',
      },
      -- {
      --   '<leader>sg',
      --   function() Snacks.picker.grep() end,
      --   desc = 'live [g]rep',
      -- },
      -- {
      --   '<leader>sw',
      --   function() Snacks.picker.grep_word() end,
      --   desc = 'Visual/hovered [w]ord',
      --   mode = { 'n', 'x' },
      -- },

      -- search
      {
        '<leader>s"',
        function() Snacks.picker.registers() end,
        desc = '["]Registers',
      },
      {
        '<leader>s/',
        function() Snacks.picker.search_history() end,
        desc = '[/] History',
      },
      {
        '<leader>fa',
        function() Snacks.picker.autocmds() end,
        desc = '[a]utocmds',
      },
      {
        '<leader>f:',
        function() Snacks.picker.commands() end,
        desc = '[:]cmds(snack)',
      },
      -- {
      --   '<leader>sd',
      --   function() Snacks.picker.diagnostics() end,
      --   desc = '[d]iagnostics',
      -- },
      {
        '<leader>sD',
        function() Snacks.picker.diagnostics_buffer() end,
        desc = 'Buffer [D]iagnostics',
      },
      -- {
      --   '<leader>fh',
      --   function() Snacks.picker.help() end,
      --   desc = '[h]elp Pages',
      -- },
      {
        '<leader>fH',
        function() Snacks.picker.highlights() end,
        desc = '[H]ighlights',
      },
      {
        '<leader>fi',
        function() Snacks.picker.icons() end,
        desc = '[i]cons',
      },
      {
        '<leader>fj',
        function() Snacks.picker.jumps() end,
        desc = '[j]umps',
      },
      -- {
      --   '<leader>fk',
      --   function() Snacks.picker.keymaps() end,
      --   desc = '[k]eymaps',
      -- },
      {
        '<leader>cL',
        function() Snacks.picker.loclist() end,
        desc = '[L]oclist',
      },
      {
        '<leader>sm',
        function() Snacks.picker.marks() end,
        desc = '[m]arks',
      },
      {
        '<leader>fm',
        function() Snacks.picker.man() end,
        desc = '[m]an Pages',
      },
      {
        '<leader>ls',
        function() Snacks.picker.lazy() end,
        desc = '[s]pecs',
      },
      {
        '<leader>cq',
        function() Snacks.picker.qflist() end,
        desc = '[q]uickfix List',
      },
      -- {
      --   '<leader>sr',
      --   function() Snacks.picker.resume() end,
      --   desc = '[R]esume telescope',
      -- },
      {
        '<leader>su',
        function() Snacks.picker.undo() end,
        desc = '[u]ndo History',
      },
      {
        '<leader>uC',
        function() Snacks.picker.colorschemes() end,
        desc = '[C]olorschemes',
      },

      -- LSP
      {
        '<leader>cd',
        function() Snacks.picker.lsp_definitions() end,
        desc = '[d]efinition',
      },
      {
        '<leader>cD',
        function() Snacks.picker.lsp_declarations() end,
        desc = '[D]eclaration',
      },
      {
        '<leader>cr',
        function() Snacks.picker.lsp_references() end,
        nowait = true,
        desc = '[r]eferences',
      },
      {
        '<leader>cI',
        function() Snacks.picker.lsp_implementations() end,
        desc = '[I]mplementation',
      },
      {
        '<leader>cy',
        function() Snacks.picker.lsp_type_definitions() end,
        desc = 'T[y]pe Definition',
      },
      {
        '<leader>cai',
        function() Snacks.picker.lsp_incoming_calls() end,
        desc = '[i]ncoming',
      },
      {
        '<leader>cao',
        function() Snacks.picker.lsp_outgoing_calls() end,
        desc = '[o]utgoing',
      },
      {
        '<leader>cs',
        function() Snacks.picker.lsp_symbols() end,
        desc = '[s]ymbols',
      },
      {
        '<leader>cS',
        function() Snacks.picker.lsp_workspace_symbols() end,
        desc = 'Workspace [S]ymbols',
      },

      -- Other
      {
        '<leader>uz',
        function() Snacks.zen() end,
        desc = '[z]en Mode',
      },
      {
        '<leader>uZ',
        function() Snacks.zen.zoom() end,
        desc = '[Z]oom?',
      },
      {
        '<leader>.',
        function() Snacks.scratch() end,
        desc = '[.]Scratch',
      },
      {
        '<leader>s.',
        function() Snacks.scratch.select() end,
        desc = '[.]Scratch',
      },
      {
        '<leader>nh',
        function() Snacks.notifier.show_history() end,
        desc = 'notify [h]istory',
      },
      -- {
      --   '<leader>bd',
      --   function() Snacks.bufdelete() end,
      --   desc = '[d]elete',
      -- },
      {
        '<leader>cr',
        function() Snacks.rename.rename_file() end,
        desc = '[r]ename File',
      },
      {
        '<leader>nd',
        function() Snacks.notifier.hide() end,
        desc = '[d]ismiss Notifications',
      },
      -- {
      --   '<leader>tt',
      --   function() Snacks.terminal() end,
      --   desc = 'Toggle Terminal',
      -- }, -- HACK: Use NvChad terminal instead
      {
        '<C-_>', -- which key is this?
        -- function() Snacks.terminal() end,
        desc = 'which_key_ignore',
      },
      {
        ']]',
        function() Snacks.words.jump(vim.v.count1) end,
        desc = 'Next Reference',
        mode = { 'n', 't' },
      },
      {
        '[[',
        function() Snacks.words.jump(-vim.v.count1) end,
        desc = 'Prev Reference',
        mode = { 'n', 't' },
      },
      {
        '<leader>nN',
        desc = '[n]eovim [N]ews',
        function()
          Snacks.win {
            file = vim.api.nvim_get_runtime_file('doc/news.txt', false)[1],
            width = 0.6,
            height = 0.6,
            wo = {
              spell = false,
              wrap = false,
              signcolumn = 'yes',
              statuscolumn = ' ',
              conceallevel = 3,
            },
          }
        end,
      },
    },
    init = function()
      vim.api.nvim_create_autocmd('User', {
        pattern = 'VeryLazy',
        callback = function()
          -- Setup some globals for debugging (lazy-loaded)
          _G.dd = function(...) Snacks.debug.inspect(...) end
          _G.bt = function() Snacks.debug.backtrace() end

          -- Override print to use snacks for `:=` command
          if vim.fn.has 'nvim-0.11' == 1 then
            vim._print = function(_, ...) dd(...) end
          else
            vim.print = _G.dd
          end

          -- Create some toggle mappings
          Snacks.toggle.option('spell', { name = 'Spelling' }):map '<leader>us'
          Snacks.toggle.option('wrap', { name = 'Wrap' }):map '<leader>uw'
          Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map '<leader>ur'
          Snacks.toggle.diagnostics():map '<leader>ud'
          Snacks.toggle.line_number():map '<leader>ul'
          Snacks.toggle.option('conceallevel', { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map '<leader>uc'
          Snacks.toggle.treesitter():map '<leader>uT'
          Snacks.toggle.option('background', { off = 'light', on = 'dark', name = 'Dark Background' }):map '<leader>ub'
          Snacks.toggle.inlay_hints():map '<leader>uh'
          -- Snacks.toggle.indent():map '<leader>ug'
          Snacks.toggle.dim():map '<leader>uD'
        end,
      })
    end,
  },
}
