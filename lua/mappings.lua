-- NOTE: this file is clean, and
-- and can be exported to whatever config
-- Will use `INFO` as marking headers
--
-- INFO: [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`
--  also see: /usr/share/nvim/runtime/lua/vim/_core/defaults.lua (for reference)

-- local map = vim.keymap.set
---@param key string|string[] in nvim 0.13 you can have `key-arr[]`
---@param cmd string|function
---@param optsExtra vim.keymap.set.Opts? -- `:h vim.keymap.set()` _opts_ tbl
---@param mode string|string[]? -- specify if mode is different than _n_(ormal mode)
local function map(key, cmd, optsExtra, mode)
  local optsMap = vim.tbl_extend('error', {}, optsExtra or {})
  vim.keymap.set(mode or 'n', key, cmd, optsMap)
end
local nomap = vim.keymap.del -- disable (default) mappings

-- --- @param keys string -- the keys after _<leader>_
-- --- @param cmd string|function -- `<CMD>foobar<CR>` or lua `function()`
-- --- @param opts vim.keymap.set.Opts? -- **optional** table of _key=val_ opts
-- --- @param modes table|string|nil -- **optional** table or string of modes if not _"n"_
-- --- @return nil -- *return fuck all*
-- local function leadmap(keys, cmd, opts, modes) -- better leadmap (allows { opts })
--   modes = modes or 'n'
--   opts = opts or {}
--   vim.keymap.set(modes, '<leader>' .. keys, cmd, opts)
-- end

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
-- map('<Esc>', '<cmd>nohlsearch<CR>')
map('<Esc>', '<cmd>nohl<CR>:<C-c>')
-- map(';', ':', { desc = 'cmd-line' })
-- map(',', ':', { desc = 'cmd-line' })
map('<C-;>', function()
  if vim.fn.getcmdwintype() == ':' then
    vim.cmd.q()
  else
    vim.api.nvim_input 'q:' -- see also :h 'cedit'
  end
end, { desc = 'toggle [:]cmd-line window' })
map('<C-;>', function() --
  vim.api.nvim_input(vim.o.cedit)
end, { desc = 'alt cedit bind' }, 'c')
-- :h cmdline-editing
map('<C-a>', '<HOME>', {}, 'c')
map('<C-b>', '<S-Left>', {}, 'c')
map('<C-f>', '<S-Right>', {}, 'c')

-- Diagnostics

map('<leader>do', function() vim.diagnostic.setloclist() end, { desc = 'l[o]clist' })
-- map('<leader>dd', vim.diagnostic.open_float, { desc = 'floating [d]iagnostics' })
map('<leader>dc', function() vim.diagnostic.open_float { scope = 'c' } end, { desc = '[c]ursor diagnostics' })
map('<leader>dd', function() vim.diagnostic.open_float() end, { desc = 'line [d]diagnostic' }) -- default
map('<leader>db', function() vim.diagnostic.open_float { scope = 'b' } end, { desc = '[b]uffer diagnostics' })
map('<leader>dl', ':log<CR>')
local function toggleDiagnostics(opts) ---@param opts? vim.diagnostic.Filter
  opts = opts or {}
  vim.diagnostic.enable(not vim.diagnostic.is_enabled(opts), opts)
end
map('<leader>dt', function() toggleDiagnostics() end, { desc = '[t]oggle diagnostics (globally)' })
map('<leader>ud', function() toggleDiagnostics { bufnr = 0 } end, { desc = '[d]diagnostics' })

-- INFO: TERMINAL
--
map('<leader>tv', ':vert te<CR>', { desc = 'vterm' })
map('<leader>th', ':hor te<CR>', { desc = 'term' })
map('<leader>tT', function() vim.cmd.terminal() end, { desc = 'Terminal buffer' })
--
-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
map({
  '<Esc><Esc>',
  '<C-Esc>',
  '<M-Esc>',
}, '<C-\\><C-n>', { desc = 'Exit terminal mode' }, 't')

-- TIP: Disable arrow keys in normal mode
-- map('<left>', '<cmd>echo "Use h to move!!"<CR>'e
-- map('<right>', '<cmd>echo "Use l to move!!"<CR>')
-- map('<up>', '<cmd>echo "Use k to move!!"<CR>')
-- map('<down>', '<cmd>echo "Use j to move!!"<CR>')

-- INFO: Windows/buffers/tabs
--
-- windows -- See `:help wincmd` for list
local wincmd = vim.cmd.wincmd
map('<C-h>', function() wincmd 'h' end, { desc = 'Move focus to the left window' })
map('<C-l>', function() wincmd 'l' end, { desc = 'Move focus to the right window' })
map('<C-j>', function() wincmd 'j' end, { desc = 'Move focus to the lower window' })
map('<C-k>', function() wincmd 'k' end, { desc = 'Move focus to the upper window' })
-- NOTE Some terminals have colliding keymaps or are not able to send distinct keycodes
map('<C-A-h>', function() wincmd 'H' end, { desc = 'Move window to the left' })
map('<C-A-l>', function() wincmd 'L' end, { desc = 'Move window to the right' })
map('<C-A-j>', function() wincmd 'J' end, { desc = 'Move window to the lower' })
map('<C-A-k>', function() wincmd 'K' end, { desc = 'Move window to the upper' })

map('<M-S-->', function() wincmd '2-' end, { desc = '[-] win-height' }) -- '<C-->'
map('<M-S-=>', function() wincmd '2+' end, { desc = '[+] win-height' }) -- '<C-=>'
map('<M-S-,>', function() wincmd '2<' end, { desc = 'widgth less [<]' }) -- '<C-,>'
map('<M-S-.>', function() wincmd '2>' end, { desc = 'width more [>]' }) -- '<C-.>'

-- TEST: better use for <C-tab>
map('<C-TAB>', '<C-w>w', { desc = 'next window' })
map('<C-S-TAB>', '<C-w>W', { desc = 'prev window' })

-- map('<leader>|', ':vsplit<CR>', { desc = 'vertical[|]split' }) -- <C-w>v
-- map('<leader>_', ':split<CR>', { desc = 'horizontal[_]split' }) -- <C-w>s

-- TODO: Move this (expaned version with state keeping) to a new plugin "QoL.nvim"
map('<leader>T', function()
  local getConf = vim.api.nvim_win_get_config(0)
  -- vim.print('>', getConf, '<')
  if getConf.relative ~= '' then --
    vim.api.nvim_win_set_config(0, { split = 'above', win = vim.fn.win_getid(1) })
  else
    vim.api.nvim_win_set_config(0, {
      relative = 'editor',
      width = math.floor(vim.o.columns * 0.8),
      height = math.floor(vim.o.lines * 0.8),
      col = math.floor(vim.o.columns * 0.2 / 2),
      row = math.floor(vim.o.lines * 0.2 / 2),
    })
  end
end, { desc = '[T]uuggle float' })

-- buffers -- see `plugins.ui` bufferline & lualine for more
local function bufopts(tbl) -- otps in vim.keymap.set(), habing noremap and silent
  return vim.tbl_extend('force', { noremap = true, silent = true }, tbl)
end

map('<leader>bb', '<cmd>e #<cr>', bufopts { desc = 'switch to other' })
map('<leader>bl', '<cmd>buffers<CR>', bufopts { desc = '[l]ist buffers' })
map('<leader>bn', '<cmd>enew<CR>', bufopts { desc = 'new buf-file' })
map('<leader>bd', '<cmd>bn<BAR>bd #<CR>', bufopts { desc = '[d]elete' })
-- map('<leader>bd', '<Cmd>bn <BAR> bd #<CR>', bufopts { desc = '[D]ELETE' }) -- see ./plugins/ui/bufferline.lua
map('<leader>x', '<cmd>bn<BAR>bd #<CR>', bufopts { desc = 'delete[x]buffer' })
-- map('H', '<cmd>bp<CR>', bufopts { desc = 'prev buf' }) -- moved to
-- map('L', '<cmd>bn<CR>', bufopts { desc = 'next buf' }) -- './plugins/ui/bufferline.lua'

-- tabs
map('<leader><tab>l', '<cmd>tabs<CR>', { desc = 'tab list' })
map('<leader><tab><tab>', '<cmd>tabnew<CR>', { desc = 'new' })
map('<leader><tab>d', '<cmd>tabclose<CR>', { desc = 'delete' })
map('<leader><tab>p', '<cmd>tabprev<CR>', { desc = 'prev' })
map('<leader><tab>n', '<cmd>tabnext<CR>', { desc = 'next' })
map('<leader><tab>t', '<C-W>T', { desc = 'window->newTab' })

-- INFO: quick commands / QoL
--
map('<C-c>', 'gcc', { desc = 'toggle comment', remap = true }) -- remap required, becuase ?
map('<C-c>', 'gc', { desc = 'v-mode comment', remap = true }, 'x') -- v

map('U', '<C-r>', { desc = '[U]N-undo (redo)' }) -- replace useless vi-like u

-- Selection-mode
map('<C-v>', '<C-o>P', { desc = 'Paste in S-mode', remap = true }, 's' --[[ { 's','i' } -- Made I-mode version better for insert ]]) -- '<C-o>"sp'
map('<C-c>', '<C-o>y', { desc = 'Copy in S-mode', remap = true }, 's') -- '<C-o>"sy'
map('<C-x>', '<C-o>d', { desc = 'Cut in S-mode', remap = true }, 's') -- '<C-o>"sd'
-- NGL, pretty peak (even if it is mouse-based)

-- Visual-mode -- these copies to 'Y'-registry (so seperate from Sys-Clipboard)
map('<leader>y', '"yy', { desc = '[y]ank 2 "y' }, 'x') -- v
map('<leader>p', '"yp', { desc = '[p]aste from "y' }, 'x') -- v
map('<C-y>', '"yy', { desc = '[y]ank 2 "y' }, 'x') -- v -- Really usefull, so I made it appear  multiple ...
map('<C-p>', '"yp', { desc = '[p]aste from "y' }, 'x') -- v -- ... places (either <leader>y/p or <C-y/p>)
map('<leader>d', '"yd', { desc = '[d]elete 2 "y' }, 'x') -- v
map('<leader>p', '"yp', { desc = '[p]aste "y' }, { 'n', 'x' }) -- v

map('<leader>P', '"_dd<ESC>P', { desc = 'delete->[p]aste, no❌yank' }, { 'n', 'x' }) -- v

-- Insert-mode
map('<C-v>', '<ESC>pa', { desc = 'Paste in I-mode', remap = true }, 'i') -- NOTE: Use  (^Q = <C-q>) Instead of (<C-v>) to do the thing
map('#', '<C-h>#', { desc = 'see :smartindent' }) -- why isnt this deafult?

-- better jk
map('j', 'gj', { desc = 'better ↓j', silent = true }, { 'n', 'x' }) -- v
map('k', 'gk', { desc = 'better ↑k', silent = true }, { 'n', 'x' }) -- v

-- move in insert-mode with ALT-hjkl
map('<M-h>', '<Left>', { desc = '←', silent = false }, { 'i', 's', 'c' }) --TODO: 'c'
map('<M-j>', '<Down>', { desc = '↓', silent = false }, { 'i', 's', 'c' })
map('<M-k>', '<Up>', { desc = '↑', silent = false }, { 'i', 's', 'c' })
map('<M-l>', '<Right>', { desc = '→', silent = false }, { 'i', 's', 'c' })

-- jump to local link  -- really weird why `g]` wasen't enough, especially the last esc?
-- map('gL', 'g]1<CR><escape>', { desc = '[L]ocal Link' }) -- NOTE: This disables the default
-- map 'gl' + 'gL' <plugin>leap ([g]o [l]eap) ??

-- inFO: sessions[<leader>q]
--
map('<leader>qw', '<CMD>wa<CR>', { desc = '[w]rite all' })
map('<leader>qs', '<CMD>w <BAR> so | echo "written & sauced"<CR>', { desc = 'save & sauce' }) -- figure out why I can't sauce this file
map('<leader>qq', '<CMD>qa<CR>', { desc = '[q]uit all' })
map('<leader>qr', '<CMD>restart<CR>', { desc = '[r]estart nvim' })
map('<C-A-s>', '<cmd>write<CR><cmd>source<CR><cmd>echo("written & sauced")<CR>', { desc = 'Save&sauce' }) -- NOTE: 'macros' (multiple cmd chained) are possible like this
map('<C-s>', '<cmd>write<CR>', { desc = 'save' })
map('<C-q>', '<cmd>quit<CR>', { desc = 'quit' })

-- INFO: UI toggles (builtin)
--
map('<leader>uw', '<CMD>set wrap!<CR>', { desc = 'toggles [w]rap' })
map('<leader>ul', '<CMD>set nu!<CR>', { desc = 'toggle [l]ine-nr' })
map('<leader>ur', '<CMD>set rnu!<CR>', { desc = 'toggle [r]elative-line-nr' })
map('<leader>uL', '<CMD>set cul!<CR>', { desc = 'toggle cursor-[L]ine' })
-- map('<leader>tw', '<CMD>set wrap!<CR>', { desc = '[w]rap' })
-- map('<leader>tl', '<CMD>set nu!<CR>', { desc = '[l]ine-nr' })
-- map('<leader>tr', '<CMD>set rnu!<CR>', { desc = '[r]elative-line-nr' })
-- map('<leader>tL', '<CMD>set cul!<CR>', { desc = 'cursor-[L]ine' })
-- map('<leader>ut', function()
--   vim.ui.input({ prompt = 'Enter value for Tab-stuff: ' }, function(input) -- type option
--     local tabStuff = tonumber(input) -- from `:h vim.ui.input()`
--     vim.opt.tabstop = tabStuff
--     vim.opt.softtabstop = tabStuff
--     -- vim.opt.shiftwidth = tabStuff
--   end)
-- end, { desc = 'set [t]abStuff' })
map('<leader>uc', function() vim.opt_local.cursorcolumn = not vim.o.cursorcolumn end, { desc = 'toggle [c]ursorColumn' })
map('<leader>uC', function()
  vim.opt_local.cursorline = not vim.o.cursorline
  vim.opt_local.cursorcolumn = not vim.o.cursorcolumn
end, { desc = 'toggle [C]ursor{Line+Column}' })

---@class mapping.mapOpts
---@field key string|string[]
---@field cmd string|function
---@field opts? vim.keymap.set.Opts
---@field mode? string|string[]

---@param mapOpts mapping.mapOpts
local function mapping(mapOpts)
  local key = mapOpts.key
  local cmd = mapOpts.cmd
  local opts = mapOpts.opts or {}
  local mode = mapOpts.mode or 'n'
  vim.keymap.set(mode, key, cmd, opts)
end

mapping { cmd = '<CMD>echo "Hello mappings!"<CR>', key = '<leader>m' }

-- INFO: open/organize
--
map('<leader>oo', function()
  local curfile = vim.fn.expand '%:p'
  vim.fn.jobstart({ 'handlr', 'open', curfile }, { detach = true })
end, { silent = true, desc = 'Handlr open' })
map('<leader>oI', ':intro<CR>')
map('<leader>ov', function()
  vim.cmd('e ' .. vim.uv.fs_realpath( -- opens the file:
    vim.env.XDG_CONFIG_HOME -- ~/.config/vale/styles/config/vocabularies/MyVocab/accept.txt
      .. '/vale/styles/config/vocabularies/MyVocab/accept.txt'
  ))
end, { desc = 'vale [v]ocab' })

-- INFO: Code
-- NOTE, most are based on plugins and should't be here
--
map('<leader>ch', '<CMD>checkhealth<CR>')

-- INFO: Insert
--
map('<leader>is', '<cmd>smile<CR>')

map('<leader>ic', function() -- Odly (cursed) good
  local insert = vim.api.nvim_input
  insert '75i=<ESC>gcc"cyy"cpO' -- if not work (no auto comment), add to:
  -- insert '<ESC>ccHEADER_HERE<ESC>gcc' -- Need tweaking though...
end, { desc = 'Header separater' })

map('<leader>id', function() -- Odly (cursed) good -- make into a snippet/registry
  local insert = vim.api.nvim_input
  insert 'dd<ESC>O<ESC>gccO<ESC>o<lt><lt><CR>>><ESC>O=<ESC>9a=<ESC>Pgcip}kP{dd}dd' -- almost easy to read...
end, { desc = 'comment<<>>[d]iff' }, { 'x', 'n' }) -- v -- NOTE: FUCKING PEAK !!

-- TEST: Messages?
--
map('<leader>m', '<CMD>messages<CR>')

-- DUMB... TEST:

map('<leader>it', ':echo "test?"') -- allows to write a cmd starting with 'echo("test?")' (so you can finish it)
map('<leader>ib', '<cmd>echo "hello world 1"<Bar>echo "hello world 2"<CR>', { desc = '<bar> allows multiple commands' })
map('<leader>i:', ': | only<HOME>') -- Fullscreen a cmd

-- <localleader>
map('<localleader>,', '<cmd>echo "localleader"<Bar>echo "btw"<CR>', { desc = 'localleader mapping' })
-- map()

-- NOTE: see ~/.config/nvim/after/ftplugin/ for spicy stuff !!
--
-- NOTE: see also `configs.lazy` 'custom_keys' (allows lazy keys, but global) https://lazy.folke.io/configuration

-- -- XXX: kind of is its plugin at this point (QoL.nvim ?)
--
-- local cmdBuf = { buf = -1, win = -1 }
-- local neoCmdWin = function() -- TODO: make this a plugin (or part of **QoL.nvim**)
--   if not vim.api.nvim_buf_is_valid(cmdBuf.buf) then cmdBuf.buf = vim.api.nvim_create_buf(false, true) end
--   --
--   if vim.api.nvim_win_is_valid(cmdBuf.win) then
--     if vim.api.nvim_get_current_win() == cmdBuf.win then
--       vim.api.nvim_win_close(cmdBuf.win, false)
--     else
--       vim.api.nvim_set_current_win(cmdBuf.win)
--     end
--   else
--     cmdBuf.win = vim.api.nvim_open_win(cmdBuf.buf, true, {
--       relative = 'editor',
--       anchor = 'SW',
--       row = vim.o.lines - 2,
--       col = vim.o.columns - 2,
--       width = vim.o.columns,
--       height = 3,
--       -- style = 'minimal',
--     })
--   end
--   --
--   vim.bo[cmdBuf.buf].filetype = 'lua'
--   -- NOTE: Have to manually set the lsp (I think). Would like that it set filetype before lsp-check?
--   vim.lsp.start({ name = 'lua_ls', cmd = { 'lua-language-server' } }, { bufnr = cmdBuf.buf })
--   map('<C-CR>', function()
--     vim.cmd.source()
--     vim.cmd.close()
--   end, { desc = 'Source', buf = cmdBuf.buf }, { 'i', 'n' })
--   map('<CR>', '<CMD>so<CR>', { desc = 'Source', buf = cmdBuf.buf }, { 'n' })
--   map('<C-s>', '<CMD>so<CR>', { desc = 'Source', buf = cmdBuf.buf }, { 'n' })
-- end
-- map('<leader>:', function() neoCmdWin() end, { desc = 'lua cmd-buf' })
-- map('<M-;>', function() neoCmdWin() end, { desc = 'lua cmd-buf' })
