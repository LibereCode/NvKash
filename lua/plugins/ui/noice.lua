return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  dependencies = {
    { 'MunifTanjim/nui.nvim' },
  },

  -- default: https://github.com/folke/noice.nvim#%EF%B8%8F-configuration
  opts = {
    ovveride = {
      ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
      ['vim.lsp.util.stylize_markdown'] = true,
      -- ['cmp.entry.get_documentation'] = true, -- require nvim-cmp
    },
    presets = {
      bottom_search = true,
      command_palette = true,
      -- long_message_split = true,
      -- inc_rename = false,
      lsp_doc_border = false,
    },
    -- TODO: add more
  },
}
