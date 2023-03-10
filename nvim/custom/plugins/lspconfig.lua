local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = {
  "clangd",
  "html",
  "cssls",
  "pyright",
  "rust_analyzer",
  "cmake",
  "bashls",
  "denols",
}

for _, lsp in ipairs(servers) do
  if lsp == "clangd" then
    capabilities.offsetEncoding = { "utf-16" }
  elseif lsp == "ccls" then
    capabilities.offsetEncoding = { "utf-32" }
  end
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end
