require 'nvchad.autocmds' -- ~/.local/share/nvim.dev/lazy/NvChad/lua/nvchad/autocmds
-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`

local autocmd = vim.api.nvim_create_autocmd

autocmd('TextYankPost', { -- Highlight when yanking (copying) text
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

-- niri-archcraft-niri-nvim-from-lazyvim
-- Ensure terminal opens in current working directory
autocmd('TermOpen', {
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = 'no'
  end,
})
-- -- Ensure format on save is enabled -- HACK: is inside config.conform
-- autocmd('BufWritePre', { pattern = '*', callback = function(args) require('conform').format { bufnr = args.buf } end })

-- INFO: Commands
--
local cmnd = vim.api.nvim_create_user_command

cmnd('W', 'SudaWrite', {})

-- HACK: ------- NvChad Recipies --------
-- https://nvchad.com/docs/recipes

-- autocmd('VimEnter', { -- Dynamic term padding
--   command = ':silent !kitty @ set-spacing padding=0 margin=0',
-- })
-- autocmd('VimLeavePre', {
--   command = ':silent !kitty @ set-spacing padding=0 margin=0',
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

autocmd('BufDelete', { -- show NvDash when all buffers are 💀
  callback = function()
    local bufs = vim.t.bufs
    if #bufs == 1 and vim.api.nvim_buf_get_name(bufs[1]) == '' then vim.cmd 'Nvdash' end
  end,
})
