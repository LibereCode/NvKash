-- LazyGit💤

-- version 2.0

local state = {
  floating = {
    buf = -1,
    win = -1,
  },
}

local toggle_todo = function()
  if vim.api.nvim_win_is_valid(state.floating.win) then -- if visible
    vim.api.nvim_win_hide(state.floating.win) -- hide
  else
    state.floating = require('custom.modules.toggle_float').toggle_float { x = 0.8, y = 0.8, buf = state.floating.buf } -- tells it to use the same buffer
    if vim.bo[state.floating.buf].buftype ~= 'terminal' then -- if buftype isn't terminal
      vim.cmd.terminal('bash -c "' .. vim.fn.stdpath 'config' .. '/assets/todo_sh/todo.sh_loop.bash"')
    end
  end
  vim.cmd 'startinsert'
end

vim.api.nvim_create_user_command('Todosh', toggle_todo, {})

vim.keymap.set({ 'n', 't' }, '<leader>ot', '<CMD>Todosh<CR>')
