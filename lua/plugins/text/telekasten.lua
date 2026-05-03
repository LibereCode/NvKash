-- TODO: Do something similar (markdown note plugin) on my own !
-- I want to follow standard nvim/markdown integration 100%

return {
  'renerocksai/telekasten.nvim',
  dependencies = { 'nvim-telescope/telescope.nvim' },
  opts = function(_, opts)
    ---@param key string
    ---@param telecmd string|function
    ---@param mapOpts? table
    ---@param mode? string|table
    local function map(key, telecmd, mapOpts, mode) --
      vim.keymap.set(mode or 'n', key, telecmd, mapOpts or {})
    end
    -- NOTE: see nvim/after/ftplugin/telekasten.lua for more
    map('<leader>zp', '<cmd>Telekasten panel<CR>')

    map('<leader>zf', '<cmd>Telekasten find_notes<CR>')
    map('<leader>zs', '<cmd>Telekasten search_notes<CR>')
    map('<leader>zd', '<cmd>Telekasten goto_today<CR>')
    map('<leader>zn', '<cmd>Telekasten new_note<CR>')
    map('<leader>zc', '<cmd>Telekasten show_calendar<CR>')
    map('<leader>zb', '<cmd>Telekasten show_backlinks<CR>')

    require('which-key').add {
      { '<leader>z', group = 'Tele/[z]ettelkasten', mode = { 'n' } },
      { '<leader>zg', group = 'goto ...' },
    }
    map('<leader>zgt', '<cmd>Telekasten goto_today<CR>')
    map('<leader>zgw', '<cmd>Telekasten goto_thisweek<CR>')
    map('<leader>zgm', '<cmd>Telekasten goto_thismonth<CR>')
    map('<leader>zgy', '<cmd>Telekasten goto_thisyear<CR>')

    opts = vim.tbl_extend('force', opts, {
      home = vim.fn.expand '~/Documents/Notes/zettelkasten',
    })
    return opts
  end,
}
