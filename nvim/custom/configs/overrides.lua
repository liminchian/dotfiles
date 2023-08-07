local M = {}

M.treesitter = {
  ensure_installed = {
    "vim",
    "lua",
    "html",
    "css",
    "javascript",
    "c",
    "markdown",
    "markdown_inline",
    "rust",
    "python",
    "yuck",
    "rasi",
    "scss",
    "toml",
    "json",
    "yaml",
  },
  indent = {
    enable = true,
    disable = {
      "python",
    },
  },
}

M.mason = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",

    -- web dev stuff
    "css-lsp",
    "tailwindcss-language-server",
    "html-lsp",
    "typescript-language-server",
    "deno",
    "prettier",

    -- rust
    "rust-analyzer",

    -- python
    "pyright",
    "black",
    "mypy",
    "ruff",
    "isort",
  },
}

-- git support in nvimtree
M.nvimtree = {
  git = {
    enable = true,
  },
  view = {
    side = "right",
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
}

return M
