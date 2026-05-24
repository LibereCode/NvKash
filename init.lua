local vim = vim -- lol (but to remove annoying 'what is vim?' lsp-warnings)

local o = vim.opt
local g = vim.g

g.mapleader = " "
g.maplocalleader = ","

o.number = true
o.relativenumber = true
o.cursorline = true
-- o.expandtab = true -- makes tabs spaces
o.shiftwidth = 0 -- => tabstop
-- o.softtabstop = 4
o.tabstop = 4
o.smartindent = true
o.smartcase = true
o.showmatch = true
o.syntax = "on"
o.clipboard = "unnamedplus"
o.shortmess:append("sa")
o.sidescrolloff = 10
o.sidescroll = 0
o.scrolloff = 10
o.scrolljump = 1
o.undofile = true
o.swapfile = true
o.ignorecase = true
o.smartcase = true
o.signcolumn = "yes"
o.list = true
o.inccommand = "split"
o.virtualedit = "block"

local map = function(key, cmd, opts_add, mode)
    -- Allow to set default opts and add new ones
    local opts_base = {}
    local opts = vim.tbl_extend("error", opts_base, opts_add or {})
    vim.keymap.set(mode or "n", key, cmd, opts)
end

map("<ESC><ESC>", "<C-\\><C-n>", {}, "t")
map("<LEADER>e", ":Ex<CR>")
map("j", "gj", { desc = "better ↓j" }, { "n", "v" })
map("k", "gk", { desc = "better ↑k" }, { "n", "v" })

local aucmd = vim.api.nvim_create_autocmd

aucmd("TextYankPost", {
    desc = "Highlight when [y]anking",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})

-- INFO: plugins

aucmd("PackChanged", {
    --- @param ev {data: {spec: {name: string, kind: string}, active: boolean}}  -- Type for the event (ev)
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind
        if name == "nvim-treesitter" and kind == "update" then
            if not ev.data.active then
                vim.cmd.packadd("nvim-treesitter")
            end
            vim.cmd("TSUpdate")
        end
    end,
})

local gh = function(x)
    return "https://github.com/" .. x
end
local cb = function(x)
    return "https://codeberg.org/" .. x
end
vim.pack.add({
    gh("nvim-mini/mini.nvim"),
    gh("neovim/nvim-lspconfig"),
    gh("nvim-treesitter/nvim-treesitter"),
    gh("folke/which-key.nvim"),
})

-- vim.lsp.enable({ 'lua_ls' })

local plugup = function(plug, opts)
    opts = opts or nil
    require(plug).setup(opts)
end
plugup("mini.basics")
plugup("mini.surround")
plugup("mini.ai")
plugup("mini.move", {
    -- Module mappings. Use `''` (empty string) to disable one.
    mappings = {
        -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
        left = "<C-h>",
        right = "<C-l>",
        down = "<C-j>",
        up = "<C-k>",
        -- Move current line in Normal mode
        line_left = "<C-h>",
        line_right = "<C-l>",
        line_down = "<C-j>",
        line_up = "<C-k>",
    },
    -- there are more options
})

-- lazy loading
local misc = require("mini.misc")
misc.setup()
local later = function(f)
    misc.safely("later", f)
end
local on_event = function(ev, f)
    misc.safely("event:" .. ev, f)
end
on_event("InsertEnter", function()
    plugup("mini.completion")
end)

local crcmd = vim.api.nvim_create_user_command
crcmd("PackGet", function()
    local packnames = vim.iter(vim.pack.get())
        :map(function(x)
            return x.spec.name
        end)
        :totable()
    print("-----------------")
    for i = 1, #packnames do
        print(i, packnames[i])
    end
    print("-----------------")
end, { desc = "Print vim.pack.get table" })
