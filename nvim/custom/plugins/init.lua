return {
  ["elkowar/yuck.vim"] = { ft = "yuck" },
  ["neovim/nvim-lspconfig"] = {
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.plugins.lspconfig"
    end,
  },
  ["williamboman/mason.nvim"] = {
    override_options = {
      ensure_installed = {
        "black",
        "clangd",
        "cmake-language-server",
        "cmakelang",
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
        "bash-language-server",
        "yamlfmt",
        "lua-language-server",
      },
    },
  },
  ["jose-elias-alvarez/null-ls.nvim"] = {
    after = "nvim-lspconfig",
    config = function()
      require "custom.plugins.null-ls"
    end,
  },
  ["nvim-treesitter/nvim-treesitter"] = {
    override_options = {
      ensure_installed = {
        "vim",
        "html",
        "css",
        "javascript",
        "json",
        "toml",
        "markdown",
        "c",
        "cpp",
        "bash",
        "lua",
        "python",
        "yaml",
        "rust",
        "fish",
        "rasi",
      },
      indent = false,
    },
  },
  ["kylechui/nvim-surround"] = {
    tag = "*",
    config = function()
      require "custom.plugins.surround"
    end,
  },
  ["kyazdani42/nvim-tree.lua"] = {
    override_options = {
      view = {
        side = "right",
      },
    },
  },
  ["rcarriga/nvim-dap-ui"] = {
    requires = { "mfussenegger/nvim-dap" },
    config = function()
      require "custom.plugins.dap"
    end,
  },
}
