-- Add indentation guides even on blank lines
---@module 'lazy'
---@type LazySpec
return {
  'lukas-reineke/indent-blankline.nvim',
  -- Enable `lukas-reineke/indent-blankline.nvim`
  -- See `:help ibl`
  main = 'ibl',
  ---@module 'ibl'
  ---@type ibl.config
  opts = function() -- NOTE: inspired by LazyVim https://www.lazyvim.org/extras/ui/indent-blankline#indent-blanklinenvim
    return {
      debounce = 100, -- ms(time) between refreshes
      indent = {
        char = { '┆' }, --   '┋''┊', '┆''┇', '╏''╎', '│',
        tab_char = { '╏', '┇', '┋' }, -- '╎', -- '│', -- what is this
      },
      -- whitespace = { -- ? ingen aning vad detta är...
      --   highlight = { 'Function', 'Label', 'Whitespace', 'NonText' },
      --   remove_blankline_trail = true,
      -- },
      scope = { -- INFO: `:h ibl.config.scope`
        include = {
          node_type = {
            ['*'] = {
              'return_statement', -- return {}
              'table_constructor', -- { tables },
              'if_statement', -- add the node 'if'
              'while_statement', -- add the node 'if'
            },
            -- { ['*'] = { '*' } }, -- adds all nodes for all file-types. WARN: BAD
            -- lua = { -- Adds some nodes to lua
            --   'return_statement', -- return {}
            --   'table_constructor', -- { tables },
            -- },
            -- python = { -- adds to python
            --   'if_statement', -- add the node 'if'
            --   'while_statement', -- add the node 'if'
            -- },
          },
        },
        -- exclude = { language = { 'lua' } } -- Disables scope for lua
      },
      exclude = { -- LazyVim
        filetypes = {
          'Trouble',
          'alpha',
          'dashboard',
          'help',
          'lazy',
          'mason',
          'neo-tree',
          'trouble',
        },
      },
      -- INFO: `:h ibl.config.scope` explains scope good
    }
  end,
  -- TODO:
  -- - [ ] :IBLToggle (make into keymap)
}
