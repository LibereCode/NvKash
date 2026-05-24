return { -- change some telescope options and a keymap to browse plugin files
  "nvim-telescope/telescope.nvim",
  keys = function() -- so I can micro-manage (most are default)
    -- add a keymap to browse plugin files
    return {
      -- stylua: ignore start
      { "<leader>ft", "<CMD>Telescope<CR>", desc = "[t]elescope.builtins"},
      { "<leader>ss", "<CMD>Telescope<CR>", desc = "[s]elect Telescope"},

      { "<leader>,", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "Switch Buffer" }, -- TODO: in >b
      { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
      { "<leader><space>", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
      { "<leader>uC", LazyVim.pick("colorscheme", { enable_preview = true }), desc = "Colorscheme with Preview" },

      { "<leader><leader>", LazyVim.pick("live_grep"), desc = "live[ ]grep" },
      { "C-/", function()
          require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
            winblend = 10, previewer = false, }))
      end, desc = "Fzf [/] current buf" },
      { "<leader>/", function()
          require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
            winblend = 10, previewer = true, }))
        end, desc = "Fzf [/] current buf" },

      -- find (files and similar)
      { "<leader>fb", "<cmd>Telescope buffers sort_mru=true sort_lastused=true ignore_current_buffer=true<cr>", desc = "Buffers" },
      { "<leader>fB", "<cmd>Telescope buffers<cr>", desc = "Buffers (all)" },
      { "<leader>fc", LazyVim.pick.config_files(), desc = "Find Config File" },
      { "<leader>ff", LazyVim.pick("files", { root = false }), desc = "files(cwd)" },
      { "<leader>fF", LazyVim.pick("files"), desc = "Files" },
      { "<leader>fg", "<cmd>Telescope git_files<cr>", desc = "Find Files (git-files)" }, -- TODO: in >g
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "help" },
      { "<leader>fm", "<cmd>Telescope man_pages<cr>", desc = "men (pages)" },
      { "<leader>fp", function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end, desc = "Find Plugin File" },
      { "<leader>fr", LazyVim.pick("oldfiles", { cwd = vim.uv.cwd() }), desc = "recent(cwd)" },
      { "<leader>fR", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
      { '<leader>f"', "<cmd>Telescope registers<cr>", desc = '"registers' },
      { "<leader>f:", "<cmd>Telescope commands<cr>", desc = ":commands" },

      -- git
      { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "Commits" },
      { "<leader>gl", "<cmd>Telescope git_commits<CR>", desc = "Commits" },
      { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "Status" },
      { "<leader>gS", "<cmd>Telescope git_stash<cr>", desc = "Git Stash" },

      -- search (grep text)
      { "<leader>s/", "<cmd>Telescope search_history<cr>", desc = "Search History" },
      { "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "autocmd" },
      { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer Lines" },
      { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "diagnostics(buffer)" },
      { "<leader>sD", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
      { "<leader>sg", LazyVim.pick("live_grep", { root = false }), desc = "live grep(cwd)" },
      { "<leader>sG", LazyVim.pick("live_grep"), desc = "live grep" },
      { "<leader>sh", "<cmd>Telescope highlights<cr>", desc = "highlight Groups" },
      { "<leader>sj", "<cmd>Telescope jumplist<cr>", desc = "jumplist(C-o)" },
      { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "key-maps" },
      { "<leader>sl", "<cmd>Telescope loclist<cr>", desc = "Location List" },
      { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "marks" },
      { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "options" },
      { "<leader>sr", "<cmd>Telescope resume<cr>", desc = "resume" },
      { "<leader>sq", "<cmd>Telescope quickfix<cr>", desc = "quickfix List" },
      { "<leader>sw", LazyVim.pick("grep_string", { root = false, word_match = "-w" }), desc = "word(cwd)" },
      { "<leader>sW", LazyVim.pick("grep_string", { word_match = "-w" }), desc = "Word" },
      { "<leader>sw", LazyVim.pick("grep_string", { root = false }), mode = "x", desc = "selection(cwd)" },
      { "<leader>sW", LazyVim.pick("grep_string"), mode = "x", desc = "selection" },
      { "<leader>sy", function() require("telescope.builtin").lsp_document_symbols({ symbols = LazyVim.config.get_kind_filter(), }) end, desc = "s[y]mbol" },
      { "<leader>sY", function() require("telescope.builtin").lsp_dynamic_workspace_symbols({ symbols = LazyVim.config.get_kind_filter(), }) end, desc = "S[Y]MBOL(Workspace)" },

      -- stylua: ignore end
    }
  end,
  -- change some options?
  opts = function() -- HACK: copied over default, so I can micro-manage
    local actions = require("telescope.actions")

    local open_with_trouble = function(...)
      return require("trouble.sources.telescope").open(...)
    end
    local find_files_no_ignore = function()
      local action_state = require("telescope.actions.state")
      local line = action_state.get_current_line()
      LazyVim.pick("find_files", { no_ignore = true, default_text = line })()
    end
    local find_files_with_hidden = function()
      local action_state = require("telescope.actions.state")
      local line = action_state.get_current_line()
      LazyVim.pick("find_files", { hidden = true, default_text = line })()
    end

    local function find_command()
      if 1 == vim.fn.executable("rg") then
        return { "rg", "--files", "--color", "never", "-g", "!.git", "-." } -- added "-." so I see hidden
      elseif 1 == vim.fn.executable("fd") then
        return { "fd", "--type", "f", "--color", "never", "-E", ".git", "-H" } -- added "-H" = hidden
      elseif 1 == vim.fn.executable("fdfind") then
        return { "fdfind", "--type", "f", "--color", "never", "-E", ".git" }
      elseif 1 == vim.fn.executable("find") and vim.fn.has("win32") == 0 then
        return { "find", ".", "-type", "f" }
      elseif 1 == vim.fn.executable("where") then -- where... is the precense of someself who gives a turd
        return { "where", "/r", ".", "*" }
      end
    end

    return {
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        -- open files in the first window that is an actual file.
        -- use the current window if no other window is available.
        get_selection_window = function()
          local wins = vim.api.nvim_list_wins()
          table.insert(wins, 1, vim.api.nvim_get_current_win())
          for _, win in ipairs(wins) do
            local buf = vim.api.nvim_win_get_buf(win)
            if vim.bo[buf].buftype == "" then
              return win
            end
          end
          return 0
        end,

        mappings = {
          i = {
            ["<c-t>"] = open_with_trouble,
            ["<a-t>"] = open_with_trouble,
            ["<a-i>"] = find_files_no_ignore,
            ["<a-h>"] = find_files_with_hidden,
            ["<C-Down>"] = actions.cycle_history_next,
            ["<C-Up>"] = actions.cycle_history_prev,
            ["<C-f>"] = actions.preview_scrolling_down,
            ["<C-b>"] = actions.preview_scrolling_up,
            -- ["<C-u>"] = false,
            -- ["<M-p>"] = actions.layout.toggle_preview, -- gave error D:
          },
          n = {
            ["q"] = actions.close,
            -- ["<M-p>"] = actions.layout.toggle_preview,
          },
        },
      },

      pickers = {
        find_files = {
          find_command = find_command,
          hidden = true,
        },
      },
    }
  end,
}
