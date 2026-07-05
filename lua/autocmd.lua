-- ========================
-- [[ Basic Autocommands ]]
-- ========================
--  See `:help lua-guide-autocommands`

---Create an autocmd with augroup
---@param events vim.api.keyset.events | table<vim.api.keyset.events>
---@param augroupName string The name off the augroup
---TIP: if struggle with name, just name it _"< events >-< a thing it does >"_
---@param autoOpts vim.api.keyset.create_autocmd
local function autocmd(events, augroupName, autoOpts)
  local augroup = vim.api.nvim_create_augroup(augroupName, { clear = true })
  autoOpts = vim.tbl_extend('force', { group = augroup }, autoOpts)
  vim.api.nvim_create_autocmd(events, autoOpts)
end

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
autocmd('TextYankPost', 'highlight-yank', {
  desc = 'Highlight when yanking (copying) text',
  -- callback = function() vim.hl.on_yank() end,
  callback = function() vim.hl.hl_op() end,
})

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

autocmd('TermEnter', 'TermEnter-startinsert', {
  callback = function()
    vim.cmd 'startinsert'
    vim.api.nvim_win_set_config(0, { style = 'minimal' })
  end,
})
--
autocmd('BufReadPost', 'BufReadPost-restore-cursor', { -- :h restore-cursor
  pattern = '*',
  callback = function()
    local line = vim.fn.line '\'"'
    if line > 1 and line <= vim.fn.line '$' and vim.bo.filetype ~= 'commit' and vim.fn.index({ 'xxd', 'gitrebase' }, vim.bo.filetype) == -1 then
      vim.cmd 'normal! g`"' -- INFO: g`" == g` (do not change jumplist) + g" (last know position)
    end
  end,
})

-- -- USE `:h cursorcolumn` instead !!
-- autocmd({ 'InsertCharPre' }, { -- XXX: (cursed) moving colorcolumn (moves with cursor)
--   callback = function() --
--     vim.o.colorcolumn = tostring(vim.api.nvim_win_get_cursor(0)[2] + 1)
--   end,
-- })
autocmd({ 'WinEnter' }, 'WinEnter-no-cursorcolumn', {
  command = 'set nocursorcolumn', -- set cursorline nocursorcolumn
})
autocmd({ 'WinLeave' }, 'WinLeave-cursorcolumn', {
  command = 'set cursorcolumn', -- set nocursorline cursorcolumn
})

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

-- autocmd({ 'WinResized', 'WinEnter' }, { --  -- change colorcolumn with screenwidth
--   desc = 'When window is resized (prehaps) change sidescrolloff',
--   group = augroup('WinResized-sidescroll', { clear = true }),
--   callback = function()
--     if vim.o.filetype ~= 'help' then -- the problem was: vim.fn.filetype
--       local curwidth = vim.fn.winwidth(0)
--       -- vim.opt_local.sidescroll = 0
--       vim.opt_local.sidescrolloff = math.floor(curwidth / 2.5) -- math.max(..., 40)
--     end
--   end,
-- })

-- autocmd('BufDelete', { -- show :intro when all buffers are 💀
--   callback = function()
--     local bufs = vim.t.bufs
--     if #bufs == 1 and vim.api.nvim_buf_get_name(bufs[1]) == '' then vim.cmd 'intro' end
--   end,
-- })

-- HACK: UI AUTOCMD specify all plugins to not show !!
local ui_filetypes = { 'alpha', 'lazy', 'mason', 'help' }
autocmd('FileType', 'FileType-miniindentscope_disable', {
  pattern = ui_filetypes,
  callback = function() vim.b.miniindentscope_disable = true end,
})

-- -- Makes file.conf (and ghostty-conf.boo) into filetype "cfg" syntax
-- autocmd('BufEnter', 'BufEnter-conf-boo-set_ft=cfg', {
--   pattern = { '*.conf', '*.boo' },
--   desc = 'file.conf -> file.cfg syntax',
--   -- command = 'set ft=cfg',
--   -- once = true,
--   callback = function()
--     if vim.o.filetype == 'conf' then vim.opt.filetype = 'cfg' end -- ~= "hyprlang"
--   end,
-- })
autocmd('BufEnter', 'BufEnter-boo-ghostty', {
  -- pattern = { '*.boo' },
  pattern = { '**/ghostty/**' },
  desc = 'file.boo -> ft=ghostty',
  callback = function()
    local ft = vim.o.filetype
    if ft == 'conf' then ft = 'ghostty' end
  end,
})

autocmd('BufEnter', 'BufEnter-log-set_ft=log', {
  pattern = '*.log',
  desc = 'file.log -> set ft=log',
  command = 'set ft=log',
  -- once = true,
})

autocmd('CmdwinEnter', 'CmdwinEnter-syntaxHL', {
  callback = function()
    vim.o.filetype = 'lua' -- FIXME: Enable Cmdwin syntax in a better way.
  end,
})

-- TODO: do something(?) when a file is externally editied
-- see :h watch-file

-- TODO: Test some `:h autocmd-events`
-- -[ ] `:h ModeChanged`
-- -[ ] `:h CmdwinEnter`

-- ==================================================
-- Commands (vim.api.nvim_create_user_command &AND& vim.cmd(''))
-- ==================================================
local cr_cmd = vim.api.nvim_create_user_command -- ('name', 'command', {})

cr_cmd('W', 'w', { desc = 'fix common typo of "w"' })

-- v\im.cmd 'cd %:h' -- XXX: ??? why did I do this ???
