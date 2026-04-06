-- INFO: this file is clean, and
-- and can be exported to whatever config
--
-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

local map = vim.keymap.set
local nomap = vim.keymap.del -- disable (default) mappings
local function leadmap(keys, cmd, description, modes)
  modes = modes or 'n'
  cmd = cmd or '<CMD>lua print("forgor to write cmd...")'
  description = description or 'forgor to add💀'
  map(modes, '<leader>' .. keys, cmd, { desc = description })
end

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
map('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic Config & Keymaps
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
  jump = { float = true },
}

leadmap('cq', vim.diagnostic.setloclist, '[q]Quickfix')
map('n', ';', ':', { desc = 'cmd :' })

-- TERMINAL
--
leadmap('tv', function()
  vim.cmd.vnew()
  vim.cmd.terminal()
end, 'vterm')
leadmap('th', function()
  vim.cmd.new()
  vim.cmd.terminal()
end, 'term')
leadmap('tT', function() vim.cmd.terminal() end, 'Terminal buffer')
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

-- Windows/buffers/tabs
--
-- windows
-- Keybinds to make split navigation easier. Use CTRL+<hjkl> to switch between windows
--  See `:help wincmd` for a list of all window commands
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
map('n', '<C-A-h>', '<C-w>H', { desc = 'Move window to the left' })
map('n', '<C-A-l>', '<C-w>L', { desc = 'Move window to the right' })
map('n', '<C-A-j>', '<C-w>J', { desc = 'Move window to the lower' })
map('n', '<C-A-k>', '<C-w>K', { desc = 'Move window to the upper' })

map('n', '<C-A-->', '<C-w>2-', { desc = '[-] win-height' })
map('n', '<C-A-=>', '<C-w>2+', { desc = '[+] win-height' }) -- same key as +
map('n', '<C-A-,>', '<C-w>2<', { desc = 'widgth less [<]' }) -- lower-case <
map('n', '<C-A-.>', '<C-w>2>', { desc = 'width more [>]' }) -- lower-case >

leadmap('|', '<C-w>v', 'vertical[|]split')
leadmap('_', '<C-w>s', 'horizontal[_]split')

-- buffers -- INFO: see `plugins.ui`.bufferline&lualine for more
-- tabs
leadmap('<tab>l', '<cmd>tabs<CR>', 'tab list')
leadmap('<tab><tab>', '<cmd>tabnew<CR>', 'new')
leadmap('<tab>d', '<cmd>tabclose<CR>', 'delete')
leadmap('<tab>p', '<cmd>tabprev<CR>', 'prev')
leadmap('<tab>n', '<cmd>tabnext<CR>', 'next')

-- quick commands
map('n', '<C-c>', 'gcc', { desc = 'toggle comment', remap = true }) -- remap required, becuase ?
map('v', '<C-c>', 'gc', { desc = 'v-mode comment', remap = true })

map('s', '<C-v>', '<C-o>"cp', { desc = 'Paste in S/I-mode', remap = true })
map('s', '<C-c>', '<C-o>"cy', { desc = 'Copy in S-mode', remap = true })
map('s', '<C-x>', '<C-o>"cd', { desc = 'Cut in S-mode', remap = true })

-- better jk
map({ 'n', 'v' }, 'j', 'gj', { desc = 'better ↓j' })
map({ 'n', 'v' }, 'k', 'gk', { desc = 'better ↑k' })

-- jump to local link  -- XXX: really weird why `g]` wasen't enough, especially the last esc?
map('n', 'gl', 'g]1<CR><escape>', { desc = '[l]ocal link' }) -- NOTE: This disables the default

-- sessions[<leader>q]
leadmap('qw', '<CMD>wa<CR>', '[w]rite all')
leadmap('qs', '<CMD>w <BAR> so | echo "written & sauced"<CR>', 'save & sauce') -- figure out why I can't sauce this file
leadmap('qq', '<CMD>qa<CR>', '[q]uit all')
map('n', '<C-A-s>', '<cmd>w<CR><cmd>so<CR><cmd>echo("written & sauced")<CR>', { desc = 'Save&sauce' }) -- NOTE: 'macros' (multiple cmd chained) are possible like this
map('n', '<C-s>', '<cmd>w<CR>', { desc = 'save' })
map('n', '<C-q>', '<cmd>q<CR>', { desc = 'quit' })

-- TODO: trouble on [s]ymbols

-- TEST: Test
--
leadmap('it', ':echo "test?"') -- allows to write a cmd starting with 'echo("test?")' (so you can finish it)
leadmap('ib', '<cmd>echo "hello world 1"<Bar>echo "hello world 2"<CR>', '<bar> allows multiple commands')
-- <localleader>
map('n', '<localleader>,', '<cmd>echo "localleader"<Bar>echo "btw"<CR>', { desc = 'localleader mapping' })

-- INFO: see ~/.config/nvim/after/ftplugin/ for spicy stuff !!
--
-- INFO: see also `configs.lazy` 'custom_keys' (allows lazy keys, but global) https://lazy.folke.io/configuration
