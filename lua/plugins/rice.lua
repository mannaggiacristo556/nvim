-- Extra rice for nvim (aesthetic & QoL)
return {
  -- Which-key for keybind discovery
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("which-key").setup({
        preset = "helix",
        delay = 300,
        icons = {
          breadcrumb = "»",
          separator = "➜",
          group = "+",
        },
      })
    end,
  },

  -- Noice: Fancy cmdline, messages, popups
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require("noice").setup({
        lsp = {
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
          hover = { enabled = true },
          signature = { enabled = true },
        },
        presets = {
          bottom_search = true,
          command_palette = true,
          long_message_to_split = true,
          inc_rename = true,
          lsp_doc_border = true,
        },
        views = {
          cmdline_popup = {
            border = { style = "rounded" },
          },
        },
      })
    end,
  },

  -- Lualine: Better statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    config = function()
      require("lualine").setup({
        options = {
          theme = "gruvbox",
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          globalstatus = true,
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = { { "filename", path = 1 } },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        extensions = { "neo-tree", "lazy", "toggleterm", "trouble" },
      })
    end,
  },

  -- Dressing: Better vim.ui.select/input
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    config = function()
      require("dressing").setup({
        input = {
          enabled = true,
          border = "rounded",
          prefer_width = 40,
          win_options = { winblend = 0 },
        },
        select = {
          enabled = true,
          backend = { "telescope", "builtin" },
          builtin = { border = "rounded" },
        },
      })
    end,
  },

  -- Smear cursor: Cursor trail animation (very trans coded uwu)
  {
    "sphamba/smear-cursor.nvim",
    event = "VeryLazy",
    config = function()
      require("smear_cursor").setup({
        stiffness = 0.8,
        trailing_stiffness = 0.5,
        distance_stop_animating = 0.5,
        hide_target_hack = false,
      })
    end,
  },

  -- Mini.animate: Smooth animations
  {
    "echasnovski/mini.animate",
    event = "VeryLazy",
    config = function()
      require("mini.animate").setup({
        cursor = { enable = false }, -- Using smear-cursor instead
        scroll = { enable = false }, -- Disabled - was causing slow scrolling
        resize = { enable = true },
        open = { enable = true },
        close = { enable = true },
      })
    end,
  },

  -- Indent guides
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("ibl").setup({
        indent = { char = "│", tab_char = "│" },
        scope = { enabled = true, show_start = false, show_end = false },
        exclude = { filetypes = { "help", "lazy", "mason", "neo-tree", "oil", "alpha" } },
      })
    end,
  },

  -- Better notifications
  {
    "rcarriga/nvim-notify",
    lazy = true,
    config = function()
      require("notify").setup({
        background_colour = "#000000",
        fps = 60,
        render = "compact",
        stages = "fade",
        timeout = 2000,
        top_down = false,
      })
      vim.notify = require("notify")
    end,
  },

  -- Dashboard with sleepyhead cat
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      -- Sleepyhead cat ASCII art
      dashboard.section.header.val = {
        "",
        "      |\\      _,,,---,,_            ",
        "ZZZzz /,`.-'`'    -.  ;-;;,_        ",
        "     |,4-  ) )-,_. ,\\ (  `'-'       ",
        "    '---''(_/--'  `-'\\_)  Felix Lee ",
        "",
      }

      dashboard.section.buttons.val = {
        dashboard.button("f", "  Find file", ":Telescope find_files<CR>"),
        dashboard.button("r", "  Recent files", ":Telescope oldfiles<CR>"),
        dashboard.button("g", "  Grep text", ":Telescope live_grep<CR>"),
        dashboard.button("p", "  Personal plan", ":edit ~/vault/personal/plan.md<CR>"),
        dashboard.button("w", "  Work plan", ":edit ~/vault/work/plan.md<CR>"),
        dashboard.button("c", "  Config", ":edit ~/.config/nvim/<CR>"),
        dashboard.button("l", "  Lazy", ":Lazy<CR>"),
        dashboard.button("q", "  Quit", ":qa<CR>"),
      }

      dashboard.section.footer.val = "~ phases are temporary ~"

      dashboard.section.header.opts.hl = "AlphaHeader"
      dashboard.section.buttons.opts.hl = "AlphaButtons"
      dashboard.section.footer.opts.hl = "AlphaFooter"

      -- Force transparent background on alpha
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "alpha",
        callback = function()
          vim.cmd("highlight Normal guibg=NONE ctermbg=NONE")
          vim.cmd("highlight NormalNC guibg=NONE ctermbg=NONE")
          vim.cmd("highlight NormalFloat guibg=NONE ctermbg=NONE")
          vim.cmd("highlight EndOfBuffer guibg=NONE ctermbg=NONE")
        end,
      })

      alpha.setup(dashboard.config)
    end,
  },

  -- Rainbow delimiters
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("rainbow-delimiters.setup").setup({})
    end,
  },

  -- Todo comments highlighting
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("todo-comments").setup({
        signs = true,
        keywords = {
          FIX = { icon = " ", color = "error" },
          TODO = { icon = " ", color = "info" },
          HACK = { icon = " ", color = "warning" },
          WARN = { icon = " ", color = "warning" },
          PERF = { icon = " ", color = "default" },
          NOTE = { icon = " ", color = "hint" },
        },
      })
    end,
  },

  -- Color previews
  {
    "norcalli/nvim-colorizer.lua",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("colorizer").setup({
        "*",
        css = { css = true },
        html = { css = true },
      })
    end,
  },

  -- Smooth scrolling (disabled cursor, using smear instead)
  {
    "karb94/neoscroll.nvim",
    enabled = false, -- Using mini.animate instead
  },

  -- Twilight: Dims inactive code for focus
  {
    "folke/twilight.nvim",
    cmd = { "Twilight", "TwilightEnable", "TwilightDisable" },
    keys = {
      { "<leader>tw", "<cmd>Twilight<cr>", desc = "Toggle Twilight" },
    },
    opts = {
      dimming = { alpha = 0.25 },
      context = 10,
      treesitter = true,
    },
  },

  -- Duck: A duck that walks across your screen
  {
    "tamton-aquib/duck.nvim",
    keys = {
      { "<leader>dd", function() require("duck").hatch("🦆") end, desc = "Hatch a duck" },
      { "<leader>dk", function() require("duck").cook() end, desc = "Cook the duck" },
      { "<leader>da", function() require("duck").cook_all() end, desc = "Cook all ducks" },
      { "<leader>dc", function() require("duck").hatch("🐱") end, desc = "Hatch a cat" },
    },
  },

  -- Drop: Screensaver with falling characters
  {
    "folke/drop.nvim",
    event = "VimEnter",
    opts = {
      theme = "stars",
      max = 40,
      interval = 150,
      screensaver = 1000 * 60 * 5, -- 5 minutes
      filetypes = { "alpha" },
    },
  },

  -- Cellular Automaton: Make your code rain
  {
    "eandrju/cellular-automaton.nvim",
    cmd = "CellularAutomaton",
    keys = {
      { "<leader>fml", "<cmd>CellularAutomaton make_it_rain<cr>", desc = "Make it rain" },
      { "<leader>fmg", "<cmd>CellularAutomaton game_of_life<cr>", desc = "Game of Life" },
    },
  },

  -- Zone: Screensaver for neovim
  {
    "tamton-aquib/zone.nvim",
    cmd = "Zone",
    keys = {
      { "<leader>fz", "<cmd>Zone<cr>", desc = "Screensaver" },
    },
    opts = {
      style = "dvd",
      after = 300, -- 5 minutes idle
      exclude_filetypes = { "TelescopePrompt", "neo-tree", "oil", "alpha", "lazy" },
      dvd = { tick_time = 100 },
    },
  },

  -- Tiny glimmer: Yank/paste animations
  {
    "rachartier/tiny-glimmer.nvim",
    event = "VeryLazy",
    opts = {
      enabled = true,
      timeout = 300,
      default_animation = "fade",
      animations = {
        fade = { duration = 300 },
      },
    },
  },
}
