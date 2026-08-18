---Set mappings more conveniently
---@param lhs string key -- in v0.13 this can also be |string[]
---@param rhs string|function cmd -- a cmdline-entry or a lua-function
---@param opts? vim.keymap.set.Opts options
---@param mode? string|string[] mode(s) -- see `:h map-modes`
local map = function(lhs, rhs, opts, mode)
    local opts = opts or {}
    local mode = mode or ""
    vim.keymap.set(mode, lhs, rhs, opts)
end

map("<leader>test", function() -- XXX: Cursed mapping D;
    vim.cmd([[let buf = nvim_create_buf(v:false, v:true)]])
    vim.cmd([[call nvim_buf_set_lines(buf, 0, -1, v:true, ["test", "text"])]])
    vim.cmd([[let opts = {'relative': 'cursor', 'width': 10, 'height': 2, 'col': 0,
	\ 'row': 1, 'anchor': 'NW', 'style': 'minimal'}]])
    vim.cmd([[let win = nvim_open_win(buf, 0, opts)]])
    -- " optional: change highlight, otherwise Pmenu is used
    vim.cmd([[call nvim_set_option_value('winhl', 'Normal:MyHighlight', {'win': win})]])
end, { desc = "[s]cratch buffer" }, "n")
