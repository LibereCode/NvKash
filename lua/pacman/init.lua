local aucmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

aucmd("PackChanged", {
    desc = "Do shit when plug change",
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind

        if name == "nvim-treesitter" and kind == "update" then
            if not ev.data.avtive then
                vim.cmd.packadd("nvim-treesitter")
            end
            vim.cmd("TSUpdate")
        end
    end,
})

---Plugin from github.com
---@param plugin string -- _user/repo_
---@param opts nil|optsPair -- **OPTIONAL** see: `:h vim.pack-exampes`
---@return table -- full url
local function gh(plugin, opts)
    opts = opts or {}
    return vim.tbl_extend("error", { src = "https://github.com/" .. plugin }, opts)
end
local vrange = vim.version.range
vim.pack.add({
    gh("nvim-mini/mini.nvim"),
    gh("neovim/nvim-lspconfig"),
    gh("nvim-treesitter/nvim-treesitter"),
    gh("folke/which-key.nvim"),

    gh("saghen/blink.cmp", { version = vrange("1.*") }),
    gh("rafamadriz/friendly-snippets"),

    gh("ibhagwan/fzf-lua"),
    gh("nvim-treesitter/nvim-treesitter-context"),

    "https://codeberg.org/andyg/leap.nvim",
})

-- lsp

vim.lsp.config["lua_ls"] = {
    -- Command and arguments to start the server.
    cmd = { "lua-language-server" },
    -- Filetypes to automatically attach to.
    filetypes = { "lua" },
    -- Sets the "workspace" to the directory where any of these files is found.
    -- Files that share a root directory will reuse the LSP server connection.
    -- Nested lists indicate equal priority, see |vim.lsp.Config|.
    root_markers = { { ".luarc.json", ".luarc.jsonc" }, ".git" },
    -- Specific settings to send to the server. The schema is server-defined.
    -- Example: https://raw.githubusercontent.com/LuaLS/vscode-lua/master/setting/schema.json
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
            },
        },
    },
}
vim.lsp.enable({
    "lua_ls",
    "bashls",
})

---require('plugin').setup()
---@param plug string
---@param opts nil|table<any,any>
local function plugup(plug, opts)
    opts = opts or nil
    require(plug).setup(opts)
end
plugup("mini.basics")
plugup("mini.surround", {
    mappings = {
        add = "gsa",
        delete = "gsd",
        find = "gsf",
        find_left = "gsF",
        highlight = "gsh",
        replace = "gsr",

        suffix_last = "l",
        suffix_next = "n",
    },
})
plugup("mini.ai")
plugup("mini.move")
plugup("mini.icons")

-- local misc = require("mini.misc") -- lazyload
-- misc.setup()
-- local function later(f) misc.safely("later", f) end
-- local function on_event(ev, f) misc.safely("event:" .. ev, f) end
-- on_event("InsertEnter", function()
-- 	plugup("mini.completion", {
-- 		lsp_completion = { source_func = 'omnifunc', auto_setup = false, }
-- 	})
-- end)

plugup("blink.cmp", {
    completion = { documentation = { auto_show = true } },
    fuzzy = {
        implementation = "prefer_rust_with_warning",
        prebuilt_binaries = { force_version = "v*" },
    },
}) -- TODO: test nvim.cmp instead

plugup("fzf-lua", {
    -- winopts = {
    -- 	border = "rounded",
    -- 	preview = { border = "rounded" },
    -- },
})

plugup("treesitter-context", {
    multiwindow = true,
})

--- mappings for plugins
---@param key string
---@param cmd string|function
---@param opts nil|table<any,any>
---@param mode nil|table<string>|string
local function map(key, cmd, opts, mode)
    vim.keymap.set(mode or "n", key, cmd, opts or {})
end
---map, but with prepended <leader>
---@param key string -- keys after <leader>
---@param cmd string|function
---@param opts nil|table<any,any>
---@param mode nil|table<string>|string
local function leadmap(key, cmd, opts, mode)
    map("<leader>" .. key, cmd, opts, mode)
end

local FzfLua = FzfLua
leadmap("F", function()
    FzfLua.builtin()
end, { desc = "FzfLua builtin" })
leadmap("fb", function()
    FzfLua.buffers()
end, { desc = "buffers" })
leadmap("ff", function()
    FzfLua.files()
end, { desc = "files" })
leadmap("fg", function()
    FzfLua.live_grep()
end, { desc = "live_grep" })

local wk = require("which-key")
leadmap("?", function()
    wk.show()
end, { desc = "WhichKey[?]" })
wk.add({
    { "<leader>f", group = "fuzzy find" },
    { "gs", group = "surround" },
    {
        "<leader>b",
        group = "buffers",
        expand = function()
            return require("which-key.extras").expand.buf()
        end,
    },
})

local leap = require("leap") -- type: 's'{ch1}{ch2} and then select {ch3}
map("s", "<Plug>(leap)", { desc = "leap" }, { "n", "x", "o" }) -- wtf is <Plug>?
map("S", "<Plug>(leap-from-window)")
leap.opts.preview = function(ch0, ch1, ch2) -- reduce visual noice
    return not (ch1:match("%s") or (ch0:match("%a") and ch1:match("%a") and ch2:match("%a")))
end
do -- jump to next/prev leap-match
    local clever = require("leap.user").with_traversal_keys
    map("<CR>", function()
        leap.leap({
            ["repeat"] = true,
            opts = clever("<CR>", "<BS>"),
        })
    end, {}, { "n", "x", "o" })
    map("<BS>", function()
        leap.leap({
            ["repeat"] = true,
            opts = clever("<BS>", "<CR>"),
            backward = true,
        })
    end, {}, { "n", "x", "o" })
end
aucmd("User", { -- auto paste after remote yank
    pattern = "RemoteOperationDone",
    group = augroup("LeapRemote", {}),
    callback = function(event)
        if vim.v.operator == "y" and event.data.register == '"' then
            vim.cmd("normal! p")
        end
    end,
})

-- INFO: USER COMMANDS

local crcmd = vim.api.nvim_create_user_command
crcmd("PackGet", function()
    local packnames = vim.iter(vim.pack.get())
        :map(function(x)
            return x.spec.name
        end)
        :totable()
    print("-------------------")
    for i = 1, #packnames do
        print(i, packnames[i])
    end
    print("-------------------")
end, { desc = "Print vim.pack.get table" })
