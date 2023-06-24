local capabilities = require("plugins.configs.lspconfig").capabilities
local on_attach = require("plugins.configs.lspconfig").on_attach

local lspconfig = require "lspconfig"

-- if you just want default config for the servers then put them in a table
local servers = { "html", "cssls", "tsserver", "clangd", "pyright", "rust_analyzer" }

for _, lsp in ipairs(servers) do
  if lsp == "rust_analyzer" then
    lspconfig[lsp].setup {
      on_attach = on_attach,
      capabilities = capabilities,
      ops = { inlay_hints = { enabled = true } },
    }
  else
    lspconfig[lsp].setup {
      on_attach = on_attach,
      capabilities = capabilities,
    }
  end
end

-- lspconfig.pyright.setup { blabla}
