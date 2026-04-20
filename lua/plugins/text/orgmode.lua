-- orgmode.org
--
-- 'nvim-neorg/neorg', -- I fucking hate neorg -- https://github.com/nvim-neorg/neorg
--
return { -- https://nvim-orgmode.github.io/
  'nvim-orgmode/orgmode',
  event = 'VeryLazy',
  ft = { 'org' },
  keys = { -- INFO: default: https://nvim-orgmode.github.io/configuration#mappings
    { '<leader>oh', mode = 'n', '<CMD>Org help<CR>', desc = '[h]elp' },
    { '<leader>oH', mode = 'n', '<CMD>Org helpgrep<CR>', desc = '[H]elpgrep' },
  },
  opts = {
    -- Setup orgmode
    org_agenda_files = '~/Notes/Org/**/*',
    org_default_notes_file = '~/Notes/Org/refile.org',
  },
}
