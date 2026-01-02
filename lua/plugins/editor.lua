-- Editor enhancements
return {
  -- File explorer (like VS Code sidebar)
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup({
        close_if_last_window = true,
        sources = {
          "filesystem",
          "buffers",
          "git_status",
          "distant", -- Custom distant source
        },
        window = {
          width = 30,
          mappings = {
            ["<space>"] = "none", -- Don't conflict with leader
          },
        },
        filesystem = {
          bind_to_cwd = true,
          cwd_target = {
            sidebar = "window",
            current = "window",
          },
          follow_current_file = { enabled = true },
          filtered_items = {
            hide_dotfiles = false,
            hide_gitignored = false,
          },
          hijack_netrw_behavior = "open_current",
        },
        distant = {
          window = {
            mappings = {
              ["<cr>"] = "open",
              ["o"] = "open",
              ["<2-LeftMouse>"] = "open",
              ["s"] = "open_split",
              ["v"] = "open_vsplit",
              ["R"] = "refresh",
              ["u"] = "navigate_up",
              ["."] = "set_root",
              ["H"] = "toggle_hidden",
              ["<bs>"] = "close_node",
              ["q"] = "close_window",
              ["?"] = "show_help",
            },
          },
        },
      })
    end,
  },

  -- Oil (edit filesystem like a buffer)
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("oil").setup({
        view_options = { show_hidden = true },
        keymaps = {
          ["<C-h>"] = false, -- Don't override window nav
          ["<C-l>"] = false,
        },
      })
    end,
  },

  -- Terminal
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = 15,
        open_mapping = [[<C-`>]],
        direction = "horizontal",
        shade_terminals = true,
      })
    end,
  },

  -- Autopairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },

  -- Comment
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = true,
  },

  -- Surround
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = true,
  },

  -- Git signs
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "│" },
          change = { text = "│" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
        },
      })
    end,
  },

  -- Better markdown with custom todo states
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    ft = { "markdown" },
    config = function()
      require("render-markdown").setup({
        enabled = true,
        render_modes = { "n", "v", "i", "c" },
        checkbox = {
          enabled = true,
          unchecked = {
            icon = "󰄱 ",
            highlight = "RenderMarkdownUnchecked",
          },
          checked = {
            icon = "󰄵 ",
            highlight = "RenderMarkdownChecked",
          },
          custom = {
            -- [@] doing/active - spinning arrow
            doing = { raw = "[@]", rendered = "󱥸 ", highlight = "RenderMarkdownDoing" },
            -- [s] started - play button
            started = { raw = "[s]", rendered = "󰐊 ", highlight = "RenderMarkdownStarted" },
            -- [d] deferred - pause
            deferred = { raw = "[d]", rendered = "󰏤 ", highlight = "RenderMarkdownDeferred" },
            -- [b] blocked - stop/cancel
            blocked = { raw = "[b]", rendered = "󰜺 ", highlight = "RenderMarkdownBlocked" },
            -- [!] priority/important - fire
            priority = { raw = "[!]", rendered = "󰈸 ", highlight = "RenderMarkdownPriority" },
            -- [?] question/unsure
            question = { raw = "[?]", rendered = "󰘥 ", highlight = "RenderMarkdownQuestion" },
          },
        },
        bullet = {
          enabled = true,
          icons = { "•", "◦", "▪", "▫" },
        },
      })
      -- Set highlight colors (catppuccin mocha palette)
      vim.api.nvim_set_hl(0, "RenderMarkdownUnchecked", { fg = "#89b4fa" })  -- blue
      vim.api.nvim_set_hl(0, "RenderMarkdownChecked", { fg = "#a6e3a1" })    -- green
      vim.api.nvim_set_hl(0, "RenderMarkdownDoing", { fg = "#fab387" })      -- peach/orange
      vim.api.nvim_set_hl(0, "RenderMarkdownStarted", { fg = "#74c7ec" })    -- sapphire
      vim.api.nvim_set_hl(0, "RenderMarkdownDeferred", { fg = "#6c7086" })   -- overlay0/gray
      vim.api.nvim_set_hl(0, "RenderMarkdownBlocked", { fg = "#f38ba8" })    -- red
      vim.api.nvim_set_hl(0, "RenderMarkdownPriority", { fg = "#f9e2af" })   -- yellow
      vim.api.nvim_set_hl(0, "RenderMarkdownQuestion", { fg = "#cba6f7" })   -- mauve
    end,
  },
}
