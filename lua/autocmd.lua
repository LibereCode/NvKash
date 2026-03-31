-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

local autocmd = vim.api.nvim_create_autocmd

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

-- HACK: UI AUTOCMD specify all plugins to not show !!
local ui_filetypes = { 'alpha', 'lazy', 'mason', 'help' }
vim.api.nvim_create_autocmd('FileType', {
  pattern = ui_filetypes,
  callback = function() vim.b.miniindentscope_disable = true end,
})

-- -- From `:h compl-autocomplete`
-- local triggers = { '.' }
-- vim.api.nvim_create_autocmd('InsertCharPre', {
--   buffer = vim.api.nvim_get_current_buf(),
--   callback = function()
--     if vim.fn.pumvisible() == 1 or vim.fn.state 'm' == 'm' then return end
--     local char = vim.v.char
--     if vim.list_contains(triggers, char) then
--       local key = vim.keycode '<C-x><C-n>'
--       vim.api.nvim_feedkeys(key, 'm', false)
--     end
--   end,
-- }) -- kinda sucked

-- INFO: Commands (vim.api.nvim_create_user_command &AND& vim.cmd(''))
local cr_cmd = vim.api.nvim_create_user_command -- ('name', 'command', {})
local cmd = vim.cmd -- (':cmd')

cr_cmd('W', 'SudaWrite', {})
-- cmd 'cd %:h' -- fucks up if not entering file
