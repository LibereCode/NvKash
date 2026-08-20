return { -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  branch = 'main',
  -- opts = {
  --   enable = true, -- false => disables extension
  -- },
  --
  -- [[ Configure Treesitter ]] See `:help nvim-treesitter-intro`
  -- config = function(_, opts)
  config = function()
    local nvimTS = require 'nvim-treesitter'

    local tsParsersExtra = {
      'bash',
      'c',
      'cpp',
      'css',
      'diff',
      'html',
      'json',
      'json5',
      'kdl',
      'lua',
      'luadoc',
      'markdown',
      'markdown_inline',
      'nix',
      'python',
      'rust',
      'query',
      'toml',
      'vim',
      'vimdoc',
      'zig',
      'zsh',
    }
    local tsParsersStable = nvimTS.get_available(1)
    -- Ensure these TS-parsers are installed
    local tsParsers = vim.tbl_extend('force', tsParsersStable, tsParsersExtra)
    nvimTS.install(tsParsers, { summary = false })

    vim.api.nvim_create_autocmd('FileType', {
      callback = function(args)
        local filetype, buf = args.match, args.buf -- args.match = vim.o.filetype

        -- either treesitter specific **language** (see `:h vim.treesitter.language.register()`)
        -- OR just the same as **filetype**
        local lang = vim.treesitter.language.get_lang(filetype)
        if lang == 'ghostty' or lang == 'conf' then
          lang = 'ini'
        elseif not lang then
          return
        end -- If no lang is detected, just give up

        local tsAddOk, tsAddErr = vim.treesitter.language.add(lang)

        -- if parser exists and start treesitter for **buf**
        if tsAddOk then
          -- enables syntax highlighting and other treesitter features
          vim.treesitter.start(buf, lang)

          -- set some Treesitter-keymaps
          vim.keymap.set('n', '<leader>ut' --[[cs|ct]], vim.show_pos, { desc = 'TS: posi[t]ion', buf = buf })
          vim.keymap.set('n', '<leader>uT'--[[cS|cT]], function()
            vim.treesitter.inspect_tree()
            vim.api.nvim_input 'I' -- INFO: THIS IS (in one way) HOW YOU INSERT TEXT !!
          end, { desc = 'TS: [T]yntaxTree', buf = buf })

          -- enables treesitter based folds -- see `:help folds`
          vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
          vim.wo.foldmethod = 'expr'
          -- enables treesitter based indentation
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        else
          -- PERF: DEBUG:
          -- print('vim.treesitter.language.add("' .. language .. '").err = ' .. tsAddErr)

          -- NOTE: if no parser, then install the language's parser if treesitter has it
          local tsParsersMatch = table.concat(nvimTS.get_available(), ' '):match(' ' .. lang .. ' ')
          if tsParsersMatch then
            -- print('DEBUG: NOT installed -> installing (language/tsParsersMatch)', language, tsParsersMatch)
            nvimTS.install(lang)
          end
          return
        end
      end,
    })

    -- NOTE: uninstall all parsers:
    -- nvimTS.uninstall(nvimTS.get_installed())

    -- require('nvim-treesitter').setup(opts)
    -- NOTE: will be prepended to |runtimepath|.
  end,
}
