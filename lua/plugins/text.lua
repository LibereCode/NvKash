return { -- "plaintext", like .txt, .md, .org
  -- Markdown.md
  {
    "jakewvincent/mkdnflow.nvim",
    ft = { "markdown", "rmd" },
    opts = {},
    keys = function() -- replace with new table of mappings
      local function mmap(keys, cmd, desc)
        return { keys, cmd, ft = "markdown", desc = desc }
      end
      return {
        mmap("<leader>ml", "<Cmd>MkdnFollowLink<CR>", "Follow link"),
        mmap("<CR>", "<Cmd>MkdnEnter<CR>", "Mkdn enter"),
        mmap("<leader>my", "", "yank"),
        mmap("<leader>mya", "<Cmd>MkdnYankAnchorLink<CR>", "Yank Anchorlink"),
        mmap("<leader>myf", "<Cmd>MkdnYankFileAnchorLink<CR>", "Yank FileAnchorlink"),
        mmap("<leader>mt", "<Cmd>MkdnToggleToDo<CR>", "Toggle TODO"),
        mmap("<leader>mn", "<Cmd>MkdnUpdateNumbering<CR>", "Update Numbering"),
        mmap("<leader>mi", "", "insert table"),
        mmap("<leader>mir", "<Cmd>MkdnTableNewRowBelow<CR>", "Table new Row Down"),
        mmap("<leader>miR", "<Cmd>MkdnTableNewRowAbove<CR>", "Table new Row Up"),
        mmap("<leader>mic", "<Cmd>MkdnTableNewColAfter<CR>", "Table new Column Right"),
        mmap("<leader>miC", "<Cmd>MkdnTableNewColBefore<CR>", "Table new Column Left"),
        mmap("<leader>md", "", "table delete..."),
        mmap("<leader>mdr", "<Cmd>MkdnTableDeleteRow<CR>", "Table Delete Row"),
        mmap("<leader>mdc", "<Cmd>MkdnTableDeleteCol<CR>", "Table Delete Column"),
        mmap("<leader>mf", "<Cmd>MkdnFoldSection<CR>", "md Fold"),
        mmap("<leader>mF", "<Cmd>MkdnUnfoldSection<CR>", "md UnFold"),
        mmap("<leader>mL", "<Cmd>MkdnCreateLinkFromClipboard<CR>", "Create [L]ink Clipboard"),
      }
    end,
  },

  -- INFO: markdownlint-cli2 (linter for markdown) can be in-document-config,
  -- ex: -- <!-- markdownlint-disable{-position-rules} {specific-rule} -->
  --
  -- THESE DO THE SAME:
  -- 1.
  -- <!-- markdownlint-disable-next-line no-space-in-emphasis -->
  -- space * in * emphasis
  -- 2.
  -- space * in * emphasis <!-- markdownlint-disable-line no-space-in-emphasis -->
  -- 3.
  -- <!-- markdownlint-disable no-space-in-emphasis -->
  -- space * in * emphasis
  -- <!-- markdownlint-enable no-space-in-emphasis -->

  { -- INFO: pretty goated, ngl. For now better than `Markview.nvim`. (btw, is in LazyExtras-markdown)
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
      { "nvimtools/none-ls.nvim", enabled = false },
    },
    ft = {},
    keys = {
      {
        "<leader>ms",
        "<cmd>RenderMarkdown preview<cr>",
        desc = "[s]plit-preview",
      },
    },
    opts = {
      code = {
        sign = true,
        width = "block",
        right_pad = 1,
      },
      heading = {
        sign = true,
        icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
      },
      checkbox = {
        enabled = true,
      },
    },
  },

  { -- previews on web-browser
    "iamcco/markdown-preview.nvim",
    keys = function()
      return {
        {
          "<localleader>p",
          ft = "markdown",
          "<cmd>MarkdownPreviewToggle<cr>",
          desc = "Markdown Preview",
        },
        {
          "<leader>mp",
          ft = "markdown",
          "<cmd>MarkdownPreviewToggle<cr>",
          desc = "Preview",
        },
      }
    end,
  },

  -- orgmode.org -- NOTE: would rather just use markdown, not gonna ngl
  {
    "nvim-orgmode/orgmode",
    event = "VeryLazy",
    ft = { "org" },
    keys = {
      { "<leader>oh", mode = "n", "<CMD>Org help<CR>", desc = "help" },
    },
    opts = {
      -- Setup orgmode
      org_agenda_files = "~/Notes/Org/**/*",
      org_default_notes_file = "~/Notes/Org/refile.org",
    },
  },
  --
  -- {
  --   "nvim-neorg/neorg",
  --   -- lazy-load on filetype
  --   ft = "norg",
  --   -- options for neorg. This will automatically call `require("neorg").setup(opts)`
  --   opts = {
  --     load = {
  --       ["core.defaults"] = {},
  --     },
  --   },
  -- },
}
