return {
  'akinsho/bufferline.nvim',
  version = '*',
  event = 'VeryLazy',
  dependencies = 'nvim-tree/nvim-web-devicons',
  keys = function(_, keys)
    ---Iterate over _number-keys_ to assign them as `mappings`
    ---@return table<table>
    local tbl = {}
    -- for n = 1, 9 do -- NOT NEEDED: bufferline autogenerate these! <WARN:
    --   local key = '<leader>b' .. n
    --   local cmd = '<cmd>BufferLineGoToBuffer ' .. n .. '<CR>'
    --   -- local descStr = 'GotoBuf: ' .. n
    --   table.insert(tbl, { key, cmd }) -- , desc = descStr
    -- end
    tbl = vim.tbl_extend('force', tbl, {
      { '<leader>bp', '<Cmd>BufferLineTogglePin<CR>', desc = 'toggle pin' },
      { '<leader>bP', '<Cmd>BufferLineGroupClose ungrouped<CR>', desc = 'delete non-pinned buffers' },
      { '<leader>bd', '<Cmd>BufferLineMoveNext <BAR> bd #<CR>', desc = 'delete buffer' },
      { '<leader>bD', '<Cmd>BufferLinePickClose<CR>', desc = 'pick buf2DEL' },
      { '<leader>bs', '<cmd>BufferLinePick<cr>', desc = 'select buf' },
      { '<S-M-h>', '<cmd>BufferLineMovePrev<cr>', desc = 'Move buffer prev' },
      { '<S-M-l>', '<cmd>BufferLineMoveNext<cr>', desc = 'Move buffer next' },
      { '<S-h>', '<cmd>BufferLineCyclePrev<cr>', desc = 'Focus buffer Prev' },
      { '<S-l>', '<cmd>BufferLineCycleNext<cr>', desc = 'Focus buffer Next' },
    })
    return tbl
  end,
  opts = {
    options = {
      -- can be a string | function, | false see "Mouse actions"
      close_command = 'bdelete! %d',
      right_mouse_command = 'BufferLineTogglePin %d',
      left_mouse_command = 'buffer %d',
      middle_mouse_command = 'bdelete! %d',

      indicator = {
        icon = '👉', -- '▎', -- this should be omitted if indicator style is not 'icon'
        style = 'icon', --'icon' | 'underline' | 'none',
      },
      modified_icon = ' ', -- '● ',
      max_name_length = 15,
      max_prefix_length = 12,
      tab_tab_size = 20,

      diagnostics = 'nvim_lsp',
      always_show_bufferline = true,
      offsets = {
        {
          filetype = 'neo-tree',
          text = 'Neo-tree',
          highlight = 'Directory',
          text_align = 'left',
        },
      },
      custom_filter = function(buf_number, buf_numbers)
        if vim.bo[buf_number].buftype ~= 'terminal' then return true end -- this hides terminal (buftype and not filetype, for some reason)
      end,
    },
  },
}
