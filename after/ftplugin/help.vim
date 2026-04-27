:setlocal sidescrolloff=0 " helpdocs already have a good witdh (or wrap, idk, idgaf)

" NOTE: lua HEREDOC
lua << EOF
-- INFO: Simply a copy of the same mapping in `./lua.lua`, but put here so that if you open help from a non-lua file, you still get access

---@param key string
---@param cmd string|function
---@param optsExtra table? -- **OPTIONAL** locked having `buf = 0`
---@param mode (string|table<string>)? -- **OPTIONAL** defaults to 'n'
local function map(key, cmd, optsExtra, mode)
  mode = mode or 'n'
  local opts = vim.tbl_extend('error', { buf = 0 }, optsExtra)
  vim.keymap.set(mode, key, cmd, opts)
end

map('<localleader>h', function()
  local hword = vim.fn.expand '<cword>'
  vim.cmd('h ' .. hword)
end, { desc = 'help <cword>', remap = true })

local function helpCword() -- Soo dumb (returning a function like that)... but it works?
  return function()
    local hword = vim.fn.expand '<cword>'
    vim.cmd('h ' .. hword)
  end
end
map('<localleader>h', helpCword(), { desc = 'help <cword>', remap = true })
map('gh', helpCword(), { desc = 'help <cword>', remap = true }) -- will replace the ... weird? default gh ``:h gh`

EOF
