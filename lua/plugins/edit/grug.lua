return { -- XXX: Commented in ./init.lua (disabled)
  'MagicDuck/grug-far.nvim',
  -- Note (lazy loading): grug-far.lua defers all it's requires so it's lazy by default
  -- additional lazy config to defer loading is not really needed...
  -- config = function()
  --   -- optional setup call to override plugin options
  --   -- alternatively you can set options with vim.g.grug_far = { ... }
  --   require('grug-far').setup {
  --     -- options, see Configuration section below
  --     -- there are no required options atm
  --   }
  -- end,
  keys = {
    { '<leader>r', function() require('grug-far').open() end, desc = 'grug & [r]eplace' },
  },
  opts = function(_, opts)
    -- -- which-key group-add
    -- require('which-key').add {
    --   { '<leader>r', group = 'replace' },
    -- }
    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('grug-far-keybindings', { clear = true }),
      pattern = { 'grug-far' },
      callback = function()
        ---@param key string
        ---@param cmd function|string
        ---@param opts nil|table
        ---@param mode nil|string
        ---@return nil
        local grugmap = function(key, cmd, opts, mode)
          opts = vim.tbl_extend('error', { buffer = true }, opts or {})
          mode = mode or 'n'
          vim.keymap.set(mode, key, cmd, opts)
        end
        ---Close `grug_far` if *in* it
        local function closeGrug()
          local inst = require('grug-far').get_instance(0)
          inst:open_location()
          inst:close()
        end
        grugmap('q', function() closeGrug() end) -- 3 ways on
        grugmap('<leader>r', function() closeGrug() end) -- how you
        grugmap('<ESC><ESC>', function() closeGrug() end) -- can exit
      end,
    })
    return opts
  end,
}
