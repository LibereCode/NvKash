require 'nvchad.options' -- ~/.local/share/nvim.dev/lazy/NvChad/lua/nvchad/options
-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

local o = vim.o
local opt = vim.opt
local g = vim.g

-- .o

o.number = true -- Make line numbers default
o.numberwidth = 2
o.relativenumber = true -- You can also add relative line numbers, to help with jumping.
o.mouse = 'nv' -- nv=normal+visual a=all -- enable mouse
o.showmode = false -- Don't show the mode, since it's already in the status line
vim.schedule(function() o.clipboard = 'unnamedplus' end) -- Sync clipboard between OS and Neovim. --  See `:help 'clipboard'`
o.breakindent = true -- Enable break indent
o.undofile = true -- Save undo history
o.ignorecase = true -- Case-insensitive searching UNLESS
o.smartcase = true -- \C or one or more capital letters in the search term
o.signcolumn = 'yes' -- Keep signcolumn on by default
o.updatetime = 250 -- Decrease update time
o.timeoutlen = 300 -- Decrease mapped sequence wait time
o.splitright = true -- Configure how new splits should be opened
o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-guide-options`
o.list = true
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
o.inccommand = 'split' -- Preview substitutions live, as you type!
o.cursorline = true -- Show which line your cursor is on
o.scrolloff = 15 -- Minimal number of screen lines to keep above/below the cursor.
-- See `:help 'confirm'`
o.confirm = true -- raise a dialog asking if you wish to save the current file(s)

-- INFO: ------ from NvChad -------
-- no idea what they be doing
--
o.ls = 2 -- laststatus
o.splitkeep = 'screen'
--
-- o.clipboard = "unnamedplus"
o.cursorline = true
o.cursorlineopt = 'both' -- number+screenline
--
-- -- Indenting
o.expandtab = true -- makes tabes into spaces
o.tabstop = 2 -- tab-character width
o.softtabstop = 2 -- tab key spaces
o.shiftwidth = 2 -- ???
o.smartindent = true -- c like programs... ?
--
opt.fillchars = { eob = '~' } -- default = '~'
-- -- Numbers
o.ruler = true
--
-- -- disable nvim intro
opt.shortmess:append 'sI'
--
-- -- go to previous/next line with h,l,left arrow and right arrow
-- -- when cursor reaches end/beginning of line
opt.whichwrap:append '<>[]hl' -- OP !! -- wrapoff, see below
--
-- -- disable some default providers
g.loaded_node_provider = 0
g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
--
-- -- add binaries installed by mason.nvim to path
local is_windows = vim.fn.has 'win32' ~= 0
local sep = is_windows and '\\' or '/'
local delim = is_windows and ';' or ':'
vim.env.PATH = table.concat({ vim.fn.stdpath 'data', 'mason', 'bin' }, sep) .. delim .. vim.env.PATH

opt.wrap = false

opt.swapfile = true -- swapfile -- default stored in local/state/nvim/swap
-- opt.directory = "." -- store in same dir
-- opt.directory = vim.fn.stdpath 'data' .. '/swap//' -- store in local/share
opt.backup = true -- bakkupp -- default stored nowhere ?? nowhere ?
-- opt.backupdir = "." -- stored in same file
opt.backupdir = vim.fn.stdpath 'data' .. '/bakkupp//' -- local/share/ for bakkupp files

opt.termguicolors = true -- Enable true colors for proper colorscheme support
vim.cmd 'set t_Co=256'
vim.cmd.set 'termguicolors'
vim.cmd.set 'background=dark'
