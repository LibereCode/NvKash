-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = augroup('highlight-yank', { clear = true }), -- kickstart-highlight-yank
  -- callback = function() vim.hl.on_yank() end,
  callback = function() vim.hl.hl_op() end,
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

-- autocmd({ 'InsertCharPre' }, { -- XXX: (cursed) moving colorcolumn (moves with cursor)
--   callback = function() --
--     vim.o.colorcolumn = tostring(vim.api.nvim_win_get_cursor(0)[2] + 1)
--   end,
-- })

-- autocmd('WinResized', { -- change colorcolumn with screenwidth
--   group = augroup('colorcolumn-follow-columns', { clear = true }),
--   callback = function() vim.o.colorcolumn = tostring(vim.o.columns - 5) .. ',-10' end,
-- })

-- autocmd('OptionSet', { -- make 'colorcolumn' auto-match textwidth -- DUMB!
--   pattern = { 'textwidth' },
--   group = augroup('colorcolumn-match-textwidth', { clear = true }),
--   callback = function() --
--     local textwidth = vim.o.textwidth
--     if textwidth >= 80 then vim.opt.colorcolumn = tostring(textwidth) .. ',80' end -- tostring(textwidth-20)
--   end,
-- }) -- bruh, could've just done `set colorcolumn=+0` to match textwidth (see :h colorcolumn)

-- autocmd('BufDelete', { -- show :intro when all buffers are 💀
--   callback = function()
--     local bufs = vim.t.bufs
--     if #bufs == 1 and vim.api.nvim_buf_get_name(bufs[1]) == '' then vim.cmd 'intro' end
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

-- Makes file.conf (and ghostty-conf.boo) into filetype "cfg" syntax
autocmd('BufEnter', { -- TEST: which group should I ?
  pattern = { '*.conf', '*.boo' },
  desc = 'file.conf -> file.cfg syntax',
  -- command = 'set ft=cfg',
  -- once = true,
  callback = function() -- TEST:
    if vim.o.filetype == 'conf' then vim.opt.filetype = 'cfg' end -- ~= "hyprlang"
  end,
})

-- INFO: Commands (vim.api.nvim_create_user_command &AND& vim.cmd(''))
local cr_cmd = vim.api.nvim_create_user_command -- ('name', 'command', {})

-- -- XXX: MOVED TO NeoVim/dev/printTreeTable.nvim (REMOVE)
-- ---Used in _user_command_ `TreeTable`
-- ---@param value any
-- ---@param func function
-- ---@param tabs? integer
-- local ifTableFunc = function(value, func, tabs)
--   tabs = tabs or 0
--   local tabString = string.rep('	', tabs)
--
--   if type(value) == 'table' then
--     for key, val in pairs(value) do
--       print(tabString .. key)
--       func(val, func, tabs + 1)
--     end
--   else
--     print(tabString .. '= ' .. tostring(value))
--   end
-- end
-- cr_cmd('TreeTable', function(opts)
--   print('\n-------------- TreeTable: ' .. '' .. ' ------------------')
--   local tableName = opts.args
--   local tableIn = _G[tableName] -- converts into table?
--   if type(tableIn) == 'table' then
--     ifTableFunc(tableIn, ifTableFunc)
--   else
--     print('Error: ' .. tableName .. ' is not a table')
--   end
-- end, {
--   nargs = 1,
--   desc = [[Print Tree-structure of a table-nested table.
-- USE:
--   :lua GlobalTable = require('lualine').get_config()
--   :TreeTable GlobalTable]],
-- })

-- v\im.cmd 'cd %:h' -- XXX: ??? why did I do this ???
