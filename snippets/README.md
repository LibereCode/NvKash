# snippets

<!-- markdownlint-disable MD010 MD033 -->

<p>

This is for native `vim.snippet` and only works with
[blink.cmp](https://github.com/Saghen/blink.cmp) <br>
if you have:

```lua
-- standard
require('blink').setup({
	snippets = { preset = 'default' }
})

-- or lazy.nvim equivalent
return {
	'Saghen/blink.cmp',
	opts = {snippets = { preset = 'default' } } },

-- NOTE: an by this I mean 'default' AND NOT 'luasnip'
```

<p>
