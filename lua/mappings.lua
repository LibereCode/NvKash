-- require 'nvchad.mappings' -- ~/.local/share/nvim.dev/lazy/NvChad/lua/nvchad/mappings
-- disable this and instead do:
-- HACK: ---------------- Copy of nvchad.mappings -------------------------
-- commentented mappings are manually by me
local map = vim.keymap.set

-- map('i', '<C-b>', '<ESC>^i', { desc = 'move beginning of line' })
map('i', '<C-e>', '<End>', { desc = 'move end of line' })
map('i', '<C-h>', '<Left>', { desc = 'move left' })
map('i', '<C-l>', '<Right>', { desc = 'move right' })
map('i', '<C-j>', '<Down>', { desc = 'move down' })
map('i', '<C-k>', '<Up>', { desc = 'move up' })

map('n', '<C-h>', '<C-w>h', { desc = 'switch window left' })
map('n', '<C-l>', '<C-w>l', { desc = 'switch window right' })
map('n', '<C-j>', '<C-w>j', { desc = 'switch window down' })
map('n', '<C-k>', '<C-w>k', { desc = 'switch window up' })

-- map('n', '<Esc>', '<cmd>noh<CR>', { desc = 'general clear highlights' })
-- map('n', '<C-s>', '<cmd>w<CR>', { desc = 'general save file' })
-- map('n', '<C-c>', '<cmd>%y+<CR>', { desc = 'general copy whole file' })

-- map('n', '<leader>n', '<cmd>set nu!<CR>', { desc = 'toggle line number' })
-- map('n', '<leader>rn', '<cmd>set rnu!<CR>', { desc = 'toggle relative number' })
map('n', '<leader>ch', '<cmd>NvCheatsheet<CR>', { desc = 'toggle nvcheatsheet' })

-- map({ 'n', 'x' }, '<leader>fm', function() require('conform').format { lsp_fallback = true } end, { desc = 'general format file' })

-- global lsp mappings
map('n', '<leader>ds', vim.diagnostic.setloclist, { desc = 'LSP diagnostic loclist' })

-- -- tabufline
-- if require('nvconfig').ui.tabufline.enabled then
--   map('n', '<leader>b', '<cmd>enew<CR>', { desc = 'buffer new' })
--   map('n', '<tab>', function() require('nvchad.tabufline').next() end, { desc = 'buffer goto next' })
--   map('n', '<S-tab>', function() require('nvchad.tabufline').prev() end, { desc = 'buffer goto prev' })
--   map('n', '<leader>x', function() require('nvchad.tabufline').close_buffer() end, { desc = 'buffer close' })
-- end

-- -- Comment
-- map('n', '<leader>/', 'gcc', { desc = 'toggle comment', remap = true })
-- map('v', '<leader>/', 'gc', { desc = 'toggle comment', remap = true })

-- -- nvimtree
-- map('n', '<C-n>', '<cmd>NvimTreeToggle<CR>', { desc = 'nvimtree toggle window' })
-- map('n', '<leader>e', '<cmd>NvimTreeFocus<CR>', { desc = 'nvimtree focus window' })

-- -- telescope
-- map('n', '<leader>fw', '<cmd>Telescope live_grep<CR>', { desc = 'telescope live grep' })
-- map('n', '<leader>fb', '<cmd>Telescope buffers<CR>', { desc = 'telescope find buffers' })
-- map('n', '<leader>fh', '<cmd>Telescope help_tags<CR>', { desc = 'telescope help page' })
-- -- map('n', '<leader>ma', '<cmd>Telescope marks<CR>', { desc = 'telescope find marks' })
-- map('n', '<leader>fo', '<cmd>Telescope oldfiles<CR>', { desc = 'telescope find oldfiles' })
-- map('n', '<leader>fz', '<cmd>Telescope current_buffer_fuzzy_find<CR>', { desc = 'telescope find in current buffer' })
-- -- map('n', '<leader>cm', '<cmd>Telescope git_commits<CR>', { desc = 'telescope git commits' })
-- map('n', '<leader>gt', '<cmd>Telescope git_status<CR>', { desc = 'telescope git status' })
-- -- map('n', '<leader>pt', '<cmd>Telescope terms<CR>', { desc = 'telescope pick hidden term' })
-- -- map('n', '<leader>th', function() require('nvchad.themes').open() end, { desc = 'telescope nvchad themes' })
-- map('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { desc = 'telescope find files' })
-- map('n', '<leader>fa', '<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>', { desc = 'telescope find all files' })

-- terminal
map('t', '<C-x>', '<C-\\><C-N>', { desc = 'terminal escape terminal mode' })
-- -- new terminals
-- map('n', '<leader>h', function() require('nvchad.term').new { pos = 'sp' } end, { desc = 'terminal new horizontal term' })
-- map('n', '<leader>v', function() require('nvchad.term').new { pos = 'vsp' } end, { desc = 'terminal new vertical term' })
-- -- toggleable
-- map({ 'n', 't' }, '<A-v>', function() require('nvchad.term').toggle { pos = 'vsp', id = 'vtoggleTerm' } end, { desc = 'terminal toggleable vertical term' })
-- map({ 'n', 't' }, '<A-h>', function() require('nvchad.term').toggle { pos = 'sp', id = 'htoggleTerm' } end, { desc = 'terminal toggleable horizontal term' })
-- map({ 'n', 't' }, '<A-i>', function() require('nvchad.term').toggle { pos = 'float', id = 'floatTerm' } end, { desc = 'terminal toggle floating term' })

-- -- whichkey
-- map('n', '<leader>wK', '<cmd>WhichKey <CR>', { desc = 'whichkey all keymaps' })
-- map('n', '<leader>wk', function() vim.cmd('WhichKey ' .. vim.fn.input 'WhichKey: ') end, { desc = 'whichkey query lookup' })

-- HACK: ----------------- end of nvchad.mappings ---------------------
-- TODO Remove dublicates (from above) below

-- [[ Basic Keymaps ]]
--  See `:help map.set()`
-- See `:help hlsearch`

local nomap = vim.keymap.del -- disable (default) mappings

-- TODO: comment away above instead
-- nomap("n", "<C-c>")
-- nomap('n', '<leader>n')
-- nomap("n", "<leader>rn")
-- nomap("n", "<leader>fm")
-- nomap('n', '<leader>ds')
-- nomap("n", "<leader>b")
-- nomap("n", "<tab>")
-- nomap("n", "<S-tab>")
-- nomap({ "n", "v" }, "<leader>/")
-- nomap("n", "<leader>fw")
-- nomap("n", "<leader>ma")
-- nomap("n", "<leader>Gc")
-- nomap("n", "<leader>Gt")
-- nomap("n", "<leader>v")
-- nomap("n", "<leader>h")
-- nomap("n", "<A-i>h")
-- nomap("n", "s")
-- nomap('n', '<leader>gt')
-- nomap('n', '<leader>rn')
-- nomap('n', '<leader>s')
-- nomap('n', '<leader>h')
nomap('n', '<leader>b')
-- nomap('n', '<leader>th')
-- nomap('n', '<C-n>')
-- nomap('n', '<leader>x')
-- nomap('n', '<leader>ra') -- lsp
-- nomap('n', '<leader>D') -- lsp

local map = vim.keymap.set

map('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'general clear highlights' }) -- Clear highlights on search when pressing <Esc> in normal mode
-- map('n', '<Esc>', '<cmd>nohls<CR>', { desc = 'general clear highlights' })

-- See :help vim.diagnostic.Opts
vim.diagnostic.config { -- Diagnostic Config & Keymaps
  update_in_insert = false,
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = vim.diagnostic.severity.ERROR },
  -- Can switch between these as you prefer
  virtual_text = true, -- Text shows up at the end of the line
  virtual_lines = false, -- Teest shows up underneath the line, with virtual lines
  jump = { float = true }, -- Auto open the float, so you can easily read the errors when jumping with `[d` and `]d`
}

map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
-- map.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
map('t', '<C-ESC>', '<C-\\><C-N>', { desc = 'terminal [ESC]ape(🐵) terminal mode' })
-- terminal
map({ 'n', 't' }, '<A-v>', function() require('nvchad.term').toggle { pos = 'vsp', id = 'vtoggleTerm' } end, { desc = '[v]ertical' })
map({ 'n', 't' }, '<A-f>', function() require('nvchad.term').toggle { pos = 'float', id = 'floatTerm' } end, { desc = '[f]loating' })
map({ 'n', 't' }, '<A-c>', function() require('nvchad.term').toggle { pos = 'sp', id = 'htoggleTerm' } end, { desc = '[c]onsole' })
map({ 'n', 't' }, '<C-/>', function() require('nvchad.term').toggle { pos = 'sp', id = 'htoggleTerm' } end, { desc = 'ToggleTerm' })

map({ 'n', 't' }, '<leader>tt', function() require('nvchad.term').toggle { pos = 'sp', id = 'htoggleTerm' } end, { desc = 'Toggle[t]erm' })

-- -- TIP: Disable arrow keys in normal mode
-- map('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- map('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- map('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- map('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--  See `:help wincmd` for a list of all window commands
-- map('n', '<C-h>', '<C-w><C-h>', { desc = 'focus Window left' })
-- map('n', '<C-l>', '<C-w><C-l>', { desc = 'focus Window right' })
-- map('n', '<C-j>', '<C-w><C-j>', { desc = 'focus Window down' })
-- map('n', '<C-k>', '<C-w><C-k>', { desc = 'focus Window up' })
-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
map('n', '<C-A-h>', '<C-w>H', { desc = 'Move window to the left' })
map('n', '<C-A-l>', '<C-w>L', { desc = 'Move window to the right' })
map('n', '<C-A-j>', '<C-w>J', { desc = 'Move window to the lower' })
map('n', '<C-A-k>', '<C-w>K', { desc = 'Move window to the upper' })

-- tab-bar -- nvchad Tabufline
-- Switch Buffers
if require('nvconfig').ui.tabufline.enabled then
  map('n', '<S-h>', "<cmd>lua require('nvchad.tabufline').prev()<CR>", { desc = 'Switch to left buffer' })
  map('n', '<S-l>', "<cmd>lua require('nvchad.tabufline').next()<CR>", { desc = 'Switch to right buffer' })
end
-- Close Buffers
--  require("nvchad.tabufline").close_buffer()
--  -- closes all buffers
--  require("nvchad.tabufline").closeAllBufs(true)
--  require("nvchad.tabufline").closeAllBufs(false) -- excludes current buf
--
--  require("nvchad.tabufline").closeBufs_at_direction("left") -- or right
-- Move Buffers
--
-- This moves the buffer's position to left/right (-1 for left)
--  require("nvchad.tabufline").move_buf(1) or -1

map('i', '<C-a>', '<Home>', { desc = 'move beginning of line' })
-- map('i', '<C-e>', '<End>', { desc = 'move end of line' })
-- map('i', '<C-h>', '<Left>', { desc = 'move left' })
-- map('i', '<C-l>', '<Right>', { desc = 'move right' })
-- map('i', '<C-j>', '<Down>', { desc = 'move down' })
-- map('i', '<C-k>', '<Up>', { desc = 'move up' }) -- does not work

-- map('n', '<leader>ul', '<cmd>set nu!<CR>', { desc = '[l]ine number' }) -- Snacks took our jobs !
-- map('n', '<leader>ur', '<cmd>set rnu!<CR>', { desc = '[r]elative number' })

-- conform
map({ 'n', 'x' }, '<leader>cf', function() require('conform').format { lsp_fallback = true } end, { desc = '[f]ormat file' })

-- global lsp mappings
map('n', '<leader>cl', vim.diagnostic.setloclist, { desc = '[l]oclist diagnostic' })

-- Comment
map('n', '<C-c>', 'gcc', { desc = 'toggle [c]omment', remap = true })
map('v', '<C-c>', 'gc', { desc = 'toggle [c]omment', remap = true })

-- explorer -- see more in plugins.kickstart-neo-tree
-- map({ 'n', 'v' }, '<leader>e', '<cmd>Neotree left toggle<CR>', { desc = '[e]xplorer' })
-- map({ 'n', 'v' }, '<C-e>', '<cmd>lua Snacks.explorer.open()<CR>', { desc = 'toggle [e]xplorer' })

-- -- telescope
map('n', '<leader>fg', '<cmd>Telescope live_grep<CR>', { desc = 'telescope live [g]rep' })
map('n', '<leader>gc', '<cmd>Telescope git_commits<CR>', { desc = 'telescope [c]ommits' })
-- map('n', '<leader>gt', '<cmd>Telescope git_status<CR>', { desc = 'telescope s[t]atus' })
map('n', '<leader>ut', function() require('nvchad.themes').open() end, { desc = 'telescope [u]i nvchad [t]hemes' })
-- map('n', '<leader>fh', '<cmd>Telescope help_tags<CR>', { desc = 'telescope help page' })
map('n', '<leader>fo', '<cmd>Telescope oldfiles<CR>', { desc = 'telescope find oldfiles' })
map('n', '<leader>fz', '<cmd>Telescope current_buffer_fuzzy_find<CR>', { desc = 'telescope find in current buffer' })
-- map('n', '<leader>gt', '<cmd>Telescope git_status<CR>', { desc = 'telescope git status' })
map('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { desc = 'telescope find files' })
map('n', '<leader>fa', '<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>', { desc = 'telescope find all files' })

-- whichkey
map('n', '<leader>WK', '<cmd>WhichKey <CR>', { desc = 'Which[K]ey' })
map('n', '<leader>Wk', function() vim.cmd('WhichKey ' .. vim.fn.input 'WhichKey: ') end, { desc = 'Which[k]ey query' })

map('n', ';', ':', { desc = 'CMD enter command mode' })
-- map('i', 'jk', '<ESC>') -- skapar för mycket jobbig delay, och Caps=Esc är OP
map({ 'n', 'i', 'v' }, '<C-s>', '<cmd> w <cr>', { desc = '[s]ave file' })
map({ 'n', 'i', 'v' }, '<C-q>', '<cmd> q <cr>', { desc = '[q]uit file' })
-- map('n', '<C-c>', '<cmd>%y+<CR>', { desc = 'general copy whole file' })

-- map('n', 's', '', { desc = '+surround' }) -- having it as s was really buggy. doing gs instead

-- dial
vim.keymap.set('n', '<C-a>', function() require('dial.map').manipulate('increment', 'normal') end, { desc = 'dial [a]dd' })
vim.keymap.set('n', '<C-x>', function() require('dial.map').manipulate('decrement', 'normal') end, { desc = 'dial [a]dd' })
vim.keymap.set('n', 'g<C-a>', function() require('dial.map').manipulate('increment', 'gnormal') end, { desc = 'dial [a]dd' })
vim.keymap.set('n', 'g<C-x>', function() require('dial.map').manipulate('decrement', 'gnormal') end, { desc = 'dial [a]dd' })

-- C-d Gives a list of possible commands (in :cmd mode)
map('c', '<C-tab>', 'C-d', { desc = 'Show completions' })

-- buffer
map('n', '<leader>bn', '<cmd>enew<CR>', { desc = 'buffer [n]ew' })
map('n', '<leader>bd', '<cmd>bd<CR>', { desc = 'buffer [d]elete' })

-- window

-- tab
map('n', '<leader><tab>h', '<cmd>tabprevious<CR>', { desc = '󰌥 Prev' })
map('n', '<leader><tab>l', '<cmd>tabnext<CR>', { desc = 'Next 󰌒' })
map('n', '<leader><tab><tab>', '<cmd>tabnew<CR>', { desc = 'New [󰌒 ]' })
map('n', '<leader><tab>d', '<cmd>tabclose<CR>', { desc = 'Delete󰌒 ' })
