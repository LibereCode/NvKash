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
vim.hl.hl_op {}

-- HACK: Add more down below

-- TODO: autocmd template to track file change-state with `sha256sum`
--
-- local seen = {}
-- local kanaLuaPath = vim.fn.stdpath 'config' .. '/lua/themes/kanagawa.lua'
-- local kanaStatePath = vim.fn.stdpath 'state' .. '/kanagawa.hash' --
-- vim.api.nvim_create_autocmd('BufEnter', {
--   desc = 'When kanagawa.lua is Entered after prev change, do `:KanagawaCompile`',
--   group = vim.api.nvim_create_augroup('KanagawaCompile-on-enter-after-save-old', { clear = true }),
--   pattern = kanaLuaPath,
--
--   callback = function(args)
--     -- check if first read
--     local curFile = vim.api.nvim_buf_get_name(args.buf)
--     if seen[curFile] then
--       -- print('DEBUG: Not first time entering ' .. vim.fn.expand '%')
--       return
--     else
--       -- read old hash
--       -- local kanaHashPath = vim.fn.stdpath 'data' .. '/kanagawa.hash'
--       local f = io.open(kanaStatePath, 'r')
--       local prev_hash
--       if f then
--         prev_hash = f:read '*l'
--         f:close()
--         -- print('DEBUG: prev_hash =', prev_hash)
--       end
--
--       -- get new hash
--       local new_hash = vim.fn.system { 'sha256sum', kanaLuaPath }
--       new_hash = new_hash:match '^%w+'
--       -- print('DEBUG: new_hash =', new_hash)
--
--       -- compile if the file has been changed (according to sha256sum)
--       if new_hash ~= prev_hash then
--         -- print("DEBUG:", new_hash, '!=', prev_hash, 'Not equal, and that means: ')
--         vim.cmd 'KanagawaCompile'
--         local f2 = io.open(kanaStatePath, 'w')
--         if f2 then
--           f2:write(new_hash)
--           f2:close()
--         end
--       else
--         -- print(new_hash, '=', prev_hash, 'They are equal, nothing ever happens')
--       end
--
--       -- mark the file as seen
--       seen[curFile] = true
--     end
--   end,
-- })

-- niri-archcraft-niri-nvim-from-lazyvim
-- Ensure terminal opens in current working directory
autocmd('TermOpen', {
  callback = function()
    local ol = vim.opt_local
    ol.number = false
    ol.relativenumber = false
    ol.signcolumn = 'no'
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
      vim.cmd 'normal! g`"' -- INFO: g`" == g` (do not change jumplist) + g" (last know position)
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
--     if textwidth >= 80 then vim.opt.colorcolumn = tostrin=g(textwidth) .. ',80' end -- tostring(textwidth-20)
--   end,
-- }) -- bruh, could've just done `set colorcolumn=+0` to match textwidth (see :h colorcolumn)

autocmd({ 'WinResized', 'WinEnter' }, { --  -- change colorcolumn with screenwidth
  desc = 'When window is resized (prehaps) change sidescrolloff',
  group = augroup('WinResized-sidescroll', { clear = true }),
  callback = function()
    if vim.o.filetype ~= 'help' then -- the problem was: vim.fn.filetype
      local curwidth = vim.fn.winwidth(0)
      -- vim.opt_local.sidescroll = 0
      vim.opt_local.sidescrolloff = math.floor(curwidth / 2.5) -- math.max(..., 40)
    end
  end,
})

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

-- TODO: do something(?) when a file is externally editied
-- see :h watch-file

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

cr_cmd('W', 'w', { desc = 'fix common typo of "w"' })

-- v\im.cmd 'cd %:h' -- XXX: ??? why did I do this ???
