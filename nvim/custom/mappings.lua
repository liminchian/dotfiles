local M = {}

M.general = {
  i = {
    ["jk"] = { "<ESC>", "escape insert mode", opts = { nowait = true } },
  },
  n = {
    ["<leader>e"] = { "<cmd>NvimTreeFocus<CR>", "Toggle nvimtree", opts = {} },
  },
}

M.dap = {
  n = {
    ["<F9>"] = { ":lua require('dap').toggle_breakpoint()<CR>", "Toggle Breakpoint", opts = {} },
    ["<F5>"] = { ":lua require('dap').continue()<CR>", "Continue execute", opts = {} },
    ["<F11>"] = { ":lua require('dap').step_into()<CR>", "Step into", opts = {} },
    ["<F10>"] = { ":lua require('dap').step_over()<CR>", "Step over", opts = {} },
    ["<F12>"] = { ":lua require('dap').repl.open()<CR>", "Repl", opts = {} },
  },
}

return M
