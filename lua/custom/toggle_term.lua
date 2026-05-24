local state = {
  floating = {
    buf = -1,
    win = -1,
  },
}

local toggle_term = function()
  if not vim.api.nvim_win_is_valid(state.floating.win) then -- if buffer isn't visible
    state.floating = require("custom.toggle_float").toggle_float({ buf = state.floating.buf }) -- tells it to use the same buffer
    if vim.bo[state.floating.buf].buftype ~= "terminal" then -- if buftype isn't terminal
      vim.cmd.terminal() -- enter terminal
    end
  else
    vim.api.nvim_win_hide(state.floating.win) -- else hide that shit
  end
  vim.cmd("startinsert")
end

vim.api.nvim_create_user_command("Termtoggle", toggle_term, {})
vim.keymap.set({ "n", "t" }, "<M-t>", "<CMD>Termtoggle<CR>")
