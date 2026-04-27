-- NOTE: this file is clean, and
-- and can be exported to whatever config
-- Will use `INFO` as marking headers
--
-- INFO: [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

local map = vim.keymap.set
local nomap = vim.keymap.del -- disable (default) mappings

--- @param keys string -- the keys after _<leader>_
--- @param cmd string|function -- `<CMD>foobar<CR>` or lua `function()`
--- @param opts table<any, any>|nil -- **optional** table of _key=val_ opts
--- @param modes table|string|nil -- **optional** table or string of modes if not _"n"_
--- @return nil -- *return fuck all*
local function leadmap(keys, cmd, opts, modes) -- better leadmap (allows { opts })
  modes = modes or 'n'
  opts = opts or {}
  map(modes, '<leader>' .. keys, cmd, opts)
end

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
map('n', '<Esc>', '<cmd>nohlsearch<CR>')
map('n', ';', ':', { desc = 'cmd :' })

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
  -- stylua: ignore
  jump = { on_jump = on_jump }, -- `:h diagnostic-on-jump-example` -- DEPRECATED: jump = { float = true },
}

leadmap('do', vim.diagnostic.setloclist, { desc = 'l[o]clist' })
leadmap('df', vim.diagnostic.open_float, { desc = 'open [f]loating' })
leadmap('dl', ':log<CR>')

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
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
map('t', '<C-Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- map('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- map('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- map('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- map('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- INFO: Windows/buffers/tabs
--
-- windows
-- Keybinds to make split navigation easier. Use CTRL+<hjkl> to switch between windows
--  See `:help wincmd` for a list of all window commands
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
-- NOTE Some terminals have colliding keymaps or are not able to send distinct keycodes
map('n', '<C-A-h>', '<C-w>H', { desc = 'Move window to the left' })
map('n', '<C-A-l>', '<C-w>L', { desc = 'Move window to the right' })
map('n', '<C-A-j>', '<C-w>J', { desc = 'Move window to the lower' })
map('n', '<C-A-k>', '<C-w>K', { desc = 'Move window to the upper' })

map('n', '<C-A-->', '<C-w>2-', { desc = '[-] win-height' })
map('n', '<C-A-=>', '<C-w>2+', { desc = '[+] win-height' }) -- same key as +
map('n', '<C-A-,>', '<C-w>2<', { desc = 'widgth less [<]' }) -- lower-case <
map('n', '<C-A-.>', '<C-w>2>', { desc = 'width more [>]' }) -- lower-case >

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
leadmap('bd', '<cmd>bd<CR>', bufopts { desc = '[D]ELETE' })
leadmap('x', '<cmd>bn<BAR>bd #<CR>', bufopts { desc = 'delete[x]buffer' })
map('n', 'H', '<cmd>bp<CR>', bufopts { desc = 'prev buf' })
map('n', 'L', '<cmd>bn<CR>', bufopts { desc = 'next buf' })

-- tabs
leadmap('<tab>l', '<cmd>tabs<CR>', { desc = 'tab list' })
leadmap('<tab><tab>', '<cmd>tabnew<CR>', { desc = 'new' })
leadmap('<tab>d', '<cmd>tabclose<CR>', { desc = 'delete' })
leadmap('<tab>p', '<cmd>tabprev<CR>', { desc = 'prev' })
leadmap('<tab>n', '<cmd>tabnext<CR>', { desc = 'next' })

-- INFO: quick commands / QOL
--
map('n', '<C-c>', 'gcc', { desc = 'toggle comment', remap = true }) -- remap required, becuase ?
map('v', '<C-c>', 'gc', { desc = 'v-mode comment', remap = true })

-- Selection-mode
map({
  's' --[[,'i' -- Made I-mode version better for insert ]],
}, '<C-v>', '<C-o>P', { desc = 'Paste in S-mode', remap = true }) -- '<C-o>"sp'
map('s', '<C-c>', '<C-o>y', { desc = 'Copy in S-mode', remap = true }) -- '<C-o>"sy'
map('s', '<C-x>', '<C-o>d', { desc = 'Cut in S-mode', remap = true }) -- '<C-o>"sd'
-- NGL, pretty peak (even if it is mouse-based)

-- Visual-mode -- these copies to 'Y'-registry (so seperate from Sys-Clipboard)
leadmap('y', '"yy', { desc = '[y]ank 2 Sys' }, 'v')
leadmap('p', '"yp', { desc = '[p]aste from Sys' }, 'v')
map('v', '<C-y>', '"yy', { desc = '[y]ank 2 Sys' }) -- Really usefull, so I made it appear  multiple ...
map('v', '<C-p>', '"yp', { desc = '[p]aste from Sys' }) -- ... places (either <leader>y/p or <C-y/p>)

-- Insert-mode
map('i', '<C-v>', '<ESC>pa', { desc = 'Paste in I-mode', remap = true }) -- NOTE: Use  (^Q = <C-q>) Instead of (<C-v>) to do the thing

-- better jk
map({ 'n', 'v' }, 'j', 'gj', { desc = 'better ↓j', silent = true })
map({ 'n', 'v' }, 'k', 'gk', { desc = 'better ↑k', silent = true })

-- jump to local link  -- really weird why `g]` wasen't enough, especially the last esc?
map('n', 'gl', 'g]1<CR><escape>', { desc = '[l]ocal link' }) -- NOTE: This disables the default

-- INFO: sessions[<leader>q]
--
leadmap('qw', '<CMD>wa<CR>', { desc = '[w]rite all' })
leadmap('qs', '<CMD>w <BAR> so | echo "written & sauced"<CR>', { desc = 'save & sauce' }) -- figure out why I can't sauce this file
leadmap('qq', '<CMD>qa<CR>', { desc = '[q]uit all' })
leadmap('qr', '<CMD>restart<CR>', { desc = '[r]estart nvim' })
map('n', '<C-A-s>', '<cmd>write<CR><cmd>source<CR><cmd>echo("written & sauced")<CR>', { desc = 'Save&sauce' }) -- NOTE: 'macros' (multiple cmd chained) are possible like this
map('n', '<C-s>', '<cmd>write<CR>', { desc = 'save' })
map('n', '<C-q>', '<cmd>quit<CR>', { desc = 'quit' })

-- INFO: UI toggles (builtin)
--
leadmap('uw', '<CMD>set wrap!<CR>', { desc = 'toggles [w]rap' })
leadmap('ul', '<CMD>set nu!<CR>', { desc = 'toggle [l]ine-nr' })
leadmap('ur', '<CMD>set rnu!<CR>', { desc = 'toggle [r]elative-line-nr' })
leadmap('uc', '<CMD>set cul!<CR>', { desc = 'toggle cursor-[L]ine' })
leadmap('uc', '<CMD>set cul!<CR>', { desc = 'toggle cursor-[L]ine' })
leadmap('ut', function()
  -- if vim.o.tabstop == 8 then -- toggle 4/8
  --   vim.opt.tabstop = 4
  -- else
  --   vim.opt.tabstop = 8
  -- end
  -- print(vim.o.tabstop)

  vim.ui.input({ prompt = 'Enter value for Tab-stuff: ' }, function(input) -- type option
    local tabStuff = tonumber(input) -- from `:h vim.ui.input()`
    vim.opt.tabstop = tabStuff
    vim.opt.softtabstop = tabStuff
    -- vim.opt.shiftwidth = tabStuff
  end)
end, { desc = 'set [t]abStuff' })

-- INFO: open/organize
--
leadmap('oo', function()
  local curfile = vim.fn.expand '%:p'
  vim.fn.jobstart({ 'handlr', 'open', curfile }, { detach = true })
end, { silent = true, desc = 'Handlr open' })
leadmap('oI', ':intro<CR>')

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

leadmap('id', function() -- Odly (cursed) good
  local insert = vim.api.nvim_input
  insert 'dd<ESC>O<ESC>gccO<ESC>o<lt><lt><CR>>><ESC>O=<ESC>9a=<ESC>Pgcip}kP{dd}dd' -- almost easy to read...
end, { desc = 'comment<<>>[d]iff' }, { 'v', 'n' }) -- NOTE: FUCKING PEAK !!

-- TEST:
--
leadmap('it', ':echo "test?"') -- allows to write a cmd starting with 'echo("test?")' (so you can finish it)
leadmap('ib', '<cmd>echo "hello world 1"<Bar>echo "hello world 2"<CR>', { desc = '<bar> allows multiple commands' })

-- <localleader>
map('n', '<localleader>,', '<cmd>echo "localleader"<Bar>echo "btw"<CR>', { desc = 'localleader mapping' })

-- NOTE: see ~/.config/nvim/after/ftplugin/ for spicy stuff !!
--
-- NOTE: see also `configs.lazy` 'custom_keys' (allows lazy keys, but global) https://lazy.folke.io/configuration
