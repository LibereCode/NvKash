return {
  {
    ---@type LazySpec
    "mikavilpas/yazi.nvim",
    version = "*", -- use the latest stable version
    event = "VeryLazy",
    dependencies = {
      { "nvim-lua/plenary.nvim", lazy = true },
    },
    keys = {
      -- 👇 in this section, choose your own keymappings!
      {
        "<leader>y", -- "<leader>-",
        mode = { "n", "v" },
        "<cmd>Yazi cwd<cr>",
        desc = "Yazi cwd",
      },
      {
        "<c-y>", -- "<C-->", -- "<c-up>",
        "<cmd>Yazi toggle<cr>",
        desc = "Resume the last yazi session",
      },
    },
    ---@type YaziConfig | {}
    opts = {
      keymaps = {
        show_help = "<f1>",
        -- cycle_open_buffers = false,
        -- OR
        cycle_open_buffers = "<S-Tab>",
      },
      -- 👇 if you want to open yazi instead of netrw
      open_for_directories = true,
    },
    init = function() -- 👇 if you use `open_for_directories=true`, this is recommended
      -- mark netrw as loaded so it's not loaded at all.-- INFO: More details: https://github.com/mikavilpas/yazi.nvim/issues/802
      vim.g.loaded_netrwPlugin = 1
    end,
  },
  -- { 'stevearc/oil.nvim', keys = { { '<leader>o', '<CMD>Oil<CR>' } }, opts = { default_file_explorer = false } }, -- NOTE: oil🦅 -- good, but doesn't fit

  { -- NOTE: Neo-Tree (This is best way)
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      -- "nvim-mini/mini.icons", -- HACK:
      "MunifTanjim/nui.nvim",
      -- '3rd/image.nvim', -- allows image view in preview
    },
    keys = {
      { "<leader>e", ":Neotree float reveal toggle<CR>", desc = "float-N[e]oTree", silent = true },
      { "<C-e>", ":Neotree left reveal<CR>", desc = "left N[e]oTree reveal", silent = true },
    },
    opts = { -- https://github.com/nvim-neo-tree/neo-tree.nvim?tab=readme-ov-file#configuration
      close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
      enable_git_status = true,
      enable_diagnostics = true,
      filesystem = {
        window = {
          mappings = {
            ["<C-e>"] = "close_window",
            ["l"] = "open",
            ["h"] = "close_node",
            ["L"] = "set_root",
            ["H"] = "navigate_up",
            ["."] = "toggle_hidden",
            ["q"] = "close_window",
            ["P"] = {
              "toggle_preview",
              config = {
                use_float = true,
                use_snacks_image = false,
                use_image_nvim = false,
              },
            },
          },
        },
        hijack_netrw_behavior = "disabled", -- weird ass name -- allows to open yazi by default
      },
    },
  },

  -- { 'luukvbaal/nnn.nvim', opts = {} }, -- NOTE: nnn -- pretty good, but doesnt fit this config
}
