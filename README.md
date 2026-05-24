# README nvim-light

A **lightweight nvim** config using as much builtin functions possible.
Great for _tty_ and other limited environments

> [!NOTE]
> Do not edit this in branches, (I am to lazy to setup config that ignores it)

## FEATURES

This a (non-complete?) list of things/features in the config:

- Uses `vim.pack` as plugin manager.
- Uses a `.vim` file for mappings and options (can be used for regular `vim`)
  - I have `ln -s` my `.vim` file to `~/.vimrc` for this reason.
- Nice collection of small QOL tweaks (_mappings_, _options_, _autocommands_)

## PLUGINS

- leap.nvim
- which-key.nvim
- mini.nvim
- nvim-lspconfig
- nvim-treesitter
- nvim-treesitter-context
- blink.cmp
- friendly-snippets
- fzf-lua

## BRANCHES

Checkout other branches as well:

- `minimal` - A really _minimal_ (lua) config (best for tty)
- `laptop` - my working branch for my laptop.

## TODO

- [x] complete [PLUGINS](#plugins) and [FEATURES](#features)
  - [ ] Also insert _URL_ for the plugins
