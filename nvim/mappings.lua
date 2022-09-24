local M = {}

M.general = {
  i = {
    ["jk"] = { "<ESC>", "escape insert mode", opts = { nowait = true } },
  },
  n = {
    ["<leader>e"] = { "<cmd>NvimTreeFocus<CR>", "Toggle nvimtree", opts = {} },
  },
}

M.lspconfig = {
  n = {
    ["<leader>fm"] = {
      function()
        vim.lsp.buf.formatting { async = true }
      end,
      "lsp formatting",
    },
  },
}

return M
