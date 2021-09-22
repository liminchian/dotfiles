local present, _ = pcall(require, "packerInit")
local packer

if present then
    packer = require "packer"
else
    return false
end

local use = packer.use

return packer.startup(function()
    use {"wbthomason/packer.nvim", event = "VimEnter"}

    use {"akinsho/nvim-bufferline.lua", after = "nvim-base16.lua"}

    use {
        "glepnir/galaxyline.nvim",
        after = "nvim-base16.lua",
        config = function() require "plugins.statusline" end
    }

    -- color related stuff
    use {
        "siduck76/nvim-base16.lua",
        after = "packer.nvim",
        config = function() require "theme" end
    }

    use {
        "norcalli/nvim-colorizer.lua",
        event = "BufRead",
        config = function() require"plugins.others".colorizer() end
    }

    -- language related plugins
    use {
        "nvim-treesitter/nvim-treesitter",
        event = "BufRead",
        config = function() require "plugins.treesitter" end
    }

    use {"kabouzeid/nvim-lspinstall", event = "BufRead"}

    use {
        "neovim/nvim-lspconfig",
        after = "nvim-lspinstall",
        config = function() require "plugins.lspconfig" end
    }

    use {
        "ray-x/lsp_signature.nvim",
        config = function() require"plugins.others".lspsignature() end
    }

    use {
        "onsails/lspkind-nvim",
        event = "BufRead",
        config = function() require"plugins.others".lspkind() end
    }

    use {
        "glepnir/lspsaga.nvim",
        config = function() require"plugins.others".lspsaga() end
    }

    -- formatter
    use {"sbdchd/neoformat"}

    -- load compe in insert mode only
    use {
        "hrsh7th/nvim-compe",
        event = "InsertEnter",
        config = function() require "plugins.compe" end,
        requires = {
            "hrsh7th/vim-vsnip", "hrsh7th/vim-vsnip-integ",
            "rafamadriz/friendly-snippets"
        }
    }
    use {"tzachar/compe-tabnine", run = "./install.sh", after = "nvim-compe"}

    -- file managing , picker etc
    use {
        "kyazdani42/nvim-tree.lua",
        cmd = "NvimTreeToggle",
        config = function() require "plugins.nvimtree" end
    }

    use {
        "kyazdani42/nvim-web-devicons",
        after = "nvim-base16.lua",
        config = function() require "plugins.icons" end
    }

    use {"nvim-lua/plenary.nvim", event = "BufRead"}
    use {"nvim-lua/popup.nvim", after = "plenary.nvim"}

    use {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        config = function() require "plugins.telescope" end
    }

    use {
        "nvim-telescope/telescope-fzf-native.nvim",
        run = "make",
        cmd = "Telescope"
    }
    use {"nvim-telescope/telescope-media-files.nvim", cmd = "Telescope"}

    -- git stuff
    use {
        "lewis6991/gitsigns.nvim",
        after = "plenary.nvim",
        config = function() require "plugins.gitsigns" end
    }

    -- misc plugins
    use {
        "windwp/nvim-autopairs",
        after = "nvim-compe",
        config = function() require "plugins.autopairs" end
    }

    use {"andymass/vim-matchup", event = "CursorMoved"}

    use {
        "terrortylor/nvim-comment",
        cmd = "CommentToggle",
        config = function() require"plugins.others".comment() end
    }

    use {"tweekmonster/startuptime.vim", cmd = "StartupTime"}

    -- smooth scroll
    use {
        "karb94/neoscroll.nvim",
        event = "WinScrolled",
        config = function() require"plugins.others".neoscroll() end
    }

    use {
        "Pocco81/TrueZen.nvim",
        cmd = {"TZAtaraxis", "TZMinimalist", "TZFocus"},
        config = function() require "plugins.zenmode" end
    }

    --   use "alvan/vim-closetag" -- for html autoclosing tag

    use {
        "lukas-reineke/indent-blankline.nvim",
        event = "BufRead",
        setup = function() require"plugins.others".blankline() end
    }

    -- markdownpreview
    use {
        "iamcco/markdown-preview.nvim",
        run = [[sh -c 'cd app && yarn install']]
    }

    -- surround
    use {"tpope/vim-surround", requires = {"tpope/vim-repeat"}}

    -- navigator
    use {
        'numToStr/Navigator.nvim',
        config = function() require "plugins.navigator" end
    }

    -- terminal
    use {
        "numtostr/FTerm.nvim",
        config = function() require "plugins.terminal" end
    }

    -- last edit
    use {"farmergreg/vim-lastplace"}

    -- format by mark
    use {"godlygeek/tabular"}

    -- bookmarks
    use {
        "MattesGroeger/vim-bookmarks",
        cmd = {"BookmarkAnnotate", "BookmarkToggle", "BookmarkShowAll"}
    }

    -- outliner
    use {"preservim/tagbar", cmd = {"TagbarToggle"}}

    -- colorscheme
    use "shaunsingh/nord.nvim"

    -- programming
    use "mfussenegger/nvim-dap"

end)
