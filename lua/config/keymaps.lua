-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: INFO: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
local nomap = vim.keymap.del -- disable (default) mappings

-- HACK: nomap

nomap("n", "<leader>`")
nomap("n", "<leader>bo")
nomap("n", "<leader>K")
nomap("n", "<leader>l")
nomap("n", "<leader>L")
nomap("n", "<leader>fT")
-- nomap({ "n", "t" }, "<C-/>")

-- HACK: map

map("n", "<leader>gm", "<cmd>norm! K<cr>", { desc = "Keywordprg(man)" })

map("n", "<leader>bn", "<cmd>enew<cr>", { desc = "new" })

if vim.lsp.inlay_hint then
  Snacks.toggle.inlay_hints():map("<leader>uh")
end

-- lazy
map("n", "<leader>ll", "<cmd>Lazy<cr>", { desc = "Lazy" })
map("n", "<leader>ln", function()
  LazyVim.news.changelog()
end, { desc = "LazyVim [n]ews" }) -- LazyVim Changelog
map("n", "<leader>le", "<cmd>LazyExtras<cr>", { desc = "LazyExtras" })
map("n", "<leader>ld", "<cmd>LazyDev<cr>", { desc = "LazyDev" })
map("n", "<leader>lh", "<cmd>LazyHealth<cr>", { desc = "LazyHealth" })
-- lazygit / git
if vim.fn.executable("lazygit") == 1 then -- checks if I have lazygit installed
  map("n", "<leader>lg", function()
    Snacks.lazygit()
  end, { desc = "Lazygit" })
end

map("n", "<C-q>", "<cmd>q<cr>", { desc = "Quit" }) -- quit
map("n", ";", ":")

map("n", "gl", "g]1<CR><escape>", { desc = "[l]ocal link" }) -- disables default. This is used in: help, man, markdown, ...

map("n", "<leader>T", function()
  Snacks.terminal.focus()
  vim.cmd("startinsert") -- why is this not default?
end, { desc = "Terminal" })

vim.keymap.set("n", "<C-/>", function()
  require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({ -- insane combo
    winblend = 10,
    previewer = false,
  }))
end, { desc = "Fzf [/] current buf" })

-- buffers
map("n", "<leader>bx", function()
  Snacks.bufdelete.other()
end, { desc = "Delete Other Buffers" })

-- windows
map("n", "<C-A-h>", "<C-w>H", { desc = "Move window to the left" })
map("n", "<C-A-l>", "<C-w>L", { desc = "Move window to the right" })
map("n", "<C-A-j>", "<C-w>J", { desc = "Move window to the lower" })
map("n", "<C-A-k>", "<C-w>K", { desc = "Move window to the upper" })

-- tabs
map("n", "<leader><tab>e", "<cmd>tablast<cr>", { desc = "tab end" })
map("n", "<leader><tab>a", "<cmd>tabfirst<cr>", { desc = "First Tab" })
map("n", "<leader><tab>l", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader><tab>h", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

map("n", "<C-c>", "gcc", { desc = "toggle comment", remap = true }) -- remap required, becuase ?
map("v", "<C-c>", "gc", { desc = "v-mode comment", remap = true })

-- sessions[<leader>q]
map("n", "<leader>qw", "<CMD>wa<CR>", { desc = "[w]rite all" })
map("n", "<leader>qx", "<CMD>w <BAR> so<CR>", { desc = "write & [x]sauce" }) -- figure out why I can't sauce this file

-- code[<leader>c]
map("n", "<leader>cI", "<CMD>LspInfo<CR>")
map("n", "<leader>cL", "<CMD>LspLog<CR>")
map("n", "<leader>ct", vim.show_pos, { desc = "TS Inspect" }) -- Treesitter inspect
map("n", "<leader>cT", function()
  vim.treesitter.inspect_tree()
  vim.api.nvim_input("I")
end, { desc = "TS Inspect Tree" })
