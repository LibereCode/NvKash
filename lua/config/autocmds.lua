-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set:
-- INFO: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- autocmd
local autocmd = vim.api.nvim_create_autocmd
local del_autocmd = vim.api.nvim_del_augroup_by_name

--

-- create commands
local cr_cmd = vim.api.nvim_create_user_command -- ('name', 'command', {})
local cmd = vim.cmd -- (':cmd')

cr_cmd("W", "SudaWrite", {})
