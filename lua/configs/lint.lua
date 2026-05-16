-- Linting

---@module 'lazy'
---@type LazySpec
return {
  'mfussenegger/nvim-lint',
  event = { 'BufReadPre', 'BufNewFile' },
  -- otps = { ? }
  config = function(_, opts)
    local lint = require 'lint'

    -- lint.linters_by_ft = { -- to allow only the following
    --   markdown = { 'markdownlint' },
    -- }

    -- for name, linter in pairs(opts.ft_linters) do -- WARN: this with opts.ft_linters didn't work D:
    --   lbf(name, linter)
    -- end

    -- lint.linters_by_ft = lint.linters_by_ft or {}
    -- ---@param lintpairs table<string,string>
    -- local function lbf(lintpairs)
    --   for file, linter in pairs(lintpairs) do
    --     lint.linters_by_ft[file] = { linter }
    --   end
    -- end
    -- lbf {
    --   clojure = 'clj-kondo',
    --   dockerfile = 'hadolint',
    --   inko = 'inko',
    --   janet = 'janet',
    --   json = 'jsonlint',
    --   rst = 'vale',
    --   ruby = 'ruby',
    --   terraform = 'tflint',
    --   python = 'ruff', -- I think ty works as a linter on it's own?  NOTE:
    --   javascript = 'biome', -- ... don't ...
    --   typescript = 'biome', -- ... work ?
    --   go = 'nilaway',
    -- }

    -- TEST:
    lint.linters_by_ft = {
      markdown = { 'markdownlint-cli2' }, -- 'vale'
      text = { 'vale' },

      -- INFO: Add more here

      json = { 'jsonlint' }, -- jsonlint biome ...
      sh = { 'shellcheck' },
      bash = { 'shellcheck', 'bash' },
      zsh = { 'zsh' }, -- ??
      fish = { 'fish' }, -- ??
    }

    -- You can disable the default linters by setting their filetypes to nil:
    -- lint.linters_by_ft['clojure'] = nil
    -- lint.linters_by_ft['dockerfile'] = nil
    -- lint.linters_by_ft['inko'] = nil
    -- lint.linters_by_ft['janet'] = nil
    -- lint.linters_by_ft['json'] = nil
    -- lint.linters_by_ft['markdown'] = nil
    -- lint.linters_by_ft['rst'] = nil
    -- lint.linters_by_ft['ruby'] = nil
    -- lint.linters_by_ft['terraform'] = nil
    -- lint.linters_by_ft['text'] = nil

    -- Create autocommand which carries out the actual linting
    -- on the specified events.
    local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
      group = lint_augroup,
      callback = function()
        -- Only run the linter in buffers that you can modify in order to
        -- avoid superfluous noise, notably within the handy LSP pop-ups that
        -- describe the hovered symbol using Markdown.
        if vim.bo.modifiable then lint.try_lint() end
      end,
    })
  end,
}
