return {
  { -- NOTE: lualine
    "nvim-lualine/lualine.nvim",
    dependencies = {
      { "tiagovla/scope.nvim", config = true }, -- NOTE: Scope -- https://github.com/tiagovla/scope.nvim
    },
    opts = {
      options = {
        component_separators = { left = "|", right = "|" }, -- { left = '', right = '' },
        section_separators = { left = "", right = "" }, -- { left = '', right = '' },
      },
    },
  },

  { -- NOTE: bufferline
    "akinsho/bufferline.nvim",
    keys = function()
      return {
        { "<leader>bb", "<Cmd>e #<CR>", desc = "switch to other [b]" },
        { "<leader>bn", "<Cmd>enew<CR>", desc = "[n]ew buffile" },
        { "<leader>bl", "<Cmd>buffers<CR>", desc = "[l]ist buffers" },

        { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "toggle [p]in" },
        { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "delete non-[P]inned buffers" },
        { "<leader>bd", "<Cmd>bn <BAR> bd #<CR>", desc = "[d]elete buffer" },
        { "<leader>bD", "<Cmd>BufferLinePickClose<CR>", desc = "pick buf2[D]EL" },
        { "<leader>bl", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers👉" },
        { "<leader>bh", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete 👈Buffers" },
        { "<leader>bs", "<cmd>BufferLinePick<cr>", desc = "[s]elect buf" },

        { "H", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
        { "L", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
        { "<M-H>", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer prev" },
        { "<M-L>", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer next" },
        { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
        { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
        { "[B", "<cmd>BufferLineMovePrev<cr>", desc = "Move Buffer prev" },
        { "]B", "<cmd>BufferLineMoveNext<cr>", desc = "Move Buffer next" },
      }
    end,
    opts = {
      options = {
        indicator = {
          icon = "👉", -- '▎', -- this should be omitted if indicator style is not 'icon'
          style = "icon", --'icon' | 'underline' | 'none',
        },
        modified_icon = " ", -- '● ',
        always_show_bufferline = true,
      },
    },
  },
}
