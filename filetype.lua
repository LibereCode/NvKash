-- INFO: see :h new-filetype

-- local autocmd = vim.api.nvim_create_autocmd
-- local augroup = vim.api.nvim_create_augroup
--
-- autocmd({ 'BufRead', 'BufNewFile' }, {
--   group = augroup('custom_filetypes', { clear = true }),
--   pattern = { '*.todo.txt', 'todo.txt', '*.todotxt' },
--   callback = function() vim.opt_local.filetype = 'todotxt' end,
-- })

-- INFO: see :h vim.filetype.add()

vim.filetype.add {
  extension = {
    todotxt = 'todotxt',
  },
  filename = {
    ['todo.txt'] = 'todotxt',
  },
  pattern = {
    ['*.todo.txt'] = 'todotxt',
  },
}
