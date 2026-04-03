# TODO

## ABOUT

Moved from plugins/ to ./, now working as a united TODO.md

## PLUGINS

### Plugins ToAdd

- Markdown
  1. [x] [mdflow](https://github.com/jakewvincent/mkdnflow.nvim)
  2. [ ] [Markmap](https://github.com/Zeioth/markmap.nvim)

#### Ponder? ToAdd?

- code
  2. [ ] [lazydev](https://github.com/folke/lazydev.nvim)
  3. [ ] [touble](https://github.com/folke/trouble.nvim)
- Notes
  1. [x] [Orgmode](https://github.com/nvim-orgmode/orgmode)
  2. [-] [Telekasten](https://github.com/nvim-telekasten/telekasten.nvim)
  3. [ ] [Venn](https://github.com/jbyuki/venn.nvim)
  4. [ ] [marp](https://github.com/mpas/marp-nvim)

### plug-conf

- [ ] zsh lsp
- [ ] tab compl
- [ ] List mappings TODO
- [x] Use imporved `toggle_float.lua` for `lazygit` (like I did for `toggle_term`)

## General conf

- [-] Move plugin specific mappings to the plugins themself
  under `config = function() ... end`
- [X] BAD IDEA: IT DISABLED `opts = {}`. Instead do:

```lua
opts = function(_, opts)
  -- any command
  return {
    -- opts
  }
```
