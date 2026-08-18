-- https://github.com/stevearc/oil.nvim
local name = "nvim-tree"
require("plugman").add({
    host = "https://github.com", owner = "nvim-tree", repo = "nvim-tree.lua", name = name,
    }, {
    }
)
vim.keymap.set("n", "<leader>e", function() require(name .. ".api").tree.toggle() end, { desc = "nvim-tree" })
