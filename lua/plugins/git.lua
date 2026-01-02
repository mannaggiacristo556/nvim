-- Git plugins
return {
  -- Lazygit integration (full git UI in nvim)
  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
      { "<leader>gf", "<cmd>LazyGitCurrentFile<cr>", desc = "LazyGit file history" },
    },
    config = function()
      vim.g.lazygit_floating_window_scaling_factor = 0.9
      vim.g.lazygit_floating_window_border_chars = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
    end,
  },

  -- Diffview: VSCode-style diff view
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewFileHistory" },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diff view" },
      { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "File history" },
      { "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "Branch history" },
      { "<leader>gq", "<cmd>DiffviewClose<cr>", desc = "Close diff" },
    },
    config = function()
      require("diffview").setup({
        enhanced_diff_hl = true,
        view = {
          default = { layout = "diff2_horizontal" },
          merge_tool = { layout = "diff3_horizontal" },
        },
        file_panel = {
          listing_style = "tree",
          win_config = { width = 35 },
        },
      })
    end,
  },

  -- Octo: GitHub issues/PRs in nvim
  {
    "pwntester/octo.nvim",
    cmd = "Octo",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<leader>gpr", "<cmd>Octo pr list<cr>", desc = "List PRs" },
      { "<leader>gpc", "<cmd>Octo pr create<cr>", desc = "Create PR" },
      { "<leader>gis", "<cmd>Octo issue list<cr>", desc = "List issues" },
      { "<leader>gic", "<cmd>Octo issue create<cr>", desc = "Create issue" },
    },
    config = function()
      require("octo").setup({
        enable_builtin = true,
        default_to_projects_v2 = true,
        suppress_missing_scope = {
          projects_v2 = true,
        },
      })
    end,
  },

  -- Git blame inline
  {
    "f-person/git-blame.nvim",
    event = "VeryLazy",
    config = function()
      require("gitblame").setup({
        enabled = false, -- Start disabled, toggle with :GitBlameToggle
        date_format = "%r",
        message_when_not_committed = "Not committed yet",
        virtual_text_column = 80,
      })
    end,
    keys = {
      { "<leader>gb", "<cmd>GitBlameToggle<cr>", desc = "Toggle git blame" },
    },
  },
}
