-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })

local autocmd = vim.api.nvim_create_autocmd
autocmd({ "InsertEnter" }, {
  callback = function()
    vim.lsp.buf.inlay_hint(0, true)
  end,
})
autocmd({ "InsertLeave" }, {
  callback = function()
    vim.lsp.buf.inlay_hint(0, false)
  end,
})
