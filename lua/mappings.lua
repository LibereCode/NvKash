-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

local map = vim.keymap.set
local nomap = vim.keymap.del -- disable (default) mappings

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

map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- HACK: TERMINAL
--
map('n', '<leader>tv', function()
   vim.cmd.vnew()
   vim.cmd.terminal()
end, { desc = 'vterm' })
map('n', '<leader>th', function()
   vim.cmd.new()
   vim.cmd.terminal()
end, { desc = 'term' })
map('n', '<leader>tT', function() vim.cmd.terminal() end, { desc = 'Terminal buffer' })
--
--  floating terminal
map('n', '<leader>tt', function() require('custom.toggle_term').float() end, { desc = 'Floating terminal' })
-- map('n', '<leader>tv', function() require('custom.toggle_term').verti() end, { desc = 'Vertical terminal' })
-- map('n', '<leader>th', function() require('custom.toggle_term').horiz() end, { desc = 'Horizontal terminal' })
map({ 'n', 't' }, '<M-t>', function() require('custom.toggle_term').float() end, { desc = 'Toggle Term' })
-- map({ 'n', 't' }, '<C-/>', function() require('custom.toggle_term').horiz() end, { desc = 'Toggle HTerm' })
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

-- HACK: Windows/buffers/tabs
--
-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
-- windows
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
map('n', '<C-A-h>', '<C-w>H', { desc = 'Move window to the left' })
map('n', '<C-A-l>', '<C-w>L', { desc = 'Move window to the right' })
map('n', '<C-A-j>', '<C-w>J', { desc = 'Move window to the lower' })
map('n', '<C-A-k>', '<C-w>K', { desc = 'Move window to the upper' })
-- buffers -- INFO: see `plugins.barbar` for more
map('n', '<leader>bb', '<cmd>buffers<CR>')
map('n', '<leader>bn', '<cmd>enew<CR>')
map('n', '<S-h>', '<cmd>bp<CR>', { desc = 'prev buffer' })
map('n', '<S-l>', '<cmd>bn<CR>', { desc = 'next buffer' })
-- tabs
map('n', '<leader><tab>l', '<cmd>tabs<CR>', { desc = 'tab list' })
map('n', '<leader><tab><tab>', '<cmd>tabnew<CR>', { desc = 'new' })
map('n', '<leader><tab>d', '<cmd>tabclose<CR>', { desc = 'delete' })
map('n', '<leader><tab>p', '<cmd>tabprev<CR>', { desc = 'prev' })
map('n', '<leader><tab>n', '<cmd>tabnext<CR>', { desc = 'next' })

-- HACK: QOL
--
map('n', '<C-s>', '<cmd>w<CR>', { desc = 'save' })
map('n', '<C-A-s>', '<cmd>w<CR><cmd>so<CR><cmd>echo("write + sauced")<CR>', { desc = 'Save' }) -- NOTE: 'macros' (multiple cmd chained) are possible like this
map('n', '<C-q>', '<cmd>q<CR>', { desc = 'quit' })
map('n', ';', ':')
-- remap required, becuase ?
map('n', '<C-c>', 'gcc', { desc = 'toggle comment', remap = true })
map('v', '<C-c>', 'gc', { desc = 'v-mode comment', remap = true })
-- better jk
map({ 'n', 'v' }, 'j', 'gj', { desc = 'better ↓j' })
map({ 'n', 'v' }, 'k', 'gk', { desc = 'better ↑k' })
-- jump to local link  -- XXX: really weird why `g]` wasen't enough, especially the last esc?
map('n', 'gl', 'g]1<CR><escape>', { desc = '[l]ocal link' }) -- NOTE: This disables the default
-- Whichkey
map('n', '<leader>W', '<CMD>WhichKey<CR>', { desc = 'WhichKey[W]all' })

-- HACK: UI

-- TODO: create snacks like toggles
-- - [ ] wrap
-- - [ ] line nr
-- - [ ] relative line
-- - [ ] diagnostics
-- - [ ] colorize

-- HACK: Code

-- HACK: Lazy
map('n', '<leader>ll', '<cmd>Lazy<CR>', { desc = 'Lazy󰒲 ' })

-- HACK: Custom plugins
--
-- LazyGit
map({ 'n', 't' }, '<leader>lg', function() require('custom.lazygit').toggle() end, { desc = 'LazyGit' })
map({ 'n', 't' }, '<leader>gg', function() require('custom.lazygit').toggle() end, { desc = 'LazyGit' })
-- Journal
map({ 'n', 't' }, '<leader>mj', require 'custom.journal', { desc = 'Journal' })

-- NOTE:: Have plugin bindings inside the plugins
-- either put it in keys = {}, opts = {}, or config (example:)
-- config = function(_, opts)
--   vim.keymap.set('n', '<leader>abc', function() require('plugin_name.foo').bar('do_some', 'normal') end, { desc = 'abc foobar' })
-- end,

-- TEST: Test
--
map('n', '<leader>it', ':echo "test?"') -- allows to write a cmd starting with 'echo("test?")' (so you can finish it)

-- TODO:
-- - buffer binds
--
