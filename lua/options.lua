-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- local o = vim.o
-- local opt = vim.opt
-- NOTE: vim.o is just a limited version of vim.opt (?),
-- so I made all into vim.opt. See `:h vim.opt`.
-- The only problem is that, only typing `vim.o.` (not o if alias) give completions
local o = vim.opt -- this works perfect, and vim.o breaks config
local g = vim.g
local cset = vim.cmd.set

o.number = true -- Make line numbers default
o.relativenumber = true -- You can also add relative line numbers, to help with jumping. Experiment for yourself to see if you like it!
o.numberwidth = 3

o.mouse = 'nvc' -- 'nv' = normal+visual, 'a' = all -- Enable mouse mode, can be useful for resizing splits for example!
o.slm = 'mouse' -- select mode instead of visual with mouse

o.showmode = false -- Don't show the mode, since it's already in the status line

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
-- vim.schedule(function() o.clipboard = 'unnamedplus' end) -- TEST: disable this and use `"+y` to manually copy to clipboard
-- o.clipboard = vim.env.SSH_CONNECTION and '' or 'unnamedplus' -- together with the new V/S-mode mappings

o.breakindent = true -- Enable break indent

o.shiftwidth = 4 --  . :h 'sw'
o.tabstop = 4 -- . :h 'ts'
o.softtabstop = 4 -- . :h 'sts'
-- o.smartindent = true -- maybe not so smart...
o.expandtab = true

-- o.shm:append({ W = true, I = true, c = true, C = true }) -- append to shortmess, which is truncation of terms
-- o.shortmess:append 'sI' -- disable nvim intro(default dashboard)
o.shortmess:append 'sa' -- a=lmrw (:h shortmess) -- alpha.nvim appends I (replaces :intro)
o.so = 10 -- 4 -- Lines of context (scrolloff)
o.siso = 21 -- 8 723 -- Columns of context (sidescrolloff) -- very big(723)=always centered(unless at left)

o.udf = true -- Enable undo/redo changes even after closing and reopening a file
o.ul = 1723 -- higher level=more memory (1000 default)

o.ignorecase = true -- Case-insensitive searching
o.smartcase = true --  UNLESS \C or one or more capital letters in the search term

o.signcolumn = 'yes' -- Keep signcolumn on by default

o.updatetime = 250 -- Decrease update time

o.timeoutlen = 222 -- = 300 -- Decrease mapped sequence wait time

o.splitright = true -- Configure how new splits should be opened
o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--
--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-guide-options`
o.list = true
o.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

o.inccommand = 'split' -- Preview substitutions live, as you type!

o.cursorline = true -- Show which line your cursor is on

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
o.confirm = true

-- HACK: Add more down below

-- o.foldenable = false -- toggle off folds by default -- foldlevel is better
o.fcs = {
  foldopen = '',
  foldclose = '', -- "",
  fold = '·', -- " ", ' ',
  foldsep = '', -- " ",
  diff = '╱',
  eob = ' ',
}
o.foldlevel = 99 -- Threshold before fold
o.foldmethod = 'indent'
o.foldtext = ''

o.ls = 2 -- laststatus -- foldlevel is better -- foldlevel is better
o.splitkeep = 'screen'

o.cursorlineopt = 'both' -- default?

-- go to previous/next line with h,l,left arrow and right arrow when cursor reaches end/beginning of line
o.ww:append '<>[]hl' -- OP !! -- wrapoff, see below -- '<>'=left/right in N+V and '[]' in I+R mode; 'hl'=h/l in N+V
o.wrap = false -- toggles off wrap by default

o.ve = 'block' -- allows selecting on empty space in visual-block mode

o.wim = 'longest:full,list' -- Command-line completion mode -- see also: `:h wildchar` `:h wildmenu`
o.wop = 'fuzzy,pum,tagfile' -- `:h wildoptions`

-- -- disable some default providers
-- g.loaded_node_provider = 0
-- g.loaded_python3_provider = 0
-- g.loaded_perl_provider = 0
-- g.loaded_ruby_provider = 0
g.markdown_recommended_style = 0 -- Fix markdown indentation settings

o.swapfile = true -- swapfile -- default stored in local/state/nvim/swap -- enabled by default?
-- o.directory = "." -- store in same dir
-- o.directory = vim.fn.stdpath 'data' .. '/swap//' -- store in local/share
-- o.backup = true -- bakkupp -- default stored nowhere ?? nowhere ? -- HACK: no reason for auto-backup. Swap and undo exist
-- -- o.backupdir = "." -- stored in same file
-- o.backupdir = vim.fn.stdpath 'data' .. '/bakkupp//' -- local/share/ for bakkupp files

o.termguicolors = true -- Enable true colors for proper colorscheme support
cset 't_Co=256'
cset 'termguicolors'
cset 'background=dark'
