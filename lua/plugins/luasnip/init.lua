return { -- INFO: also inconfig/blink.lua#dependencies
  'L3MON4D3/LuaSnip',
  opts = function(_, opts)
    -- NOTE: MODULERIZE SNIPPETS LIKE THIS (per filetype)
    local ftsnippets = {
      'all',
      'lua',
      'zig',
    }
    for _, ft in ipairs(ftsnippets) do
      require('plugins.luasnip.' .. ft)
    end

    local ls = require 'luasnip'

    -- INFO: MAPPINGS
    local snipmap = function(key, cmd, mapOpts, mode)
      mapOpts = vim.tbl_extend('error', mapOpts or {}, { noremap = true, silent = true })
      mode = mode or { 'i', 's' }
      vim.keymap.set(mode, key, cmd, mapOpts)
    end
    snipmap('<M-e>', function() ls.expand() end, {}, 'i') --[['<C-l'>]]
    snipmap('<M-n>', function() ls.jump(1) end) --[['<C-k'>]]
    snipmap('<M-p>', function() ls.jump(-1) end) --[['<C-j>']]
    snipmap('<M-c>', function() -- What is this? Change-active-choice? --[['<C-e>']]
      if ls.choice_active() then ls.change_choice(1) end
    end)

    -- NOTE: tip: https://github.com/L3MON4D3/LuaSnip/wiki/Nice-Configs#jump-intoselect-node-under-the-cursor
    local select_next = false
    vim.keymap.set({ 'i' }, '<C-;>', function()
      -- the meat of this mapping: call ls.activate_node.
      -- strict makes it so there is no fallback to activating any node in the
      -- snippet, and select controls whether the text associated with the node is
      -- selected.
      local ok, _ = pcall(ls.activate_node, {
        strict = true,
        -- select_next is initially unset, but set within the first second after
        -- activating the mapping, so activating it again in that timeframe will
        -- select the text of the found node.
        select = select_next,
      })
      -- ls.activate_node throws on failure.
      if not ok then
        print 'No node.'
        return
      end
      -- once the node is activated, we are either done (if text is SELECTed), or
      -- we briefly highlight the text associated with the node so one can know
      -- which node was activated.
      -- TODO: this highlighting does not show up if the node has no text
      -- associated (ie ${1:asdf} vs $1), a cool extension would be to also show
      -- something if there was no text.
      if select_next then return end
      --
      local curbuf = vim.api.nvim_get_current_buf()
      local hl_duration_ms = 234
      local node = ls.session.current_nodes[curbuf]
      -- get node-position, raw means we want byte-columns, since those are what
      -- nvim_buf_set_extmark expects.
      local from, to = node:get_buf_position { raw = true }
      -- highlight snippet for 1000ms
      local id = vim.api.nvim_buf_set_extmark(curbuf, ls.session.ns_id, from[1], from[2], {
        -- one line below, at col 0 => entire last line is highlighted.
        end_row = to[1],
        end_col = to[2],
        hl_group = 'Visual',
      })
      -- disable highlight by removing the extmark after a short wait.
      vim.defer_fn(function() vim.api.nvim_buf_del_extmark(curbuf, ls.session.ns_id, id) end, hl_duration_ms)
      -- set select_next for the next second.
      select_next = true
      vim.uv.new_timer():start(1000, 0, function() select_next = false end)
    end)

    return vim.tbl_extend('force', opts, {})
  end,
}
