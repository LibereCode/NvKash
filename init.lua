-- INFO: Set options, mappings, and other simple config here
local vim = vim

vim.cmd("so " .. vim.fn.stdpath("config") .. "/vimit.vim") -- this works, ... after fix...

vim.o.winborder = "+,-,+,|,+,-,+,|"

vim.keymap.set("n", "<leader>test", function ()
	vim.cmd([[let buf = nvim_create_buf(v:false, v:true)]])
	vim.cmd([[call nvim_buf_set_lines(buf, 0, -1, v:true, ["test", "text"])]])
	vim.cmd([[let opts = {'relative': 'cursor', 'width': 10, 'height': 2, 'col': 0,
	\ 'row': 1, 'anchor': 'NW', 'style': 'minimal'}]])
	vim.cmd([[let win = nvim_open_win(buf, 0, opts)]])
	-- " optional: change highlight, otherwise Pmenu is used
	vim.cmd([[call nvim_set_option_value('winhl', 'Normal:MyHighlight', {'win': win})]])
end, { desc = '[s]cratch buffer'}) -- Cursed command D;

local aucmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

aucmd("TextYankPost", {
    desc = "Highlight [y]ank",
    group = augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})

-- INFO: Plugs
require('pacman')
