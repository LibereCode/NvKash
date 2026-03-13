return { -- Collection of various small independent plugins/modules
  'nvim-mini/mini.nvim',
  config = function()
    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
    --  - ci'  - [C]hange [I]nside [']quote
    require('mini.ai').setup { n_lines = 723 }

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    --
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    -- require('mini.surround').setup() -- HACK:
    require('mini.surround').setup {
      -- Add custom surroundings to be used on top of builtin ones. For more
      -- information with examples, see `:h MiniSurround.config`.
      custom_surroundings = nil,
      highlight_duration = 723, -- Duration (in ms) of highlight when calling `MiniSurround.highlight()`

      mappings = { -- Module mappings. Use `''` (empty string) to disable one.
        add = 'gsa', -- 'sa' -- Add surrounding in Normal and Visual modes
        delete = 'gsd', -- 'sd' -- Delete surrounding
        find = 'gsf', -- 'sf' -- Find surrounding (to the right)
        find_left = 'gsF', -- 'sF' -- Find surrounding (to the left)
        highlight = 'gsh', -- 'sh' -- Highlight surrounding
        replace = 'gsr', -- 'sr' -- Replace surrounding

        suffix_last = 'l', -- Suffix to search with "prev" method
        suffix_next = 'n', -- Suffix to search with "next" method
      },

      n_lines = 723, -- Number of lines within which surrounding is searched
      respect_selection_type = false, -- Whether to respect selection type(mode): linewise=separate lines ; blockwise=each line
      -- How to search for surrounding (first inside current line, then inside neighborhood).
      -- see `:h MiniSurround.config`.
      search_method = 'cover', -- One of 'cover', 'cover_or_next', 'cover_or_prev', 'cover_or_nearest', 'next', 'prev', 'nearest'. For more details,
      silent = false, -- Whether to disable showing non-error feedback
    }

    -- Simple and easy statusline.
    --  You could remove this setup call if you don't like it,
    --  and try some other statusline plugin
    local statusline = require 'mini.statusline'
    -- set use_icons to true if you have a Nerd Font
    statusline.setup { use_icons = vim.g.have_nerd_font }

    -- You can configure sections in the statusline by overriding their
    -- default behavior. For example, here we set the section for
    -- cursor location to LINE:COLUMN
    ---@diagnostic disable-next-line: duplicate-set-field
    statusline.section_location = function() return '%2l:%-2v' end

    -- ... and there is more!
    --  Check out: https://github.com/nvim-mini/mini.nvim
    --  HACK: Add more here

    require('mini.indentscope').setup { -- creates highlight on the current ident
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
  end,
}
