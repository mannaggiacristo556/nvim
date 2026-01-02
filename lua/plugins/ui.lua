-- UI plugins - theme, bufferline, etc.
return {
  -- Gruvbox theme (transparent)
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    lazy = false,
    config = function()
      require("gruvbox").setup({
        terminal_colors = true,
        undercurl = true,
        underline = true,
        bold = true,
        italic = {
          strings = true,
          emphasis = true,
          comments = true,
          operators = false,
          folds = true,
        },
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        invert_intend_guides = false,
        inverse = true,
        contrast = "hard",
        palette_overrides = {},
        overrides = {
          -- Transparent backgrounds
          Normal = { bg = "NONE" },
          NormalNC = { bg = "NONE" },
          NormalFloat = { bg = "NONE" },
          FloatBorder = { bg = "NONE" },
          SignColumn = { bg = "NONE" },
          GruvboxRedSign = { bg = "NONE" },
          GruvboxGreenSign = { bg = "NONE" },
          GruvboxYellowSign = { bg = "NONE" },
          GruvboxBlueSign = { bg = "NONE" },
          GruvboxPurpleSign = { bg = "NONE" },
          GruvboxAquaSign = { bg = "NONE" },
          GruvboxOrangeSign = { bg = "NONE" },
          NeoTreeNormal = { bg = "NONE" },
          NeoTreeNormalNC = { bg = "NONE" },
          TelescopeNormal = { bg = "NONE" },
          TelescopeBorder = { bg = "NONE" },
          WhichKeyFloat = { bg = "NONE" },
          Pmenu = { bg = "NONE" },
          PmenuSbar = { bg = "NONE" },
          -- Alpha dashboard
          AlphaHeader = { bg = "NONE" },
          AlphaButtons = { bg = "NONE" },
          AlphaFooter = { bg = "NONE" },
          AlphaShortcut = { bg = "NONE" },
          -- More UI elements
          EndOfBuffer = { bg = "NONE" },
          StatusLine = { bg = "NONE" },
          StatusLineNC = { bg = "NONE" },
          VertSplit = { bg = "NONE" },
          WinSeparator = { bg = "NONE" },
        },
        dim_inactive = false,
        transparent_mode = true,
      })
      vim.cmd.colorscheme("gruvbox")
    end,
  },

  -- Bufferline (tabs like VS Code)
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    config = function()
      require("bufferline").setup({
        options = {
          mode = "buffers",
          diagnostics = "nvim_lsp",
          offsets = {
            { filetype = "neo-tree", text = "Explorer", text_align = "center" },
          },
          show_buffer_close_icons = true,
          show_close_icon = false,
          separator_style = "thin",
        },
      })
    end,
  },

  -- Icons
  { "nvim-tree/nvim-web-devicons", lazy = true },
}
