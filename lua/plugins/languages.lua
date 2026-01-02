-- Language-specific plugins
return {
  -- Rust: rustaceanvim (the best Rust plugin)
  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    lazy = false,
    ft = { "rust" },
    config = function()
      vim.g.rustaceanvim = {
        tools = {
          hover_actions = { auto_focus = true },
        },
        server = {
          on_attach = function(client, bufnr)
            local map = function(mode, lhs, rhs, desc)
              vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
            end
            -- Rust-specific keymaps
            map("n", "<leader>rd", "<cmd>RustLsp debuggables<CR>", "Rust debuggables")
            map("n", "<leader>rr", "<cmd>RustLsp runnables<CR>", "Rust runnables")
            map("n", "<leader>rt", "<cmd>RustLsp testables<CR>", "Rust testables")
            map("n", "<leader>re", "<cmd>RustLsp expandMacro<CR>", "Expand macro")
            map("n", "<leader>rc", "<cmd>RustLsp openCargo<CR>", "Open Cargo.toml")
            map("n", "<leader>rp", "<cmd>RustLsp parentModule<CR>", "Parent module")
            map("n", "<leader>rj", "<cmd>RustLsp joinLines<CR>", "Join lines")
            map("n", "<leader>rh", "<cmd>RustLsp hover actions<CR>", "Hover actions")
            map("n", "J", "<cmd>RustLsp joinLines<CR>", "Join lines (Rust)")
          end,
          default_settings = {
            ["rust-analyzer"] = {
              checkOnSave = { command = "clippy" },
              cargo = { allFeatures = true },
              procMacro = { enable = true },
            },
          },
        },
      }
    end,
  },

  -- Crates.nvim: Cargo.toml dependency management
  {
    "Saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local crates = require("crates")
      crates.setup({
        popup = { border = "rounded" },
        lsp = {
          enabled = true,
          actions = true,
          completion = true,
          hover = true,
        },
      })

      -- Keymaps for Cargo.toml
      vim.api.nvim_create_autocmd("BufRead", {
        pattern = "Cargo.toml",
        callback = function()
          local map = vim.keymap.set
          map("n", "<leader>ct", crates.toggle, { buffer = true, desc = "Toggle crates" })
          map("n", "<leader>cr", crates.reload, { buffer = true, desc = "Reload crates" })
          map("n", "<leader>cv", crates.show_versions_popup, { buffer = true, desc = "Show versions" })
          map("n", "<leader>cf", crates.show_features_popup, { buffer = true, desc = "Show features" })
          map("n", "<leader>cd", crates.show_dependencies_popup, { buffer = true, desc = "Show deps" })
          map("n", "<leader>cu", crates.update_crate, { buffer = true, desc = "Update crate" })
          map("n", "<leader>cU", crates.upgrade_crate, { buffer = true, desc = "Upgrade crate" })
          map("n", "<leader>cA", crates.upgrade_all_crates, { buffer = true, desc = "Upgrade all" })
        end,
      })
    end,
  },

  -- Go
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()',
    config = function()
      require("go").setup({
        lsp_cfg = false, -- We handle LSP in lsp.lua
        lsp_keymaps = false,
        dap_debug = true,
      })

      -- Go keymaps
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "go",
        callback = function()
          local map = vim.keymap.set
          map("n", "<leader>gr", "<cmd>GoRun<CR>", { buffer = true, desc = "Go run" })
          map("n", "<leader>gt", "<cmd>GoTest<CR>", { buffer = true, desc = "Go test" })
          map("n", "<leader>gtf", "<cmd>GoTestFunc<CR>", { buffer = true, desc = "Go test func" })
          map("n", "<leader>gc", "<cmd>GoCoverage<CR>", { buffer = true, desc = "Go coverage" })
          map("n", "<leader>gi", "<cmd>GoImports<CR>", { buffer = true, desc = "Go imports" })
          map("n", "<leader>ge", "<cmd>GoIfErr<CR>", { buffer = true, desc = "Go if err" })
          map("n", "<leader>gs", "<cmd>GoFillStruct<CR>", { buffer = true, desc = "Fill struct" })
          map("n", "<leader>ga", "<cmd>GoAddTag<CR>", { buffer = true, desc = "Add tags" })
        end,
      })
    end,
  },

  -- TypeScript (typescript-tools is faster than tsserver)
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    config = function()
      require("typescript-tools").setup({
        settings = {
          separate_diagnostic_server = true,
          publish_diagnostic_on = "insert_leave",
          tsserver_file_preferences = {
            includeInlayParameterNameHints = "all",
            includeInlayEnumMemberValueHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayVariableTypeHints = true,
          },
        },
      })

      -- TypeScript keymaps
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
        callback = function()
          local map = vim.keymap.set
          map("n", "<leader>jo", "<cmd>TSToolsOrganizeImports<CR>", { buffer = true, desc = "Organize imports" })
          map("n", "<leader>js", "<cmd>TSToolsSortImports<CR>", { buffer = true, desc = "Sort imports" })
          map("n", "<leader>jr", "<cmd>TSToolsRemoveUnusedImports<CR>", { buffer = true, desc = "Remove unused" })
          map("n", "<leader>jf", "<cmd>TSToolsFixAll<CR>", { buffer = true, desc = "Fix all" })
          map("n", "<leader>ja", "<cmd>TSToolsAddMissingImports<CR>", { buffer = true, desc = "Add missing" })
          map("n", "<leader>jd", "<cmd>TSToolsGoToSourceDefinition<CR>", { buffer = true, desc = "Source def" })
          map("n", "<leader>jR", "<cmd>TSToolsRenameFile<CR>", { buffer = true, desc = "Rename file" })
        end,
      })
    end,
  },

  -- C/C++ extras (clangd-extensions)
  {
    "p00f/clangd_extensions.nvim",
    ft = { "c", "cpp", "objc", "objcpp", "cuda" },
    config = function()
      require("clangd_extensions").setup({
        inlay_hints = {
          inline = vim.fn.has("nvim-0.10") == 1,
          only_current_line = false,
          show_parameter_hints = true,
          parameter_hints_prefix = "<- ",
          other_hints_prefix = "=> ",
        },
        ast = {
          role_icons = {
            type = "",
            declaration = "",
            expression = "",
            specifier = "",
            statement = "",
            ["template argument"] = "",
          },
        },
      })

      -- C/C++ keymaps
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "c", "cpp" },
        callback = function()
          local map = vim.keymap.set
          map("n", "<leader>lh", "<cmd>ClangdSwitchSourceHeader<CR>", { buffer = true, desc = "Switch header/source" })
          map("n", "<leader>lt", "<cmd>ClangdTypeHierarchy<CR>", { buffer = true, desc = "Type hierarchy" })
          map("n", "<leader>lm", "<cmd>ClangdMemoryUsage<CR>", { buffer = true, desc = "Memory usage" })
          map("n", "<leader>la", "<cmd>ClangdAST<CR>", { buffer = true, desc = "Show AST" })
        end,
      })
    end,
  },

  -- CMake
  {
    "Civitasv/cmake-tools.nvim",
    ft = { "cmake", "c", "cpp" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("cmake-tools").setup({})
    end,
  },
}
