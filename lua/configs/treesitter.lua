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
    local parsers = {
      'bash',
      'c',
      'diff',
      'html',
      'lua',
      'luadoc',
      'markdown',
      'markdown_inline',
      'query',
      'vim',
      'vimdoc',
      'zsh',
      'python',
    }
    require('nvim-treesitter').install(parsers)
    vim.api.nvim_create_autocmd('FileType', {
      callback = function(args)
        local buf, filetype = args.buf, args.match

        local language = vim.treesitter.language.get_lang(filetype)
        if not language then return end -- If no lang is detected, just give up

        -- check if parser exists and load it -- BUG: Does it really???
        if not vim.treesitter.language.add(language) then
          vim.keymap.set('n', '<leader>ct', vim.show_pos, { desc = 'TS: position' }) -- Treesitter inspect
          vim.keymap.set('n', 'cT', function()
            vim.treesitter.inspect_tree()
            vim.api.nvim_input 'I' -- INFO: THIS IS HOW YOU INSERT TEXT !!
          end, { desc = 'TS: [T]ree' })
          return
        end
        -- enables syntax highlighting and other treesitter features
        vim.treesitter.start(buf, language)

        -- NOTE: I could create a new autocmd for only some filetypes and enable these
        --
        -- enables treesitter based folds -- see `:help folds`
        vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        vim.wo.foldmethod = 'expr'
        -- enables treesitter based indentation
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
    -- require('nvim-treesitter').setup(opts)
  end,
}
