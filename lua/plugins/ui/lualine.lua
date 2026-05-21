return { -- NOTE: Lualine https://github.com/nvim-lualine/lualine.nvim
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    { 'tiagovla/scope.nvim', config = true }, -- NOTE: Scope -- https://github.com/tiagovla/scope.nvim
  },
  events = 'UIEnter',

  init = function()
    vim.g.lualine_laststatus = vim.o.laststatus
    if vim.fn.argc(-1) > 0 then
      vim.o.statusline = ' ' -- set an empty statusline till lualine loads
    else
      vim.o.laststatus = 0 -- hide the statusline on the starter page
    end
  end,

  config = function() -- opts = {},
    require('lualine').setup {
      -- opts = function()
      --   local opts = {

      options = {
        icons_enabled = true,
        theme = 'auto',
        -- component_separators = { left = '', right = '' },
        -- section_separators = { left = '', right = '' },
        component_separators = { left = '|', right = '|' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
          'alpha',
          'neo-tree',
          -- statusline = { 'alpha', 'neo-tree' },
          -- winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        always_show_tabline = true,
        globalstatus = false,
        refresh = {
          -- Update if auto if no event
          statusline = 1000,
          -- tabline = 100,
          -- winbar = 1000,
          -- speed
          refresh_time = 16, -- ~60fps
          events = { -- events
            'WinEnter',
            'BufEnter',
            'BufWritePost',
            'SessionLoadPost',
            'FileChangedShellPost',
            'VimResized',
            'Filetype',
            'CursorMoved',
            'CursorMovedI',
            'ModeChanged',
          },
        },
      },
      sections = { -- https://github.com/nvim-lualine/lualine.nvim?tab=readme-ov-file#component-options
        lualine_a = {
          'mode',
        },
        lualine_b = {
          'filename',
        }, -- 'filename' = '%t%m'
        lualine_c = {
          'branch',
          'diff',
          'diagnostics',
        },
        lualine_x = {
          -- 'encoding',
          -- 'fileformat',
          'lsp_status',
          'filetype',
        },
        lualine_y = {
          -- 'selectioncount',
          -- 'progress',
          -- NOTE: combination of 'selectioncount' and 'progress'
          -- (I don't know how to `require()` them, fml😀... at least made it compact)
          function()
            -- Copyright (c) 2020-2021 hoob3rt
            -- MIT license, see lualine LICENSE for more details.
            local mode = vim.fn.mode(true)
            local lineDelta = math.abs(vim.fn.line 'v' - vim.fn.line '.') + 1
            local colDelta = math.abs(vim.fn.col 'v' - vim.fn.col '.') + 1
            if mode:match '' then
              return string.format('%dx%d', lineDelta, colDelta)
            elseif mode:match 'V' or lineDelta ~= 1 then
              return lineDelta
            elseif mode:match 'v' then
              return colDelta -- string.format('%d,%d', lineDelta, colDelta)
            else
              return string.format('%2d%%%%', math.floor(vim.fn.line '.' / vim.fn.line '$' * 100))
            end
          end,
        },
        lualine_z = {
          -- 'location',
          function() return '%c→' .. vim.fn.col '$' - 1 end, -- NOTE: `col` is way faster, and only drawback
          -- function() return 'B) c:C=%c:' .. vim.fn.strwidth(vim.fn.getline '.') end, --  (being n+1) is really easy fixed
          function() return '%l↓%L' end,
          -- function() return ' ' .. os.date '%R' end, -- clock
        },
      },

      extensions = {
        'neo-tree',
        'lazy',
        'man',
        'mason',
        'nvim-dap-ui',
      },
    }
  end,
}
