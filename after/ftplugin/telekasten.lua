local function map(key, telecmd, mapOpts, mode) --
  mapOpts = vim.tbl_extend('error', mapOpts or {}, { buf = 0 })
  vim.keymap.set(mode or 'n', key, telecmd, mapOpts)
end

map('<leader>zz', '<cmd>Telekasten follow_link<CR>')
-- map('<leader>zb', '<cmd>Telekasten show_backlinks<CR>')
map('<leader>zl', '<cmd>Telekasten follow_link<CR>')
map('<leader>zi', '<cmd>Telekasten insert_link<CR>')
map('<leader>zI', '<cmd>Telekasten insert_img_link<CR>')
map('<leader>zt', '<cmd>Telekasten toggle_todo<CR>')

map('[[', '<cmd>Telekasten insert_link<CR>', {}, 'i')
