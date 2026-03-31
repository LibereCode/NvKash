return { -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  branch = 'main',
  -- opts = {
  --   enable = true, -- false => disables extension
  --   disable = { 'norg' },
  -- },  -- XXX: fuck this
  --
  -- [[ Configure Treesitter ]] See `:help nvim-treesitter-intro`
  -- config = function(_, opts)
  config = function()
    local parsers = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc', 'zsh', 'python' }
    require('nvim-treesitter').install(parsers)
    vim.api.nvim_create_autocmd('FileType', {
      callback = function(args)
        local buf, filetype = args.buf, args.match

        local language = vim.treesitter.language.get_lang(filetype)
        if not language then return end

        -- check if parser exists and load it
        if not vim.treesitter.language.add(language) then return end
        -- enables syntax highlighting and other treesitter features
        vim.treesitter.start(buf, language)

        -- NOTE: enables treesitter based folds
        -- for more info on folds see `:help folds` -- HACK:
        vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        vim.wo.foldmethod = 'expr'

        -- NOTE: enables treesitter based indentation
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
    -- require('nvim-treesitter').setup(opts)
  end,
}
