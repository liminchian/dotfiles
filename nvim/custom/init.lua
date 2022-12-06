-- example file i.e lua/custom/init.lua
-- require("my autocmds file") or just declare them here

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "TabEnter", "BufWritePost" }, {
  pattern = "*.rs",
  command = function()
    require("lsp_extensions").inlay_hints()
  end,
})

vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
  pattern = "*.rs",
  command = function()
    require("lsp_extensions").inlay_hints {
      only_current_line = true,
    }
  end,
})
