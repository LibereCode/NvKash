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
    -- To allow other plugins to add linters to require('lint').linters_by_ft,
    -- INSTEAD set linters_by_ft like this:
    -- lint.linters_by_ft = lint.linters_by_ft or {}
    -- lint.linters_by_ft['markdown'] = { 'markdownlint' }

    -- for name, linter in pairs(opts.ft_linters) do -- WARN: this with opts.ft_linters didn't work D:
    --   lbf(name, linter)
    -- end

    lint.linters_by_ft = lint.linters_by_ft or {}
    local function lbf(ft, linter) lint.linters_by_ft[ft] = { linter } end
    -- lbf('foo', 'bar')
    --
    -- lbf('clojure', 'clj-kondo')
    -- lbf('dockerfile', 'hadolint')
    -- lbf('inko', 'inko')
    -- lbf('janet', 'janet')
    -- lbf('json', 'jsonlint')
    lbf('markdown', 'markdownlint-cli2') -- 'vale'
    -- lbf('rst', 'vale')
    -- lbf('ruby', 'ruby')
    -- lbf('terraform', 'tflint')
    lbf('text', 'vale')
    -- INFO: Add more here
    -- lbf('python', 'ruff') -- I think ty works as a linter on it's own?  NOTE:
    lbf('json', 'jsonlint') -- biome ...
    -- lbf('javascript', 'biome') -- ... don't ...
    -- lbf('typescript', 'biome') -- ... work ?
    -- lbf('go', 'nilaway')
    lbf('bash', 'shellcheck')
    lbf('sh', 'shellcheck')

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
