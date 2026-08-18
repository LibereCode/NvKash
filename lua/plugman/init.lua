local M = {}

---@class Plugman.add.Src
---@field host string example: https://github.com
---@field owner string example: nvim-treesitter
---@field repo string example: nvim-lspconfig
---@field name? string name used in `require('<name>').setup()`. defaults to **repo**
---@field opts? vim.pack.Spec without src (will get overriden by previous fields)

M.state = {
    plugins = {},
    setups = {},
    lazy_functions = {},
}

---@param src Plugman.add.Src @Plugman.add.Src
---@param setup table the table inside `require("plugin").setup(<HERE>)`
---@param lazy_function? function function that is ran after plugin have been setup
M.add = function(src, setup, lazy_function)
    local src_full = { src = src.host .. "/" .. src.owner .. "/" .. src.repo }
    local src_opts = vim.tbl_extend("force", src.opts or {}, src_full)
    --TODO: auto-strip ".nvim$" (and other .*$) from name
    local name = src.name or src.repo

    table.insert(M.state.plugins, src_opts)
    M.state.setups[name] = setup
    if lazy_function then
        table.insert(M.state.lazy_functions, lazy_function)
    end
end

--TODO: instead wait until `UIEnter`-event and `vim.pack.add` on all plugins at once

---@class Plugman.setup.Opts
---@field packadd_opts? vim.pack.keyset.add

---@param opts Plugman.setup.Opts @Plugman.setup.Opts -- TODO: add more fields than just @vim.pack.keyset.add
M.setup = function(opts)
    opts = opts or {}
    local packadd_opts = opts.packadd_opts or {}
    vim.api.nvim_create_autocmd("VimEnter", {
        group = vim.api.nvim_create_augroup("UIEnter_plugman_packadd", { clear = true }),
        desc = "Load and setup all plugins added with `require('plugman').add()`",
        once = true,
        callback = function()
            vim.pack.add(M.state.plugins, packadd_opts)
            for req_name, setup_tbl in pairs(M.state.setups) do
                require(req_name).setup(setup_tbl)
            end
            for _, func in ipairs(M.state.lazy_functions) do
                func()
            end
        end,
    })
end
--TODO: Have the setup function eiter create a autocmd, or have it packadd when used
--  -- prefer autocmd

return M
