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
      vim.cmd.terminal [[ bash -c 'printf "\e[32mWhile-loop of: \`todo.sh <input>\`.\n\tPress <enter> to exit\n\e[33mNOTE: Do NOT quote the added strings!!\e[0m\n\n"
todo_conf="$XDG_CONFIG_HOME/nvim/assets/todo_sh/todo.cfg"
todo.sh -d "$todo_conf" ls
while true
do
  printf "\e[32m> todo.sh \e[0m\a"
  read -a input
  if [ -z $input ]; then
    break
  else
    todo.sh -d "$todo_conf" ${input[0]} ${input[@]:1}
  fi
done'
]] -- Who the fuck thought the bash-array syntax was good? Zsh's 100x better
    end
  end
  vim.cmd 'startinsert'
end

vim.api.nvim_create_user_command('Todosh', toggle_todo, {})

vim.keymap.set({ 'n', 't' }, '<leader>ot', '<CMD>Todosh<CR>')
