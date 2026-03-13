-- markdown.md, org.org, text.txt, ...
-- For `plugins/markview.lua` users.
return {
  {
    'OXY2DEV/markview.nvim',
    lazy = false,

    -- Completion for `blink.cmp`
    dependencies = { 'saghen/blink.cmp' },

    -- | Commands    | desc                        |
    -- |-------------|-----------------------------|
    -- | Toggle      | Toggles Markview            |
    -- | Enable      | Enables   -||-              |
    -- | Disable     | Disable   -||-              |
    -- | toggle      |   -||-    -||-  for buffer  |
    -- | enable      |   -||-    -||-              |
    -- | disable     |   -||-    -||-              |
    -- | splitToggle | Dual pane = edit/preview    |
  },
}
