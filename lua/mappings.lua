require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map({ "n", "i", "v" }, "<C-s>", "<cmd>w<cr>")

map("t", "<C-ESC>", "<C-\\><C-N>", { desc = "terminal [ESC]ape(🐵) terminal mode" })
-- terminal
map({ "n", "t" }, "<M-v>", function()
  require("nvchad.term").toggle { pos = "vsp", id = "vtoggleTerm" }
end, { desc = "[v]ertical" })
map({ "n", "t" }, "<M-f>", function()
  require("nvchad.term").toggle { pos = "float", id = "floatTerm" }
end, { desc = "[f]loating" })
map({ "n", "t" }, "<M-t>", function()
  require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm" }
end, { desc = "[c]onsole" })
--
map({ "n", "t" }, "<C-/>", function()
  require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm" }
end, { desc = "ToggleTerm" })
map({ "n", "t" }, "<leader>tt", function()
  require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm" }
end, { desc = "Toggle[t]erm" })

map("n", "<C-A-h>", "<C-w>H", { desc = "Move window to the left" })
map("n", "<C-A-l>", "<C-w>L", { desc = "Move window to the right" })
map("n", "<C-A-j>", "<C-w>J", { desc = "Move window to the lower" })
map("n", "<C-A-k>", "<C-w>K", { desc = "Move window to the upper" })

if require("nvconfig").ui.tabufline.enabled then -- Switch Buffers -- tab-bar -- nvchad Tabufline
  map("n", "<S-h>", "<cmd>lua require('nvchad.tabufline').prev()<CR>", { desc = "Switch to left buffer" })
  map("n", "<S-l>", "<cmd>lua require('nvchad.tabufline').next()<CR>", { desc = "Switch to right buffer" })
end

map({ "n", "x" }, "<leader>cf", function() -- conform
  require("conform").format { lsp_fallback = true }
end, { desc = "[f]ormat file" })

map("n", "<leader>cl", vim.diagnostic.setloclist, { desc = "[l]oclist diagnostic" }) -- global lsp mappings

map("n", "<C-c>", "gcc", { desc = "toggle [c]omment", remap = true }) -- Comment
map("v", "<C-c>", "gc", { desc = "toggle [c]omment", remap = true })

map("n", "<leader>sg", "<cmd>Telescope live_grep<CR>", { desc = "live [g]rep" }) -- telescope
map("n", "<leader>gc", "<cmd>Telescope git_commits<CR>", { desc = "telescope [c]ommits" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "telescope find oldfiles" })
map("n", "<leader>sz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "fzf buffer" })
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "telescope find files" })
map(
  "n",
  "<leader>fa",
  "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
  { desc = "telescope find all files" }
)

map("n", "<leader>WK", "<cmd>WhichKey <CR>", { desc = "Which[K]ey" }) -- whichkey
map("n", "<leader>Wk", function()
  vim.cmd("WhichKey " .. vim.fn.input "WhichKey: ")
end, { desc = "Which[k]ey query" })

map("n", ";", ":", { desc = "CMD enter command mode" })
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>", { desc = "[s]ave file" })
map({ "n", "i", "v" }, "<C-q>", "<cmd> q <cr>", { desc = "[q]uit file" })

-- vim.keymap.set("n", "<C-a>", function() -- dial -- TODO: download
--   require("dial.map").manipulate("increment", "normal")
-- end, { desc = "dial [a]dd" })
-- vim.keymap.set("n", "<C-x>", function()
--   require("dial.map").manipulate("decrement", "normal")
-- end, { desc = "dial [a]dd" })
-- vim.keymap.set("n", "g<C-a>", function()
--   require("dial.map").manipulate("increment", "gnormal")
-- end, { desc = "dial [a]dd" })
-- vim.keymap.set("n", "g<C-x>", function()
--   require("dial.map").manipulate("decrement", "gnormal")
-- end, { desc = "dial [a]dd" })

map("c", "<C-tab>", "<C-d>", { desc = "Show completions" }) -- C-d Gives a list of possible commands (in :cmd mode)

map("n", "<leader><tab>h", "<cmd>tabprevious<CR>", { desc = "󰌥 Prev" }) -- tab
map("n", "<leader><tab>l", "<cmd>tabnext<CR>", { desc = "Next 󰌒" })
map("n", "<leader><tab><tab>", "<cmd>tabnew<CR>", { desc = "New [󰌒 ]" })
map("n", "<leader><tab>d", "<cmd>tabclose<CR>", { desc = "Delete󰌒 " })
