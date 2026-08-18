local aucmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

aucmd("TextYankPost", {
    desc = "Highlight [y]ank",
    group = augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.hl.hl_op()
    end,
})
