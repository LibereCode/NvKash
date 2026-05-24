-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: INFO: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
--
-- Add any additional options here

local g = vim.g

g.maplocalleader = ","

-- vim.g.snacks_animate = false -- Set to `false` to globally disable all snacks animations

g.lazyvim_picker = "telescope" -- -- Can be one of: auto, snacks, telescope, fzf

-- if the completion engine supports the AI source,
-- use that instead of inline suggestions
g.ai_cmp = true

-- vim.g.deprecation_warnings = true -- Hide deprecation warnings

local opt = vim.opt

-- opt.expandtab = false -- True = Use spaces instead of tabs
opt.fcs = {
  foldopen = "",
  foldclose = "", -- "",
  fold = "·", -- " ", ' ',
  foldsep = "", -- " ",
  diff = "╱",
  eob = " ",
}

opt.mouse = "nv" -- Enable mouse mode -- a=all ; nv=normal+visual
opt.slm = "mouse" -- select mode instead of visual with mouse

opt.sw = 2 -- 2 -- Size of an indent
opt.ts = 2 -- Number of spaces tabs count for
-- opt.shm:append({ W = true, I = true, c = true, C = true }) -- append to shortmess, which is truncation of terms
opt.so = 10 -- 4 -- Lines of context
opt.siso = 21 -- 8 723 -- Columns of context -- very big(723)=always centered(unless at left)

opt.ww:append("<>[]hl") -- wraps around at ends (<BS> and <space> is default)

-- opt.stc = [[%!v:lua.LazyVim.statuscolumn()]]

opt.tm = 123 --  vim.g.vscode and 1000 or 300 -- Lower than default (1000) to quickly trigger which-key
