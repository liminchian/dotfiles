return {
	-- Core plugins
	["NvChad/ui"] = {
		override_options = {
			statusline = {
				separator_style = "block",
			},
		},
	},

	["neovim/nvim-lspconfig"] = {
		config = function()
			require("plugins.configs.lspconfig")
			require("custom.plugins.lspconfig")
		end,
	},

	["hrsh7th/nvim-cmp"] = {
		override_options = {
			experimental = {
				ghost_text = true,
			},
		},
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
				"rustfmt",
				"deno",
			},
		},
	},

	["nvim-treesitter/nvim-treesitter"] = {
		override_options = {
			ensure_installed = {
				"vim",
				"html",
				"css",
				"javascript",
				"typescript",
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

	["nvim-tree/nvim-tree.lua"] = {
		override_options = {
			view = {
				side = "right",
			},
		},
	},

	-- Extra plugins
	["elkowar/yuck.vim"] = { ft = "yuck" },

	["jose-elias-alvarez/null-ls.nvim"] = {
		after = "nvim-lspconfig",
		config = function()
			require("custom.plugins.null-ls")
		end,
	},

	["kylechui/nvim-surround"] = {
		tag = "*",
		config = function()
			require("custom.plugins.surround")
		end,
	},

	["simrat39/rust-tools.nvim"] = {
		after = "nvim-lspconfig",
		config = function()
			require("custom.plugins.rust-tools")
		end,
	},
}
