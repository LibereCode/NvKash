return { -- Useful plugin to show you pending keybinds.
  "folke/which-key.nvim",
  event = "VimEnter",
  opts = {
    delay = 0, -- delay between pressing a key and opening which-key (milliseconds)
    spec = { -- Document existing key chains
      { "<leader>gh", group = "Git [H]unk", mode = { "n", "v" } }, -- Enable gitsigns recommended keymaps first
      { "gr", group = "LSP Actions", mode = { "n" } },

      -- HACK: add more groups below

      -- <leader>
      { "<leader>i", group = "[i]nspect/info", mode = { "n" } },
      { "<leader>l", group = "lazy", mode = { "n" } },
      { "<leader>m", group = "text/[m]arkdown", mode = { "n" } },
      { "<leader>o", group = "[o]rg-mode", mode = { "n" } },
      { "<leader>s", group = "search/[s]elect", mode = { "n", "v" } },
      { "<leader>f", group = "find/[f]iles", mode = { "n", "v" } },
      { "<localleader>", group = "Local Leader", mode = { "n", "v" } },

      -- <leader> subgroups
      { "<leader>bo", group = "order", mode = { "n" } },

      -- [g]oto
      -- { "gs", group = "surround", mode = { "n", "v" } },

      {
        "<leader>b",
        group = "[b]buffer",
        expand = function()
          return require("which-key.extras").expand.buf()
        end,
      },
      {
        "<leader>w",
        group = "[w]windows",
        proxy = "<c-w>",
        expand = function()
          return require("which-key.extras").expand.win()
        end,
      },
    },
  },
}
