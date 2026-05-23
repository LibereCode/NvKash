-- Linting

---@module 'lazy'
---@type LazySpec
return {
  'mfussenegger/nvim-lint',
  event = { 'BufReadPre', 'BufNewFile' },
  -- otps = { ? }
  config = function(_, opts)
    local lint = require 'lint'

    -- TEST:
    lint.linters_by_ft = {
      markdown = { 'markdownlint-cli2' }, -- 'vale'
      text = { 'vale' },

      -- INFO: Add more here

      json = { 'jsonlint' }, -- jsonlint biome ...
      sh = { 'shellcheck' },
      bash = { 'shellcheck', 'bash' },
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

    ---@param key string
    ---@param cmd string|function
    ---@param mapOpts? table  -- defaults to: {}
    ---@param mode? string    -- defaults to: 'n'
    local lint_map = function(key, cmd, mapOpts, mode)
      if mapOpts and mapOpts.desc then mapOpts.desc = 'Lint: ' .. mapOpts.desc end
      vim.keymap.set(mode or 'n', key, cmd, mapOpts or {})
    end
    --
    lint_map('<leader>cL', function()
      local lintGet = lint.get_running()
      print 'lint.get_running:'
      for key, val in pairs(lintGet) do
        print(key, val)
      end
      local linters = lint.linters
      print 'lint.linters:'
      for key, val in pairs(linters) do
        print(key, val)
      end
    end, { desc = '[L]inters' })
    --
  end,
}
