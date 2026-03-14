-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

local autocmd = vim.api.nvim_create_autocmd
local cmnd = vim.api.nvim_create_user_command

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

-- HACK: Add more down below

-- niri-archcraft-niri-nvim-from-lazyvim
-- Ensure terminal opens in current working directory
autocmd('TermOpen', {
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = 'no'
    vim.cmd 'startinsert'
  end,
})
--
-- -- Ensure format on save is enabled -- HACK: is inside config.conform
-- autocmd('BufWritePre', {
--   pattern = '*',
--   callback = function(args) require('conform').format { bufnr = args.buf } end,
-- })

autocmd('BufReadPost', { -- Restore cursor position
  pattern = '*',
  callback = function()
    local line = vim.fn.line '\'"'
    if line > 1 and line <= vim.fn.line '$' and vim.bo.filetype ~= 'commit' and vim.fn.index({ 'xxd', 'gitrebase' }, vim.bo.filetype) == -1 then
      vim.cmd 'normal! g`"'
    end
  end,
})

-- autocmd('BufDelete', { -- show NvDash when all buffers are 💀 -- TODO: change to other starter
--   callback = function()
--     local bufs = vim.t.bufs
--     if #bufs == 1 and vim.api.nvim_buf_get_name(bufs[1]) == '' then vim.cmd 'Nvdash' end
--   end,
-- })
