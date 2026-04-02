return { -- NOTE: Autoformat
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>cf',
      function() require('conform').format { async = true, lsp_format = 'fallback' } end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  ---@module 'conform'
  -- ---@type conform.setupOpts
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      -- Disable "format_on_save lsp_fallback" for languages that don't
      -- have a well standardized coding style. You can add additional
      -- languages here or re-enable it for the disabled ones.
      local disable_filetypes = { c = true, cpp = true }
      if disable_filetypes[vim.bo[bufnr].filetype] then
        return nil
      else
        return {
          timeout_ms = 345,
          lsp_format = 'fallback',
        }
      end
    end,
    formatters_by_ft = {
      lua = { 'stylua' },
      -- Conform can also run multiple formatters sequentially
      -- python = { 'isort', 'black' },
      --
      -- You can use 'stop_after_first' to run the first available formatter from the list
      javascript = { 'prettierd', 'prettier', stop_after_first = true },

      -- HACK: Add more here

      -- inspired by lazyvim https://www.lazyvim.org/plugins/formatting#conformnvim
      fish = { 'fish_indent' },
      sh = { 'beautysh' },
      bash = { 'beautysh' },
      zsh = { 'beautysh' },
      python = function(bufnr) -- runs ruff if I have it, else isort+black
        if require('conform').get_formatter_info('ruff_format', bufnr).available then
          return { 'ruff_format' } -- config in ~/.config/ruff/ruff.toml
        else
          return { 'black' } -- 'isort'
        end
      end,
      -- kdl = { "kdlfmt" }, -- fucks up niri config, and I can't get `.kdlfmtignore` to work -- https://github.com/hougesen/kdlfmt
      markdown = { 'markdownlint-cli2', 'markdown-toc' }, -- "markdownlint-cli2" -- TEST:
      yaml = { 'prettierd' },

      nix = { 'nixfmt' },
    },
  },
}
