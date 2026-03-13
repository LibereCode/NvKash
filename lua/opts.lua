-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

local o = vim.o
local opt = vim.opt

o.number = true -- Make line numbers default
o.relativenumber = true -- You can also add relative line numbers, to help with jumping. Experiment for yourself to see if you like it!

o.mouse = 'nv' -- 'nv' = normal+visual, 'a' = all -- Enable mouse mode, can be useful for resizing splits for example!

o.showmode = false -- Don't show the mode, since it's already in the status line

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function() o.clipboard = 'unnamedplus' end)

o.breakindent = true -- Enable break indent

o.undofile = true -- Enable undo/redo changes even after closing and reopening a file

o.ignorecase = true -- Case-insensitive searching
o.smartcase = true --  UNLESS \C or one or more capital letters in the search term

o.signcolumn = 'yes' -- Keep signcolumn on by default

o.updatetime = 250 -- Decrease update time

o.timeoutlen = 300 -- Decrease mapped sequence wait time

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
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

o.inccommand = 'split' -- Preview substitutions live, as you type!

o.cursorline = true -- Show which line your cursor is on

o.scrolloff = 15 -- Minimal number of screen lines to keep above and below the cursor.

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
o.confirm = true

opt.foldenable = false
