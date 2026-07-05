return { -- NOTE: Autoformat
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>cf',
      function() require('conform').format { async = true, lsp_format = 'fallback' } end,
      desc = '[F]ormat buffer',
    },
    {
      '<leader>cI',
      '<CMD>ConformInfo<CR>',
      desc = 'Conform [i]nfo',
    },
  },
  ---@module 'conform'
  -- ---@type conform.setupOpts
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      local bufname = vim.api.nvim_buf_get_name(bufnr)
      -- Disable "format_on_save lsp_fallback" for languages without FORMAT-STANDARD
      local disable_filetypes = { c = true, cpp = true }
      if disable_filetypes[vim.bo[bufnr].filetype] then
        return nil
        -- inspired by -- https://github.com/NixOS/nixfmt/issues/91#issuecomment-3217419103
        -- elseif bufname:match '%.nix$' then -- For just nix
      else -- If line 2 is vim.o.commentstring .. 'fmt:off' => disable conform (formatting)
        -- TODO:
        -- ADDITIONS
        -- - check each line with conform builtin ?

        local line2 = vim.api.nvim_buf_get_lines(bufnr, 1, 2, false)[1] or ''
        if line2:match(vim.o.commentstring:gsub('%%s', 'fmt:off')) then return nil end
      end
      return { -- else
        timeout_ms = 345,
        lsp_format = 'fallback',
      }
    end,
    formatters_by_ft = {
      lua = { 'stylua' },
      -- Conform can also run multiple formatters sequentially
      -- python = { 'isort', 'black' },
      --
      -- NOTE: You can use 'stop_after_first' to run the first available formatter from the list
      --
      -- javascript = { 'prettierd', 'prettier', stop_after_first = true },

      -- HACK: Add more here

      -- inspired by lazyvim https://www.lazyvim.org/plugins/formatting#conformnvim
      -- TODO: Figure out if key = can be a table ( {sh, bash, zsh } = { 'beautysh' })
      fish = { 'fish_indent' },
      -- sh|bash|zsh = { 'beautysh' }, -- XXX: just using lsp formatter is better
      python = function(bufnr)
        -- stylua: ignore start
        if require('conform').get_formatter_info('ruff_format', bufnr).available then
          return { 'ruff_format' } else return { 'black' } end
      end, -- stylua: ignore stop
      -- kdl = { "kdlfmt" }, -- fucks up niri config, and I can't get `.kdlfmtignore` to work -- https://github.com/hougesen/kdlfmt
      markdown = { 'prettierd' }, -- "markdownlint-cli2" -- TEST:
      yaml = { 'prettierd' },
      json = { 'prettierd' },
      jsonc = { 'prettierd' },

      nix = { 'nixfmt' },
      css = { 'prettierd' },
      xml = { 'xmlformatter' },

      -- ['_'] = { 'trim_whitespace' }, -- run on filetype without any formatter
    },

    formatters = { -- formatter settings
      prettierd = {
        args = { '--config', vim.env.XDG_CONFIG_HOME or (vim.fn.expand '~' .. '/.config') .. '/prettierrc.json' },
      },
      -- examples -- see :h conform-options
      -- formatterTbl = {
      --   command = 'my_cmd',
      --   args = { '--stdin-from-filename', '$FILENAME' },
      --   range_args = function(self, ctx) return { '--line-start', ctx.range.start[1], '--line-end', ctx.range['end'][1] } end,
      --   stdin = true,
      --   cwd = require('conform.util').root_file { '.editorconfig', 'package.json' },
      --   require_cwd = true,
      --   tmpfile_format = '.conform.$RANDOM.$FILENAME',
      --   condition = function(self, ctx) return vim.fs.basename(ctx.filename) ~= 'README.md' end,
      --   exit_codes = { 0, 1 },
      --   env = { VAR = 'value' },
      --   inherit = true,
      --   prepend_args = { '--use-tabs' },
      --   append_args = { '--trailing-comma' },
      -- },
      -- formatterFunc = function(bufnr)
      --   return {
      --     command = 'my_cmd',
      --   }
      -- end,
    },
  },
}
