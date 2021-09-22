local function map(mode, lhs, rhs, opts)
    local options = {noremap = true, silent = true}
    if opts then options = vim.tbl_extend("force", options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local opt = {}

-- escape with 'jk' mapping
vim.api.nvim_set_keymap("i", "jk", "<esc>", {})
vim.api.nvim_set_keymap("v", "jk", "<esc>", {})
vim.api.nvim_set_keymap("t", "jk", "<esc>", {})

-- Don't copy the replaced text after pasting in visual mode
map("v", "p", '"_dP', opt)

-- OPEN TERMINALS --
map('n', '`', '<CMD>lua require("lspsaga.floaterm").open_float_terminal()<CR>',
    opt)
map('t', '`',
    '<C-\\><C-n><CMD>lua require("lspsaga.floaterm").close_float_terminal()<CR>',
    opt)

-- Truezen.nvim
map("n", "<Leader>zz", ":TZAtaraxis<CR>", opt)
map("n", "<Leader>zm", ":TZMinimalist<CR>", opt)
map("n", "<Leader>zf", ":TZFocus<CR>", opt)

-- Commenter Keybinding
map("n", "<Leader>cc", ":CommentToggle<CR>", opt)
map("v", "<Leader>cc", ":CommentToggle<CR>", opt)

-- compe stuff
local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col(".") - 1
    if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
        return true
    else
        return false
    end
end

_G.tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-n>"
    elseif check_back_space() then
        return t "<Tab>"
    else
        return vim.fn["compe#complete"]()
    end
end

_G.s_tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-p>"
    elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
        return t "<Plug>(vsnip-jump-prev)"
    else
        return t "<S-Tab>"
    end
end

function _G.completions()
    local npairs
    if not pcall(function() npairs = require "nvim-autopairs" end) then
        return
    end

    if vim.fn.pumvisible() == 1 then
        if vim.fn.complete_info()["selected"] ~= -1 then
            return vim.fn["compe#confirm"]("<CR>")
        end
    end
    return npairs.check_break_line_char()
end

--  compe mappings
map("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
map("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
map("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
map("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
map("i", "<CR>", "v:lua.completions()", {expr = true})

-- nvimtree
map("n", "<Leader>n", "<cmd>NvimTreeToggle<CR>", opt)

-- outliner
map("n", "<Leader>o", "<cmd>TagbarToggle<CR>", opt)

-- format code
map("n", "<Leader>fm", [[<cmd>Neoformat<CR>]], opt)

-- bookmark
map("n", "mi", [[<Cmd> BookmarkAnnotate<CR>]], opt)
map("n", "mm", [[<Cmd> BookmarkToggle<CR>]], opt)
map("n", "<Leader>b", [[<Cmd> BookmarkShowAll<CR>]], opt)

-- Telescope
map("n", "<Leader>gt", [[<Cmd> Telescope git_status <CR>]], opt)
map("n", "<Leader>cm", [[<Cmd> Telescope git_commits <CR>]], opt)
map("n", "<Leader>ff", [[<Cmd> Telescope find_files <CR>]], opt)
map("n", "<Leader>fp",
    [[<Cmd>lua require('telescope').extensions.media_files.media_files()<CR>]],
    opt)
map("n", "<Leader>fh", [[<Cmd>Telescope help_tags<CR>]], opt)
map("n", "<Leader>fo", [[<Cmd>Telescope oldfiles<CR>]], opt)
map("n", "<Leader>fb", [[<Cmd>Telescope buffers<CR>]], opt)

-- bufferline tab stuff
map("n", "Q", ":bw!<CR>", opt)

-- move between tabs
map("n", "J", [[<Cmd>BufferLineCycleNext<CR>]], opt)
map("n", "K", [[<Cmd>BufferLineCyclePrev<CR>]], opt)
for i = 1, 9 do
    map("n", "<Leader>" .. i, [[<Cmd>BufferLineGoToBuffer ]] .. i .. "<CR>", opt)
end

-- get out of terminal with jk
map("t", "jk", "<C-\\><C-n>", opt)
map('n', "<Leader>h", "<CMD>lua require('Navigator').left()<CR>", opt)
map('n', "<Leader>k", "<CMD>lua require('Navigator').up()<CR>", opt)
map('n', "<Leader>l", "<CMD>lua require('Navigator').right()<CR>", opt)
map('n', "<Leader>j", "<CMD>lua require('Navigator').down()<CR>", opt)

