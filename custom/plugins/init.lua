return {
  ["elkowar/yuck.vim"] = { ft = "yuck" },
  ["Fymyte/rasi.vim"] = { ft = "rasi" },

  ["NvChad/nvterm"] = {
    config = function()
      require "plugins.configs.nvterm"
    end,
  },
  ["neovim/nvim-lspconfig"] = {
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.plugins.lspconfig"
    end,
  },
  ["williamboman/mason.nvim"] = {
    ensure_installed = {
      "black",
      "cmake-language-server",
      "cmakelang",
      "cpplint",
      "cpptools",
      "css-lsp",
      "html-lsp",
      "isort",
      "json-lsp",
      "mypy",
      "prettier",
      "pyright",
      "rust-analyzer",
      "shfmt",
      "stylua",
      "json-lsp",
      "shellcheck",
    },
  },
  ["jose-elias-alvarez/null-ls.nvim"] = {
    after = "nvim-lspconfig",
    config = function()
      require "custom.plugins.null-ls"
    end,
  },
}
