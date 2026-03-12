-- Adds git related signs to the gutter, as well as utilities for managing changes
-- NOTE: gitsigns is already included in init.lua but contains only the base
-- config. This will add also the recommended keymaps.
return {
  'lewis6991/gitsigns.nvim',
  opts = {
    on_attach = function(bufnr)
      local gitsigns = require 'gitsigns'

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end
      -- Navigation
      map('n', ']c', function()
        if vim.wo.diff then
          vim.cmd.normal { ']c', bang = true }
        else
          gitsigns.nav_hunk 'next'
        end
      end, { desc = 'Jump to next git [c]hange' })

      map('n', '[c', function()
        if vim.wo.diff then
          vim.cmd.normal { '[c', bang = true }
        else
          gitsigns.nav_hunk 'prev'
        end
      end, { desc = 'Jump to previous git [c]hange' })
      -- Actions -- TODO: GH -> g (merge with Git into G -> g)
      -- visual mode
      map('v', '<leader>ghs', function() gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' } end, { desc = '[s]tage hunk' })
      map('v', '<leader>ghr', function() gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' } end, { desc = '[r]eset hunk' })
      -- normal mode
      map('n', '<leader>ghs', gitsigns.stage_hunk, { desc = '[s]tage' })
      map('n', '<leader>ghr', gitsigns.reset_hunk, { desc = '[r]eset' })
      map('n', '<leader>ghS', gitsigns.stage_buffer, { desc = '[S]tage' })
      map('n', '<leader>ghu', gitsigns.stage_hunk, { desc = '[u]ndo stage' })
      map('n', '<leader>ghR', gitsigns.reset_buffer, { desc = '[R]eset buffer' })
      map('n', '<leader>ghp', gitsigns.preview_hunk, { desc = '[p]review' })
      map('n', '<leader>ghb', gitsigns.blame_line, { desc = '[b]lame' })
      map('n', '<leader>ghd', gitsigns.diffthis, { desc = '[d]iff index' })
      map('n', '<leader>ghD', function() gitsigns.diffthis '@' end, { desc = '[D]iff last commit' })
      -- Toggles
      map('n', '<leader>gtb', gitsigns.toggle_current_line_blame, { desc = '[b]lame line' })
      map('n', '<leader>gtD', gitsigns.preview_hunk_inline, { desc = '[D]eleted' })
    end,

    -- See `:help gitsigns` to understand what the configuration keys do
    signs = { -- Adds git related signs to the gutter, as well as utilities for managing changes
      add = { text = '+' },
      change = { text = '~' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
    },
  },
  -- Alternatively, use `config = function() ... end` for full control over the configuration.
  -- If you prefer to call `setup` explicitly, use:
  --    {
  --        'lewis6991/gitsigns.nvim',
  --        config = function()
  --            require('gitsigns').setup({
  --                -- Your gitsigns configuration here
  --            })
  --        end,
  --    }
}
