return { --  https://nvim-mini.org/mini.nvim/#setup
  -- Collection of various small independent plugins/modules --
  'nvim-mini/mini.nvim',
  event = 'VeryLazy',
  version = false,
  config = function()
    -- INFO:require('mini.foobar').setup({config}) -- maybe {} in setup({}) ins't needed?

    require('mini.ai').setup { -- Better [a]round/[i]nside textobjects
      n_lines = 723,
    }
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
    --  - ci'  - [C]hange [I]nside [']quote

    require('mini.surround').setup {
      -- Add custom surroundings to be used on top of builtin ones. For more
      -- information with examples, see `:h MiniSurround.config`.
      custom_surroundings = nil,
      highlight_duration = 500, -- Duration (in ms) of highlight when calling `MiniSurround.highlight()`

      mappings = { -- Module mappings. Use `''` (empty string) to disable one.
        -- add = 'sa', -- Add surrounding in Normal and Visual modes
        -- delete = 'sd', -- Delete surrounding
        -- find = 'sf', -- Find surrounding (to the right)
        -- find_left = 'sF', -- Find surrounding (to the left)
        -- highlight = 'sh', -- Highlight surrounding
        -- replace = 'sr', -- Replace surrounding
        add = 'gsa', -- Add surrounding in Normal and Visual modes
        delete = 'gsd', -- Delete surrounding
        find = 'gsf', -- Find surrounding (to the right)
        find_left = 'gsF', -- Find surrounding (to the left)
        highlight = 'gsh', -- Highlight surrounding
        replace = 'gsr', -- Replace surrounding

        suffix_last = 'l', -- Suffix to search with "prev" method
        suffix_next = 'n', -- Suffix to search with "next" method
      },

      n_lines = 723, -- Number of lines within which surrounding is searched
      respect_selection_type = false, -- Whether to respect selection type(mode): linewise=separate lines ; blockwise=each line
      -- How to search for surrounding (first inside current line, then inside neighborhood).
      -- see `:h MiniSurround.config`.
      search_method = 'cover', -- One of 'cover', 'cover_or_next', 'cover_or_prev', 'cover_or_nearest', 'next', 'prev', 'nearest'. For more details,
      silent = false, -- Whether to disable showing non-error feedback

      -- allow to edit (just the) ({[ surroundings ]})
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
    }

    require('mini.indentscope').setup {
      draw = { -- Draw options
        delay = 100, -- Delay (in ms) between event and start of drawing scope indicator
        -- Animation rule for scope's first drawing. A function which, given
        -- next and total step numbers, returns wait time (in ms). See
        -- |MiniIndentscope.gen_animation| for builtin options. To disable
        -- animation, use `require('mini.indentscope').gen_animation.none()`.
        -- animation = function() end, --<function: implements constant 20ms between steps>,
        -- Whether to auto draw scope: return `true` to draw, `false` otherwise.
        predicate = function(scope) return not scope.body.is_incomplete end, --  Default draws only fully computed scope (see `options.n_lines`).
        priority = 2, -- Symbol priority. Increase to display on top of more symbols.
      },

      mappings = { -- Module mappings. Use `''` (empty string) to disable one.
        -- Textobjects
        object_scope = 'ii',
        object_scope_with_border = 'ai',
        -- Motions (jump to respective border line; if not present - body line)
        goto_top = '[i',
        goto_bottom = ']i',
      },

      options = { -- Options which control scope computation
        -- Type of scope's border: which line(s) with smaller indent to categorize as border.
        border = 'both', -- Can be one of: 'both', 'top', 'bottom', 'none'.
        -- Whether to use cursor column when computing reference indent.
        indent_at_cursor = true, -- Useful to see incremental scopes with horizontal cursor movements.
        n_lines = 10000, -- Maximum number of lines above or below within which scope is computed
        -- Whether to first check input line to be a border of adjacent scope.
        try_as_border = true, -- Use it if you want to place cursor on function header to get scope of its body.
      },
      -- TODO: integrate with specific file.types
      -- example: change python to border = 'top',

      symbol = '╎', -- Which character to use for drawing scope indicator
    }

    --  Simple and easy statusline.
    -- local statusline = require 'mini.statusline' -- Create an alias
    -- statusline.setup { use_icons = vim.g.have_nerd_font } -- set use_icons to true if you have a Nerd Font
    -- You can configure sections in the statusline by overriding their default behavior.
    -- For example, here we set the section for cursor location to LINE:COLUMN
    ---@diagnostic disable-next-line: duplicate-set-field
    -- statusline.section_location = function() return '%2l:%-2v' end -- %='dis a var'; 2/-2='spaces to left/right' ; :="just ':'" ; l/v='line/(vertical?)row'
    -- [status string] l=current line ; L=max line ; v = current vertical-line ; F = full path
    -- [status flags] r=read only ; m=modified ; h=help buffer

    -- ... and there is more!
    --  Check out: https://github.com/nvim-mini/mini.nvim

    -- mini icons
    -- require('mini.icons').setup { -- alternative icons
    --   opts = {
    --     file = {
    --       ['.keep'] = { glyph = '󰊢', hl = 'MiniIconsGrey' },
    --       ['devcontainer.json'] = { glyph = '', hl = 'MiniIconsAzure' },
    --     },
    --     filetype = {
    --       dotenv = { glyph = '', hl = 'MiniIconsYellow' },
    --     },
    --   },
    --   init = function()
    --     package.preload['nvim-web-devicons'] = function()
    --       require('mini.icons').mock_nvim_web_devicons()
    --       return package.loaded['nvim-web-devicons']
    --     end
    --   end,
    -- }
  end,
}
