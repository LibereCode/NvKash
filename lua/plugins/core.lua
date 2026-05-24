return { -- INFO: add config to core plugins here:
  --       (mirrored my kickstart core) -- link-to-LazyVim-reference
  -- lsp
  -- mason
  -- conform(formatting) -- https://www.lazyvim.org/plugins/formatting
  -- mason
  -- blink
  -- lint(code-checker?) -- https://www.lazyvim.org/plugins/linting
  -- treesitter(syntax-highlight) -- https://www.lazyvim.org/plugins/treesitter

  {
    "stevearc/conform.nvim",
    keys = {
      {
        -- "<leader>ic",
        "<leader>ci",
        "<CMD>ConformInfo<CR>",
        mode = { "n" },
        desc = "ConformInfo",
      },
    },
    -- https://github.com/stevearc/conform.nvim?tab=readme-ov-file#options,  -- https://github.com/stevearc/conform.nvim?tab=readme-ov-file#setup
    opts = {
      default_format_opts = {
        timeout_ms = 723, -- 3000 -- decrease timeout, quit faster
      },
      formatters_by_ft = {
        sh = { "beautysh" },
        bash = { "beautysh" },
        zsh = { "beautysh" },
        python = function(bufnr) -- runs ruff if I have it, else isort+black
          if require("conform").get_formatter_info("ruff_format", bufnr).available then
            return { "ruff_format" } -- config in ~/.config/ruff/ruff.toml
          else
            return { "isort", "black" }
          end
        end,
        -- kdl = { "kdlfmt" }, -- fucks up niri config, and I can't get `.kdlfmtignore` to work -- https://github.com/hougesen/kdlfmt
        markdown = { "markdownlint-cli2", "markdown-toc" }, -- "markdownlint-cli2" -- TEST:
        yaml = { "prettierd" },
      },
      formatters = { -- configure the formatters.
        beautysh = { --  example, give arguments:
          prepend_args = { "-i", "2" },
        },
      },
    },
  },

  -- think there are good defaults in LazyVim
  {
    "mfussenegger/nvim-lint",
    linters_by_ft = {
      ["_"] = { "codespell" }, -- "_" = fallback, if no other linter
      -- markdown = { "vale" },
    },
    linters = {},
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- ["*"] = {
        --   keys = {}, -- add global mappings -- append 'has = "..."' to require some capability
        -- },
        -- lua_ls = {
        --   keys = {}, -- add local mappings
        -- },
      },
    },
  },
}
