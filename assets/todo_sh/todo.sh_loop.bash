#!/usr/bin/env bash

printf "\e[32mWhile-loop of: \`todo.sh <input>\`.\n\tPress <enter> to exit\n\e[33mNOTE: Do NOT quote the added strings!!\e[0m\n\n"
todo_conf="$XDG_CONFIG_HOME/nvim/assets/todo_sh/todo.cfg"
todo.sh -d "$todo_conf" ls
while true
do
    printf "\e[32m> todo.sh \e[0m\a"
    read -a input
    if [ -z "${input[*]}" ]; then
        break
    else
        todo.sh -d "$todo_conf" "${input[0]}" "${input[@]:1}"  # Who the fuck thought the bash-array syntax was good? Zsh's 100x better
    fi
done
