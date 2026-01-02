-- Remote development with distant.nvim
return {
  {
    "chipsenkbeil/distant.nvim",
    branch = "v0.3",
    config = function()
      require("distant"):setup({
        manager = {
          user = true,  -- Use user-local socket instead of global
        },
        -- Servers can be configured here if needed
        servers = {
          ["celeste-eu-cluster"] = {
            connect = {
              default = {
                scheme = "ssh",
                username = "celeste",
              },
            },
          },
        },
      })

      -- Keybindings
      local keymap = vim.keymap.set
      keymap("n", "<leader>Dc", function()
        vim.ui.input({ prompt = "SSH address: ", default = "ssh://celeste@celeste-eu-cluster" }, function(addr)
          if addr then vim.cmd("DistantConnect " .. addr) end
        end)
      end, { desc = "Distant Connect (SSH)" })
      keymap("n", "<leader>Dl", function()
        vim.ui.input({ prompt = "Launch address: ", default = "ssh://celeste@celeste-eu-cluster" }, function(addr)
          if addr then vim.cmd("DistantLaunch " .. addr) end
        end)
      end, { desc = "Distant Launch" })
      keymap("n", "<leader>Do", "<cmd>DistantOpen<CR>", { desc = "Distant Open" })
      keymap("n", "<leader>Ds", "<cmd>DistantShell<CR>", { desc = "Distant Shell" })
      keymap("n", "<leader>Dw", function()
        vim.ui.input({ prompt = "Remote directory: ", default = "/home/celeste/" }, function(path)
          if path then
            vim.cmd("DistantOpen " .. path)
          end
        end)
      end, { desc = "Distant Workspace (browse dir)" })

      -- Remote file tree using neo-tree
      keymap("n", "<leader>Db", "<cmd>Neotree source=distant position=left<CR>", { desc = "Distant Browse (neo-tree)" })
    end,
  },
}
