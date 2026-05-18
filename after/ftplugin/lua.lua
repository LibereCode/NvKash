---@param key string
---@param cmd string|function
---@param optsExtra table? -- **OPTIONAL** locked having `buf = 0`
---@param mode (string|table<string>)? -- **OPTIONAL** defaults to 'n'
local function map(key, cmd, optsExtra, mode)
  mode = mode or 'n'
  local opts = vim.tbl_extend('error', { buf = 0 }, optsExtra)
  vim.keymap.set(mode, key, cmd, opts)
end

map('<localleader>r', function() vim.cmd 'source' end, { desc = '[r]un Lua' }, { 'n', 'x' })

map('<localleader>R', function() vim.cmd([[ terminal nvim -l ]] .. vim.fn.expand '%:p') end, { desc = '[R]un Lua (nvim -l)', silent = true })

---@return function -- Soo dumb (returning a function like that)... but it works?
local function helpCword() -- return a function() that search help of the current word
  return function()
    local hword = vim.fn.expand '<cword>'
    vim.cmd('h ' .. hword)
  end
end
map('<localleader>h', helpCword(), { desc = 'help <cword>', remap = true })
map('gh', helpCword(), { desc = 'help <cword>', remap = true }) -- will replace the ... weird?
-- default gh ``:h gh`. Just use <C-g> while in V-mode instead....

local o = vim.opt_local
-- o.softtabstop = 2 -- . :h 'sts' -- Will only be applied at config because :...
-- ... I have a ~/.config/stylua saying tab = 4, so stylua here don't apply globally
