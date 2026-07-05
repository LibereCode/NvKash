return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  vscode = true,
  ---@type Flash.Config
  opts = { -- HACK: omg, jag glömde denna och det fucka mig så länge (den fixa att `f` och `t` keys ej använde flash)

    search = {
      -- mode = 'fuzzy',
      -- incremental = true,
    },
    label = {
      -- style = 'inline', ---@type "eol" | "overlay" | "right_align" | "inline"
      -- min_pattern_length = 2, -- fucks up labels on f/F/t/T/;/,
      -- rainbow = { enabled = true, shade = 9 },
    },
    jump = {
      nohlsearch = true,
    },
    prompt = {
      prefix = { { ' 󰙻 ', 'FlashPromptIcon' } }, -- ⚡ 󰙻 󰉁󱐋
    },
    modes = {
      char = {
        jump_labels = true, -- f/F/t/T/;/, with labels
      },
    },
  },

  keys = {
    { -- wtf, detta fungerade superenkelt? flyttade hit ifrån config/keymaps.lua
      's',
      mode = { 'n', 'v', 'o' },
      function() require('flash').jump() end,
      desc = 'flash󰉁',
    },
    {
      'S',
      mode = { 'n', 'v', 'o' },
      function() require('flash').treesitter { actions = { ['S'] = 'next', ['s'] = 'prev' } } end,
      desc = 'flash󰉁tree[S]itter', -- 'Simulate󰉁treesitter󰉁incremental󰉁selection',
    },

    { -- 'o' = [o]perator-mode (d/c/y{motion})
      'r',
      mode = 'o',
      function() require('flash').remote() end,
      desc = '[r]emote󰉁Flash',
    },
    { -- 'x' = visual-mode (still mad that v isnt visual, but instead viusual+selection)
      'R',
      mode = { 'o', 'x' },
      function() require('flash').treesitter_search() end,
      desc = 'TreeSitte[R]󰉁Search',
    },

    { -- use flash during [/]search[?]
      '<C-s>',
      mode = { 'c' },
      function() require('flash').toggle() end,
      desc = 'Toggle Flash [s]earch',
    },

    -- { "s", mode = { "n", "x", "o" }, false }, -- disable the default flash keymap -- not needed

    -- INFO: :h flash.nvim-flash.nvim-examples

    { -- flash to diagnostics
      '<leader>ds',
      function()
        -- simple
        -- require('flash').jump {
        --   action = function(match, state)
        --     vim.api.nvim_win_call(match.win, function()
        --       vim.api.nvim_win_set_cursor(match.win, match.pos)
        --       vim.diagnostic.open_float()
        --     end)
        --     state:restore()
        --   end,
        -- }

        -- More advanced example that also highlights diagnostics:
        require('flash').jump {
          ---@param win integer
          matcher = function(win)
            return vim.tbl_map(
              function(diag)
                return {
                  pos = { diag.lnum + 1, diag.col },
                  end_pos = { diag.end_lnum + 1, diag.end_col - 1 },
                }
              end,
              vim.diagnostic.get(vim.api.nvim_win_get_buf(win))
            )
          end,
          action = function(match, state)
            vim.api.nvim_win_call(match.win, function()
              vim.api.nvim_win_set_cursor(match.win, match.pos)
              vim.diagnostic.open_float()
            end)
            state:restore()
          end,
        }
      end,
      desc = 'fla[󰉁]h',
    },

    { -- 2-char jump -- 2djump (like mini.jump2d/hop.nvim) - match everything
      '<leader>S',
      function()
        local Flash = require 'flash'

        local function format(opts)
          -- always show first and second label
          return {
            { opts.match.label1, 'FlashMatch' },
            { opts.match.label2, 'FlashLabel' },
          }
        end

        Flash.jump {
          search = { mode = 'search' },
          label = { after = false, before = { 0, 0 }, uppercase = false, format = format },
          pattern = [[\<]],
          action = function(match, state)
            state:hide()
            Flash.jump {
              search = { max_length = 0 },
              highlight = { matches = false },
              label = { format = format },
              matcher = function(win)
                -- limit matches to the current label

                ---@class m
                ---@field label string
                ---@field win integer
                ---@field label1 string
                ---@field label2 string

                ---@param m m
                return vim.tbl_filter(function(m) --
                  return m.label == match.label and m.win == win
                end, state.results)
              end,
              ---@param matches m
              labeler = function(matches)
                for _, m in ipairs(matches) do
                  m.label = m.label2 -- use the second label
                end
              end,
            }
          end,
          ---@param matches[m,m]
          labeler = function(matches, state)
            local labels = state:labels()
            for m, match in ipairs(matches) do
              match.label1 = labels[math.floor((m - 1) / #labels) + 1]
              match.label2 = labels[(m - 1) % #labels + 1]
              match.label = match.label1
            end
          end,
        }
      end,
      desc = 'fla[󰉁]h 2-char',
    },
  },
  -- end,
}
