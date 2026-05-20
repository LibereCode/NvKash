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

-- Set to true if you have a Nerd Font installed and selected in the terminal
g.have_nerd_font = true

o.number = true -- Make line numbers default
o.relativenumber = true -- You can also add relative line numbers, to help with jumping. Experiment for yourself to see if you like it!
o.numberwidth = 2

o.mouse = 'nvc' -- 'nv' = normal+visual, 'a' = all -- Enable mouse mode, can be useful for resizing splits for example!
o.selectmode = 'mouse' -- :h 'slm'

o.showmode = false -- Don't show the mode, since it's already in the status line

-- Sync clipboard between OS and Neovim.v
-- Schedule the setting after `UiEnter` because it can increase startup-time.
-- Remove this option if you want your OS clipboard to remain independent.
-- See `:help 'clipboard'`
-- vim.schedule(function() o.clipboard = 'unnamedplus' end) -- disable this and use `"+y` to manually copy to clipboard
o.clipboard = vim.env.SSH_CONNECTION and '' or 'unnamedplus' -- together with the new V/S-mode mappings --  PERF: Hated it

o.breakindent = true -- Enable break indent
-- o.smartindent = true -- maybe not so smart...
o.tabstop = 4 -- . :h 'ts'
o.shiftwidth = 0 -- 4 -- 0 => sw=ts --  . :h 'sw'
o.softtabstop = -1 -- 4 -- sts>0 => sts=sw(=ts) -- . :h 'sts'
-- o.expandtab = true

-- o.shm:append({ W = true, I = true, c = true, C = true }) -- append to shortmess, which is truncation of terms
-- o.hortmess:append 'sI' -- disable nvim intro(default dashboard)
o.shortmess:append 'as' -- a=lmrw (:h shortmess) -- alpha.nvim appends I (replaces :intro)
o.ruler = false
o.cmdheight = 0 -- 0 2

o.sidescrolloff = 40 -- :h 'siso' -- 8 723 -- very big(723)=always centered(unless at left)
o.sidescroll = 0 -- :h 'ss' -- 0 -- scroll this many lines when `:h siso` is triggered -- 0 = center instead
o.scrolloff = 15 -- :h 'so' -- 4 15 20 -- Lines of context (scrolloff) -- large (723) = always centered
o.scrolljump = 1 -- :h 'sj' -- -69 -- like sidescroll, but for vertical -- -n = n%heifht

-- NOTE: See 'ui2' [bottom/below]

o.ignorecase = true -- Case-insensitive searching
o.smartcase = true --  UNLESS \C or one or more capital letters in the search term

o.signcolumn = 'yes' -- :h 'scl'

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
o.listchars = { -- :h lcs
  -- eol = '󰌑', --   ␤ 󰌑 
  tab = '⇥ ', -- ↣ ↪ ⇢ ⇛ ⇒ ⇨ ⇥ 󰌒 »
  multispace = string.rep(' ', (vim.o.ts - 1)) .. '␣', -- mark "shiftwidth" tabs
  trail = '·', -- ␣ 󱁐 · ␠
  lead = ' ',
  nbsp = '⍽',
  extends = '󰶻', --  →⃨
  precedes = '󰶺', --  ←
}

o.inccommand = 'split' -- :h 'icm' -- Preview substitutions live, as you type!

o.cursorline = true -- Highlight current line
-- o.cursorlineopt = 'both' -- default

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
o.confirm = true

-- o.foldenable = false -- toggle off folds by default -- foldlevel is better
o.fillchars = { -- :h fcs
  foldopen = '',
  foldclose = '', -- "",
  fold = '·', -- · ' '
  foldsep = '', -- " ",
  diff = '╱',
  eob = ' ',
}
o.foldlevel = 99 -- Threshold before fold
o.foldmethod = 'indent'
o.foldtext = ''

o.laststatus = 2 -- :h 'ls' -- foldlevel is better
o.splitkeep = 'screen'

-- go to previous/next line with h,l,left arrow and right arrow when cursor reaches end/beginning of line
o.ww:append '<>[]hl' -- OP !! -- wrapoff, see below -- '<>'=left/right in N+V and '[]' in I+R mode; 'hl'=h/l in N+V
o.wrap = false -- toggles off wrap by default

o.virtualedit = 'block' -- :h 've' -- allows selecting on empty space in visual-block mode

o.wildmode = 'longest:full,list' -- :h 'wim' -- Command-line completion mode -- see also: `:h wildchar` `:h wildmenu`
o.wildoptions = 'fuzzy,pum,tagfile' -- :h 'wop'

-- disable some default providers -- Not neaded if I have lsp?
-- g.loaded_node_provider = 0
g.loaded_python3_provider = 0
-- g.loaded_perl_provider = 0
-- g.loaded_ruby_provider = 0
g.markdown_recommended_style = 0 -- Fix markdown indentation settings

-- {swap, bakkupp, undo} default dir: $XDG_STATE_HOME/{swap|undo|backup}
o.swapfile = true -- `:h 'dir'`
-- o.directory = "." -- store in same dir
-- o.directory = vim.fn.stdpath 'data' .. '/swap//' -- store in $XDG_DATA_HOME
-- o.backup = true -- `:h 'bdir'`
-- -- o.backupdir = "." -- stored in same file
-- o.backupdir = vim.fn.stdpath 'data' .. '/bakkupp//' -- local/share/ for bakkupp files
o.undofile = true -- :h udf
-- o.undodir = vim.fn.stdpath('state') .. '/exampleUndoDir//'
o.undolevels = 1723 -- :h ul

o.termguicolors = true -- Enable true colors for proper colorscheme support
cset 't_Co=256'
cset 'termguicolors'
cset 'background=dark'

o.textwidth = 100 -- 80
-- o.colorcolumn = tostring(vim.opt.textwidth:get()) -- see also autocmd
o.colorcolumn = '-10,80' -- bruh

-- o.winborder = 'bold' -- "bold" -- `:h 'winborder'`
o.winborder = '.,-,.,¦,˙,-,˙,¦' -- TEST: (customAlt)=>'+,-,+,|,+,-,+,|'

-- NOTE: Experimental ui (see: `:h ui2`)
require('vim._core.ui2').enable {
  enable = true, -- Whether to enable or disable the UI.
  msg = { -- Options related to the message module.
    ---@type string|table<string, 'cmd'|'msg'|'pager'> Default message target
    ---or table mapping |ui-messages| kinds, triggers and IDs to a target.
    ---Table keys are are matched as a Lua pattern to the message ID. 'default'
    ---mapping applies to any omitted kind: { default = 'cmd', progress = 'msg' }.
    targets = 'cmd',
    cmd = { -- Options related to messages in the cmdline window.
      -- Maximum height (rows if >=1, or % of 'lines' if <1) of messages expanded
      -- beyond 'cmdheight'; 0.999 for full height.
      height = 0.5,
    },
    dialog = { -- Options related to dialog window.
      height = 0.5, -- Maximum height.
    },
    msg = { -- Options related to msg window.
      height = 0.5, -- Maximum height.
      timeout = 4000, -- Time a message is visible in the message window.
    },
    pager = { -- Options related to message window.
      height = 0.999, -- Maximum height.
    },
  },
}
