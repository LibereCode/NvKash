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
map('n', '<leader>tt', function()
  vim.cmd.new()
  vim.cmd.terminal()
end, { desc = 'term' })
-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

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
-- buffers
map('n', '<leader>bl', '<cmd>buffers<CR>', { desc = 'buffer list' })
map('n', '<leader>bb', '<cmd>enew<CR>', { desc = 'bygga' })
map('n', '<leader>bd', '<cmd>bdel<CR>', { desc = 'delete' })
map('n', '<leader>bp', '<cmd>bprev<CR>', { desc = 'prev' })
map('n', '<leader>bn', '<cmd>bnext<CR>', { desc = 'next' })
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

-- HACK: NAVIGATION
--
-- map('n', '<leader>e', '<cmd>Lex<CR>', { desc = 'Toggle Left Explorer' })
-- map('n', '<leader>e', function() -- ABSOLUTE BANGER !
--   if not pcall(vim.cmd, 'Rex') then vim.cmd.Explore() end
-- end, { desc = 'Toggle Explorer' }) -- dock lite buggy...

-- HACK: Lazy
--
map('n', '<leader>l', '<cmd>Lazy<CR>', { desc = 'Lazy󰒲 ' })

-- HACK: Text
--
-- Markdown
map('n', '<leader>ms', '<CMD>Markview splitToggle<CR>', { desc = 'toggle split' })
map('n', '<leader>mt', '<CMD>Markview Toggle<CR>', { desc = 'toggle markview' })

-- TEST: Test
--
map('n', '<leader>it', ':echo("test?")') -- allows to write a cmd starting with 'echo("test?")' (so you can finish it)

-- TODO:
-- - buffer binds
