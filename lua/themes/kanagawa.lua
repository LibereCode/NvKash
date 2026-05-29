return { -- You can easily change to a different colorscheme.
  -- Change the name of the colorscheme plugin below, and then
  -- change the command in the config to whatever the name of that colorscheme is.
  --
  -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
  'rebelot/kanagawa.nvim',
  priority = 1000, -- Make sure to load this before all the other start plugins.
  config = function()
    local kan = require 'kanagawa'

    ---@diagnostic disable-next-line: missing-fields
    -- Default options:
    kan.setup {

      compile = true, -- false -- enable compiling the colorscheme
      undercurl = true,
      commentStyle = { italic = false }, -- italic = true
      functionStyle = { bold = true },
      keywordStyle = {}, --  italic = true
      statementStyle = {}, -- bold = true
      typeStyle = { bold = true },
      transparent = false, -- do not set background color -- if true, also set: all = {{ bg_gutter = 'none' }},
      dimInactive = true, -- dim inactive window `:h hl-NormalNC`

      terminalColors = true, -- define vim.g.terminal_color_{0,17}
      ---@type table bla bla
      colors = { -- add/modify theme and palette colors
        palette = {},
        -- stylua: ignore
        theme = { wave = {}, lotus = {}, dragon = {},
          all = {
            ui = {
              bg_gutter = '#12120f' -- 'none', -- see transperent
            },
          },
        },
      },
      overrides = function(colors) -- add/modify highlights
        local theme = colors.theme
        -- tint background on diagnostics
        local makeDiagnosticColor = function(color)
          local c = require 'kanagawa.lib.color'
          return { fg = color, bg = c(color):blend(theme.ui.bg, 0.95):to_hex() }
        end

        return {
          -- dark completion-popup
          Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1, blend = vim.o.pumblend }, -- add `blend = vim.o.pumblend` to enable transparency
          PmenuSel = { fg = 'NONE', bg = theme.ui.bg_p2 },
          PmenuSbar = { bg = theme.ui.bg_m1 },
          -- PmenuThumb = { bg = theme.ui.bg_p2 },
          PmenuKind = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
          PmenuExtra = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },

          -- diagnostics
          DiagnosticVirtualTextHint = makeDiagnosticColor(theme.diag.hint),
          DiagnosticVirtualTextInfo = makeDiagnosticColor(theme.diag.info),
          DiagnosticVirtualTextWarn = makeDiagnosticColor(theme.diag.warning),
          DiagnosticVirtualTextError = makeDiagnosticColor(theme.diag.error),

          -- telescope
          -- TelescopeTitle = { fg = theme.ui.special, bold = true },
          -- TelescopePromptNormal = { bg = theme.ui.bg_p1 },
          -- TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
          -- TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
          -- TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
          -- TelescopePreviewNormal = { bg = theme.ui.bg_dim },
          -- TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
        }
      end,
      theme = 'dragon', -- Load "wave" theme
      background = { -- map the value of 'background' option to a theme
        dark = 'dragon', -- try "dragon" !
        light = 'lotus',
      },
    }
    -- -- setup must be called before loading
    -- vim.cmd 'colorscheme kanagawa'

    -- Load the colorscheme here.
    -- Like many other themes, this one has different styles, and you could load
    -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
    vim.cmd.colorscheme 'kanagawa-dragon'

    local kanaLuaPath = vim.fn.stdpath 'config' .. '/lua/themes/kanagawa.lua'
    local autocmd, augroup = vim.api.nvim_create_autocmd, vim.api.nvim_create_augroup
    local kanaStatePath = vim.fn.stdpath 'state' .. '/kanagawa.hash' --

    autocmd('BufEnter', {
      desc = 'If kanagawa.lua state-file exist, then :KanagawaCompile',
      group = augroup('KanagawaCompile-on-enter-after-save', { clear = true }),
      once = true,
      callback = function()
        if vim.uv.fs_stat(kanaStatePath) then
          -- print('DEBUG: State file exist at' .. kanaStatePath)
          vim.cmd 'KanagawaCompile'
          vim.uv.fs_unlink(kanaStatePath) --
          -- else
          --   vim.api.nvim_echo({ { 'ERROR: No State file at' .. kanaStatePath } }, true, { err = true })
        end
      end,
    })

    -- event=BufWritePost (or FileWritePost?)
    -- - pattern = <path/kanagawa.lua> do: 1. Calc hash; 2. write it to state-file
    autocmd('BufWritePost', {
      desc = 'When kanagawa.lua changes, then create kanagawa.lua state-file',
      group = augroup('kanagawa-create-state-on-save', { clear = true }),
      pattern = kanaLuaPath,
      callback = function()
        local f, err = io.open(kanaStatePath, 'wb')
        if not f then error(err) end
        f:write ''
        f:close()

        -- -- cool,... but shit
        -- local fd, err = vim.uv.fs_open(kanaStatePath, 'wx', 666) -- 666 = rw-rw-rw-
        -- if not fd then error(err) end
        -- vim.uv.fs_close(fd)
      end,
    })
  end,
}
