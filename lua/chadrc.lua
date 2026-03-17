-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "doomchad",

  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
  },
  transparency = true,
}

M.ui = {
  tabufline = {
    lazyload = false,
    order = { "treeOffset", "buffers", "tabs", "never_goon", "btns" },
    modules = {
      never_goon = function()
        return "never😂goon "
      end,
    },
  },

  telescope = { style = "bordered" },
  statusline = {
    theme = "default",
    separator_style = "default",
    -- order = { "mode", "f", "git", "%=", "lsp_msg", "%=", "lsp", "cwd", "suck" },
    -- modules = {
    --   f = "%F", -- full path
    --   suck = "%L %l", -- Total line, current line
    -- },
  },
  -- tabufline = {},
  cmp = { -- what is this?
    style = "atom_colored",
  },
}

M.nvdash = { load_on_startup = true }

-- M.term = {}

-- M.lsp = {}
-- M.mason = {}

-- M.cheatsheet = {}

M.colorify = {
  virt_text = " ", -- #ff7200
}

return M
