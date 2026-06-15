-- NOTE: this file is clean, and
-- and can be exported to whatever config
-- Will use `INFO` as marking headers
--
-- INFO: [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`
--  also see: /usr/share/nvim/runtime/lua/vim/_core/defaults.lua (for reference)

-- local map = vim.keymap.set
---@param key string|string
---@param cmd string|function
---@param optsExtra vim.keymap.set.Opts? -- `:h vim.keymap.set()` _opts_ tbl
---@param mode string|string[]? -- specify if mode is different than _n_(ormal mode)
local function map(key, cmd, optsExtra, mode)
  local optsMap = vim.tbl_extend('error', {}, optsExtra or {})
  vim.keymap.set(mode or 'n', key, cmd, optsMap)
end
local nomap = vim.keymap.del -- disable (default) mappings

--- @param keys string -- the keys after _<leader>_
--- @param cmd string|function -- `<CMD>foobar<CR>` or lua `function()`
--- @param opts vim.keymap.set.Opts? -- **optional** table of _key=val_ opts
--- @param modes table|string|nil -- **optional** table or string of modes if not _"n"_
--- @return nil -- *return fuck all*
local function leadmap(keys, cmd, opts, modes) -- better leadmap (allows { opts })
  modes = modes or 'n'
  opts = opts or {}
  vim.keymap.set(modes, '<leader>' .. keys, cmd, opts)
end

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

leadmap('do', vim.diagnostic.setloclist, { desc = 'l[o]clist' })
-- leadmap('dd', vim.diagnostic.open_float, { desc = 'floating [d]iagnostics' })
leadmap('dc', function() vim.diagnostic.open_float { scope = 'c' } end, { desc = '[c]ursor diagnostics' })
leadmap('dd', vim.diagnostic.open_float, { desc = 'line [d]diagnostic' }) -- default
leadmap('db', function() vim.diagnostic.open_float { scope = 'b' } end, { desc = '[b]uffer diagnostics' })
leadmap('dl', ':log<CR>')
local function toggleDiagnostics(opts) ---@param opts? vim.diagnostic.Filter
  opts = opts or {}
  vim.diagnostic.enable(not vim.diagnostic.is_enabled(opts), opts)
end
leadmap('dt', function() toggleDiagnostics() end, { desc = '[t]oggle diagnostics (globally)' })
leadmap('ud', function() toggleDiagnostics { bufnr = 0 } end, { desc = '[d]diagnostics' })

-- INFO: TERMINAL
--
leadmap('tv', ':vert te<CR>', { desc = 'vterm' })
leadmap('th', ':hor te<CR>', { desc = 'term' })
leadmap('tT', function() vim.cmd.terminal() end, { desc = 'Terminal buffer' })
--
-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
map('<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' }, 't')
map('<C-Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' }, 't') --TEST:
map('<M-Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' }, 't') --TEST:

-- TIP: Disable arrow keys in normal mode
-- map('<left>', '<cmd>echo "Use h to move!!"<CR>')
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

-- leadmap('|', ':vsplit<CR>', { desc = 'vertical[|]split' }) -- <C-w>v
-- leadmap('_', ':split<CR>', { desc = 'horizontal[_]split' }) -- <C-w>s

-- TODO: Move this (expaned version with state keeping) to a new plugin "QoL.nvim"
leadmap('T', function()
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

leadmap('bb', '<cmd>e #<cr>', bufopts { desc = 'switch to other' })
leadmap('bl', '<cmd>buffers<CR>', bufopts { desc = '[l]ist buffers' })
leadmap('bn', '<cmd>enew<CR>', bufopts { desc = 'new buf-file' })
leadmap('bd', '<cmd>bn<BAR>bd #<CR>', bufopts { desc = '[d]elete' })
-- leadmap('bd', '<Cmd>bn <BAR> bd #<CR>', bufopts { desc = '[D]ELETE' }) -- see ./plugins/ui/bufferline.lua
leadmap('x', '<cmd>bn<BAR>bd #<CR>', bufopts { desc = 'delete[x]buffer' })
-- map('H', '<cmd>bp<CR>', bufopts { desc = 'prev buf' }) -- moved to
-- map('L', '<cmd>bn<CR>', bufopts { desc = 'next buf' }) -- './plugins/ui/bufferline.lua'

-- tabs
leadmap('<tab>l', '<cmd>tabs<CR>', { desc = 'tab list' })
leadmap('<tab><tab>', '<cmd>tabnew<CR>', { desc = 'new' })
leadmap('<tab>d', '<cmd>tabclose<CR>', { desc = 'delete' })
leadmap('<tab>p', '<cmd>tabprev<CR>', { desc = 'prev' })
leadmap('<tab>n', '<cmd>tabnext<CR>', { desc = 'next' })
leadmap('<tab>t', '<C-W>T', { desc = 'window->newTab' })

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
leadmap('y', '"yy', { desc = '[y]ank 2 "y' }, 'x') -- v
leadmap('p', '"yp', { desc = '[p]aste from "y' }, 'x') -- v
map('<C-y>', '"yy', { desc = '[y]ank 2 "y' }, 'x') -- v -- Really usefull, so I made it appear  multiple ...
map('<C-p>', '"yp', { desc = '[p]aste from "y' }, 'x') -- v -- ... places (either <leader>y/p or <C-y/p>)
leadmap('d', '"yd', { desc = '[d]elete 2 "y' }, 'x') -- v
leadmap('p', '"yp', { desc = '[p]aste "y' }, { 'n', 'x' }) -- v

leadmap('P', '"_dd<ESC>P', { desc = 'delete->[p]aste, no❌yank' }, { 'n', 'x' }) -- v

-- Insert-mode
map('<C-v>', '<ESC>pa', { desc = 'Paste in I-mode', remap = true }, 'i') -- NOTE: Use  (^Q = <C-q>) Instead of (<C-v>) to do the thing

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
leadmap('qw', '<CMD>wa<CR>', { desc = '[w]rite all' })
leadmap('qs', '<CMD>w <BAR> so | echo "written & sauced"<CR>', { desc = 'save & sauce' }) -- figure out why I can't sauce this file
leadmap('qq', '<CMD>qa<CR>', { desc = '[q]uit all' })
leadmap('qr', '<CMD>restart<CR>', { desc = '[r]estart nvim' })
map('<C-A-s>', '<cmd>write<CR><cmd>source<CR><cmd>echo("written & sauced")<CR>', { desc = 'Save&sauce' }) -- NOTE: 'macros' (multiple cmd chained) are possible like this
map('<C-s>', '<cmd>write<CR>', { desc = 'save' })
map('<C-q>', '<cmd>quit<CR>', { desc = 'quit' })

-- INFO: UI toggles (builtin)
--
leadmap('uw', '<CMD>set wrap!<CR>', { desc = 'toggles [w]rap' })
leadmap('ul', '<CMD>set nu!<CR>', { desc = 'toggle [l]ine-nr' })
leadmap('ur', '<CMD>set rnu!<CR>', { desc = 'toggle [r]elative-line-nr' })
leadmap('uL', '<CMD>set cul!<CR>', { desc = 'toggle cursor-[L]ine' })
-- leadmap('tw', '<CMD>set wrap!<CR>', { desc = '[w]rap' })
-- leadmap('tl', '<CMD>set nu!<CR>', { desc = '[l]ine-nr' })
-- leadmap('tr', '<CMD>set rnu!<CR>', { desc = '[r]elative-line-nr' })
-- leadmap('tL', '<CMD>set cul!<CR>', { desc = 'cursor-[L]ine' })
-- leadmap('ut', function()
--   vim.ui.input({ prompt = 'Enter value for Tab-stuff: ' }, function(input) -- type option
--     local tabStuff = tonumber(input) -- from `:h vim.ui.input()`
--     vim.opt.tabstop = tabStuff
--     vim.opt.softtabstop = tabStuff
--     -- vim.opt.shiftwidth = tabStuff
--   end)
-- end, { desc = 'set [t]abStuff' })

-- INFO: open/organize
--
leadmap('oo', function()
  local curfile = vim.fn.expand '%:p'
  vim.fn.jobstart({ 'handlr', 'open', curfile }, { detach = true })
end, { silent = true, desc = 'Handlr open' })
leadmap('oI', ':intro<CR>')
leadmap('ov', function()
  vim.cmd('e ' .. vim.uv.fs_realpath( -- opens the file:
    vim.env.XDG_CONFIG_HOME -- ~/.config/vale/styles/config/vocabularies/MyVocab/accept.txt
      .. '/vale/styles/config/vocabularies/MyVocab/accept.txt'
  ))
end, { desc = 'vale [v]ocab' })

-- INFO: Code
-- NOTE, most are based on plugins and should't be here
--
leadmap('ch', '<CMD>checkhealth<CR>')

-- INFO: Insert
--
leadmap('is', '<cmd>smile<CR>')

leadmap('ic', function() -- Odly (cursed) good
  local insert = vim.api.nvim_input
  insert '75i=<ESC>gcc"cyy"cpO' -- if not work (no auto comment), add to:
  -- insert '<ESC>ccHEADER_HERE<ESC>gcc' -- Need tweaking though...
end, { desc = 'Header separater' })

leadmap('id', function() -- Odly (cursed) good -- make into a snippet/registry
  local insert = vim.api.nvim_input
  insert 'dd<ESC>O<ESC>gccO<ESC>o<lt><lt><CR>>><ESC>O=<ESC>9a=<ESC>Pgcip}kP{dd}dd' -- almost easy to read...
end, { desc = 'comment<<>>[d]iff' }, { 'x', 'n' }) -- v -- NOTE: FUCKING PEAK !!

-- TEST: Messages?
--
leadmap('m', '<CMD>messages<CR>')

-- DUMB... TEST:

leadmap('it', ':echo "test?"') -- allows to write a cmd starting with 'echo("test?")' (so you can finish it)
leadmap('ib', '<cmd>echo "hello world 1"<Bar>echo "hello world 2"<CR>', { desc = '<bar> allows multiple commands' })
leadmap('i:', ': | only<HOME>') -- Fullscreen a cmd

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
-- leadmap(':', function() neoCmdWin() end, { desc = 'lua cmd-buf' })
-- map('<M-;>', function() neoCmdWin() end, { desc = 'lua cmd-buf' })
