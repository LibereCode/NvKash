if vim.o.cmdheight ~= 0 then error('vim.o.cmdheight ~= 0. (actual value: ' .. vim.o.cmdheight .. ')') end
return {
  'rachartier/tiny-cmdline.nvim',
  opts = {},
}
