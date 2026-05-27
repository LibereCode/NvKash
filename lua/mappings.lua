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
---@param optsExtra table? -- `:h vim.keymap.set()` _opts_ tbl
---@param mode string|string[]? -- specify if mode is different than _n_(ormal mode)
local function map(key, cmd, optsExtra, mode)
  local optsMap = vim.tbl_extend('error', {}, optsExtra or {})
  vim.keymap.set(mode or 'n', key, cmd, optsMap)
end
local nomap = vim.keymap.del -- disable (default) mappings

--- @param keys string -- the keys after _<leader>_
--- @param cmd string|function -- `<CMD>foobar<CR>` or lua `function()`
--- @param opts table<any, any>|nil -- **optional** table of _key=val_ opts
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
map('<Esc>', '<cmd>nohl<CR>:<C-c>') -- TEST: also clear exec-line
map(';', ':', { desc = 'cmd :' })

-- INFO: Diagnostics/Debug Config & Keymaps
-- See :help vim.diagnostic.Opts
vim.diagnostic.config {
  update_in_insert = false,
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = { min = vim.diagnostic.severity.WARN } },

  -- Can switch between these as you prefer
  virtual_text = true, -- Text shows up at the end of the line
  virtual_lines = false, -- Text shows up underneath the line, with virtual lines

  -- Auto open the float, so you can easily read the errors when jumping with `[d` and `]d`
  -- stylua: ignore start
  ---@diagnostic disable-next-line: undefined-global -- NOTE: Nice annotation
  jump = { on_jump = on_jump },
  -- `:h diagnostic-on-jump-example` -- DEPRECATED: jump = { float = true },
  -- stylua: ignore end
}

leadmap('do', vim.diagnostic.setloclist, { desc = 'l[o]clist' })
leadmap('dd'--[[df, see plugins/telescope.lua]], vim.diagnostic.open_float, { desc = 'floating [d]iagnostics' })
leadmap('dl', ':log<CR>')
local function toggleDiagnostics() vim.diagnostic.enable(not vim.diagnostic.is_enabled()) end
leadmap('dt', toggleDiagnostics, { desc = '[t]oggle diagnostics' })
leadmap('ud', toggleDiagnostics, { desc = '[d]diagnostics' })

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
-- windows
-- Keybinds to make split navigation easier. Use CTRL+<hjkl> to switch between windows
--  See `:help wincmd` for a list of all window commands
map('<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
-- NOTE Some terminals have colliding keymaps or are not able to send distinct keycodes
map('<C-A-h>', '<C-w>H', { desc = 'Move window to the left' })
map('<C-A-l>', '<C-w>L', { desc = 'Move window to the right' })
map('<C-A-j>', '<C-w>J', { desc = 'Move window to the lower' })
map('<C-A-k>', '<C-w>K', { desc = 'Move window to the upper' })

map('<C-->', '<C-w>2-', { desc = '[-] win-height' })
map('<C-=>', '<C-w>2+', { desc = '[+] win-height' }) -- same key as +
map('<C-,>', '<C-w>2<', { desc = 'widgth less [<]' }) -- lower-case <
map('<C-.>', '<C-w>2>', { desc = 'width more [>]' }) -- lower-case >

leadmap('|', ':vsplit<CR>', { desc = 'vertical[|]split' }) -- <C-w>v
leadmap('_', ':split<CR>', { desc = 'horizontal[_]split' }) -- <C-w>s

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

-- INFO: quick commands / QOL
--
map('<C-c>', 'gcc', { desc = 'toggle comment', remap = true }) -- remap required, becuase ?
map('<C-c>', 'gc', { desc = 'v-mode comment', remap = true }, 'x') -- v

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
end)

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
