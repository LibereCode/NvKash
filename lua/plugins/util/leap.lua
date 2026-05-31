-- XXX: Sorry, but too much config.
-- flash.nvim is just better...
return {
  -- leap.nvim 🦘🦘🦘
  'andyg/leap.nvim',
  url = 'https://codeberg.org/andyg/leap.nvim.git',
  config = function()
    vim.keymap.set({ 'n', 'x', 'o' }, 's', '<Plug>(leap)')
    vim.keymap.set('n', 'S', '<Plug>(leap-from-window)')

    -- E.g., `gs{leap}$y` or `ygs{leap}$`, where {leap}, as usual, means
    -- {char1}{char2}{label?}. The linewise version can also take [count],
    -- e.g. `d2gs{leap}` deletes two lines.
    vim.keymap.set({ 'n', 'o' }, 'gl', '<plug>(leap-remote)') -- 'gs' 'gz' 'gl'
    vim.keymap.set({ 'n', 'o' }, 'gL', '<Plug>(leap-remote-linewise)') -- 'gS' 'gZ' 'gL'
    -- Useful shortcut for a frequent operation: the same as remote-linewise,
    -- except it auto-triggers even without [count] (`yrr{leap}` copies a line).
    vim.keymap.set({ 'o' }, 'rr', '<Plug>(leap-remote-line)')
    -- These commands expect another chjracter as input before leaping, and
    -- select the given text object at the destination (`yarp{leap}`).
    vim.keymap.set({ 'x', 'o' }, 'ar', '<Plug>(leap-remote-text-object)')
    vim.keymap.set({ 'x', 'o' }, 'ir', '<Plug>(leap-remote-inner-text-object)')

    vim.keymap.set({ 'x', 'o' }, 'an', function()
      require('leap.treesitter').select {
        -- To increase/decrease the selection in a clever-f-like manner,
        -- with the trigger key itself (vannnNN...). The default keys
        -- (<enter>/<backspace>) also work, so feel free to skip this.
        opts = require('leap.user').with_traversal_keys('n', 'N'),
      }
    end)

    -- Set automatic paste after yanking:
    vim.api.nvim_create_autocmd('User', {
      pattern = 'RemoteOperationDone',
      group = vim.api.nvim_create_augroup('LeapRemote', {}),
      callback = function(event)
        if vim.v.operator == 'y' and event.data.register == '"' then vim.cmd 'normal! p' end
      end,
    })

    -- Highly recommended: define a preview filter to reduce visual noise
    -- and the blinking effect after the first keypress.
    -- For example, define word boundaries as the common case, that is, skip
    -- preview for matches starting with whitespace or an alphabetic
    -- mid-word character: foobar[baaz] = quux
    --                     *    ***  ** * *  *
    require('leap').opts.preview = function(ch0, ch1, ch2) return not (ch1:match '%s' or (ch0:match '%a' and ch1:match '%a' and ch2:match '%a')) end

    -- Enable the traversal keys to repeat the previous search without
    -- explicitly invoking Leap (`<cr><cr>...` instead of `s<cr><cr>...`):
    do
      local clever = require('leap.user').with_traversal_keys
      -- For relative directions, set the `backward` flags according to:
      -- local prev_backward = require('leap').state['repeat'].backward
      vim.keymap.set(
        { 'n', 'x', 'o' },
        ';', -- '<cr>', -- TEST:
        function()
          require('leap').leap {
            ['repeat'] = true,
            opts = clever('<cr>', '<bs>'),
          }
        end
      )
      vim.keymap.set(
        { 'n', 'x', 'o' },
        ',', -- '<bs>', -- TEST:
        function()
          require('leap').leap {
            ['repeat'] = true,
            opts = clever('<bs>', '<cr>'),
            backward = true,
          }
        end
      )
    end

    -- search and motion -- https://codeberg.org/andyg/leap.nvim#search-and-motions

    -- enchanched f/F/t/T
    do
      local function ft(key_specific_args)
        require('leap').leap(vim.tbl_deep_extend('keep', key_specific_args, {
          inputlen = 1,
          inclusive = true,
          opts = {
            -- Force autojump.
            labels = '',
            -- Match the modes where you don't need labels (`:h mode()`).
            safe_labels = vim.fn.mode(1):match 'o' and '' or nil,
          },
        }))
      end

      -- A helper function making it easier to set "clever-f" behavior
      -- (using f/F or t/T instead of ;/, - see the plugin clever-f.vim).
      local clever = require('leap.user').with_traversal_keys
      local clever_f, clever_t = clever('f', 'F'), clever('t', 'T')

      vim.keymap.set({ 'n', 'x', 'o' }, 'f', function() ft { opts = clever_f } end)
      vim.keymap.set({ 'n', 'x', 'o' }, 'F', function() ft { backward = true, opts = clever_f } end)
      vim.keymap.set({ 'n', 'x', 'o' }, 't', function() ft { offset = -1, opts = clever_t } end)
      vim.keymap.set({ 'n', 'x', 'o' }, 'T', function() ft { backward = true, offset = 1, opts = clever_t } end)
    end

    -- clever s ( a la sneak)
    do
      local clever_s = require('leap.user').with_traversal_keys('s', 'S')
      vim.keymap.set({ 'n', 'x', 'o' }, 's', function() require('leap').leap { opts = clever_s } end)
      vim.keymap.set({ 'n', 'x', 'o' }, 'S', function() require('leap').leap { backward = true, opts = clever_s } end)
    end

    -- Labels and HL -- https://codeberg.org/andyg/leap.nvim#labels-and-highlighting

    -- always show labels at beginning

    -- `on_beacons` hooks into `beacons.light_up_beacons`, the function
    -- responsible for displaying stuff.
    require('leap').opts.on_beacons = function(targets, _, _)
      for _, t in ipairs(targets) do
        -- Overwrite the `offset` value in all beacons.
        -- target.beacon looks like: { <offset>, <extmark_opts> }
        if t.label and t.beacon then t.beacon[1] = 0 end
      end
    end
  end,
}
