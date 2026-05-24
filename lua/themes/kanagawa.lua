return { -- You can easily change to a different colorscheme.
  -- Change the name of the colorscheme plugin below, and then
  -- change the command in the config to whatever the name of that colorscheme is.
  --
  -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
  'rebelot/kanagawa.nvim',
  priority = 1000, -- Make sure to load this before all the other start plugins.
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    -- Default options:
    require('kanagawa').setup {

      compile = true, -- false -- TEST: enable compiling the colorscheme
      undercurl = true,
      commentStyle = { italic = true },
      functionStyle = {},
      keywordStyle = { italic = true },
      statementStyle = { bold = true },
      typeStyle = {},
      transparent = false, -- do not set background color
      dimInactive = true, -- dim inactive window `:h hl-NormalNC`

      terminalColors = true, -- define vim.g.terminal_color_{0,17}
      colors = { -- add/modify theme and palette colors
        palette = {},
        theme = {
          wave = {},
          lotus = {},
          dragon = {},
          all = {
            -- ui = { bg_gutter = 'none' },
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

    -- vim.api.nvim_create_autocmd({ 'BufWritePost', 'FileWritePost' }, { -- TODO: find out how to autosave next time VimEnter after edit this file
    --   desc = 'When kanagawa.lua is written, do `:KanagawaCompile`',
    --   group = vim.api.nvim_create_augroup('Kanagawa-compile-on-save', { clear = true }),
    --
    --   pattern = '*.config/nvim/lua/*/kanagawa.lua',
    --   callback = function() vim.cmd 'KanagawaCompile' end,
    -- })

    -- TODO: This could be really usefull as a "global" autocmd used in general...
    local seen = {}
    local kanaLuaPath = vim.fn.stdpath 'config' .. '/lua/themes/kanagawa.lua'
    vim.api.nvim_create_autocmd('BufEnter', {
      desc = 'When kanagawa.lua is Entered after prev change, do `:KanagawaCompile`',
      group = vim.api.nvim_create_augroup('KanagawaCompile-on-enter-after-save', { clear = true }),
      pattern = kanaLuaPath,

      callback = function(args)
        -- check if first read
        local curFile = vim.api.nvim_buf_get_name(args.buf)
        if seen[curFile] then
          -- print('DEBUG: Not first time entering ' .. vim.fn.expand '%')
          return
        else
          -- read old hash
          local kanaHashPath = vim.fn.stdpath 'data' .. '/kanagawa.hash'
          local f = io.open(kanaHashPath, 'r')
          local prev_hash
          if f then
            prev_hash = f:read '*l'
            f:close()
            -- print('DEBUG: prev_hash =', prev_hash)
          end

          -- get new hash
          local new_hash = vim.fn.system { 'sha256sum', kanaLuaPath }
          new_hash = new_hash:match '^%w+'
          -- print('DEBUG: new_hash =', new_hash)

          -- compile if the file has been changed (according to sha256sum)
          if new_hash ~= prev_hash then
            -- print("DEBUG:", new_hash, '!=', prev_hash, 'Not equal, and that means: ')
            vim.cmd 'KanagawaCompile'
            local f2 = io.open(kanaHashPath, 'w')
            if f2 then
              f2:write(new_hash)
              f2:close()
            end
          else
            -- print(new_hash, '=', prev_hash, 'They are equal, nothing ever happens')
          end

          -- mark the file as seen
          seen[curFile] = true
        end
      end,
    })
    --
  end,
}
