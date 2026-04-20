vim.keymap.set('n', '<localleader>o', function()
  local curfile = vim.fn.expand '%:p'
  local browser_open = { 'mullvad-browser', '-new-window', curfile }
  vim.fn.jobstart(browser_open, { detach = true })
end, { silent = true, desc = 'Open html in browser' })
-- TODO: Maybe add as global mapping?
