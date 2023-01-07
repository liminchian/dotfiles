local present, rust_tools = pcall(require, "rust-tools")

if not present then
  return
end

local opts = {
  tools = {
    autoSetHints = true,
    inlay_hints = {
      show_parameter_hints = true,
      parameter_hints_prefix = "",
      other_hints_prefix = "",
    },
  },
  server = {
    on_attach = require("plugins.configs.lspconfig").on_attach,
    settings = {
      ["rust-analyzer"] = {
        checkOnSave = {
          command = "check",
        },
        inlayHints = { locationLinks = false },
      },
    },
  },
}

rust_tools.setup(opts)
rust_tools.inlay_hints.enable()
