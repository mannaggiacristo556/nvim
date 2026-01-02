-- Treesitter - Syntax highlighting
return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  lazy = false,
  priority = 900,
  config = function()
    -- Filetypes to skip treesitter
    local skip_ft = { "oil", "neo-tree", "lazy", "mason", "help", "qf", "kanban", "" }

    -- Enable highlighting on supported filetypes
    vim.api.nvim_create_autocmd("FileType", {
      callback = function()
        local ft = vim.bo.filetype
        -- Skip special filetypes
        for _, skip in ipairs(skip_ft) do
          if ft == skip then return end
        end
        -- Try to start treesitter
        local lang = vim.treesitter.language.get_lang(ft) or ft
        local ok = pcall(vim.treesitter.language.add, lang)
        if ok then
          pcall(vim.treesitter.start)
        end
      end,
    })
  end,
}
