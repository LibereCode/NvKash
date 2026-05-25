return { --		TODO: try it for my minimal configs
  -- leap.nvim
  'andyg/leap.nvim',
  url = 'https://codeberg.org/andyg/leap.nvim.git',
  config = function()
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
        '<cr>',
        function()
          require('leap').leap {
            ['repeat'] = true,
            opts = clever('<cr>', '<bs>'),
          }
        end
      )
      vim.keymap.set(
        { 'n', 'x', 'o' },
        '<bs>',
        function()
          require('leap').leap {
            ['repeat'] = true,
            opts = clever('<bs>', '<cr>'),
            backward = true,
          }
        end
      )
    end
  end,
}
