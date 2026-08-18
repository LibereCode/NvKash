-- INFO: Set options, mappings, and other simple config here
local vim = vim

vim.cmd("so " .. vim.fn.stdpath("config") .. "/vimit.vim") -- this works, ... after fix...

require("opts")
require("maps")
require("aucmd")


-- INFO: Plugs
require("plugman").setup() -- TODO: this should init the (custom) plugin manager

require("theme")

require("plugins") -- TODO: this should have the plugins
