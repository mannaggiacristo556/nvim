-- Productivity plugins
return {
  -- Flash: Better navigation/jumping
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      modes = {
        char = { enabled = true },
        search = { enabled = false },
      },
    },
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },

  -- Harpoon: Quick file switching
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")
      harpoon:setup({
        settings = {
          save_on_toggle = true,
          sync_on_ui_close = true,
        },
      })

      -- Keymaps
      vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end, { desc = "Harpoon add file" })
      vim.keymap.set("n", "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon menu" })
      vim.keymap.set("n", "<leader>h1", function() harpoon:list():select(1) end, { desc = "Harpoon file 1" })
      vim.keymap.set("n", "<leader>h2", function() harpoon:list():select(2) end, { desc = "Harpoon file 2" })
      vim.keymap.set("n", "<leader>h3", function() harpoon:list():select(3) end, { desc = "Harpoon file 3" })
      vim.keymap.set("n", "<leader>h4", function() harpoon:list():select(4) end, { desc = "Harpoon file 4" })
      vim.keymap.set("n", "<leader>hp", function() harpoon:list():prev() end, { desc = "Harpoon prev" })
      vim.keymap.set("n", "<leader>hn", function() harpoon:list():next() end, { desc = "Harpoon next" })
    end,
  },

  -- Spectre: Search and replace across files
  {
    "nvim-pack/nvim-spectre",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Spectre",
    keys = {
      { "<leader>sr", function() require("spectre").open() end, desc = "Search & replace" },
      { "<leader>sw", function() require("spectre").open_visual({ select_word = true }) end, desc = "Search word" },
      { "<leader>sf", function() require("spectre").open_file_search({ select_word = true }) end, desc = "Search in file" },
    },
    config = function()
      require("spectre").setup({
        open_cmd = "vnew",
        live_update = true,
      })
    end,
  },

  -- Persistence: Session management
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    config = function()
      require("persistence").setup({
        dir = vim.fn.stdpath("state") .. "/sessions/",
        options = { "buffers", "curdir", "tabpages", "winsize" },
      })

      -- Keymaps
      vim.keymap.set("n", "<leader>qs", function() require("persistence").load() end, { desc = "Restore session" })
      vim.keymap.set("n", "<leader>ql", function() require("persistence").load({ last = true }) end, { desc = "Restore last session" })
      vim.keymap.set("n", "<leader>qd", function() require("persistence").stop() end, { desc = "Don't save session" })
    end,
  },

  -- Snacks: Collection of QoL plugins by folke
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      -- Animations (we use mini.animate and smear-cursor instead)
      animate = { enabled = false },
      -- Big file handling (disable slow features for big files)
      bigfile = { enabled = true },
      -- Dashboard (we use alpha instead)
      dashboard = { enabled = false },
      -- Indent guides (we use indent-blankline)
      indent = { enabled = false },
      -- Input (we use dressing)
      input = { enabled = false },
      -- Notifier (we use nvim-notify)
      notifier = { enabled = false },
      -- Quick file access
      quickfile = { enabled = true },
      -- Scope detection
      scope = { enabled = true },
      -- Scroll animations (we use mini.animate)
      scroll = { enabled = false },
      -- Statuscolumn
      statuscolumn = { enabled = true },
      -- Words under cursor highlighting
      words = { enabled = true },
      -- Zen mode
      zen = { enabled = true },
      -- Git integration
      lazygit = { enabled = true },
      -- Terminal
      terminal = { enabled = true },
      -- Scratch buffers
      scratch = { enabled = true },
    },
    keys = {
      { "<leader>z", function() Snacks.zen() end, desc = "Zen mode" },
      { "<leader>Z", function() Snacks.zen.zoom() end, desc = "Zoom" },
      { "<leader>.", function() Snacks.scratch() end, desc = "Scratch buffer" },
      { "<leader>S", function() Snacks.scratch.select() end, desc = "Select scratch" },
      { "<leader>n", function() Snacks.notifier.show_history() end, desc = "Notification history" },
      { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete buffer" },
      { "<leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename file" },
      { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git browse" },
      { "]]", function() Snacks.words.jump(vim.v.count1) end, desc = "Next reference" },
      { "[[", function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev reference" },
    },
  },

  -- Undo tree visualization
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    keys = {
      { "<leader>u", "<cmd>UndotreeToggle<CR>", desc = "Undo tree" },
    },
  },

  -- Better quickfix
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    config = function()
      require("bqf").setup({
        preview = {
          winblend = 0,
          border = "rounded",
        },
      })
    end,
  },
}
