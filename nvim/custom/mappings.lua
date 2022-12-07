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
    ["<F9>"] = { "<cmd>lua require('dap').toggle_breakpoint()<CR>", "Toggle Breakpoint", opts = {} },
    ["<F5>"] = { "<cmd>lua require('dap').continue()<CR>", "Continue execute", opts = {} },
    ["<F11>"] = { "<cmd>lua require('dap').step_into()<CR>", "Step into", opts = {} },
    ["<F10>"] = { "<cmd>lua require('dap').step_over()<CR>", "Step over", opts = {} },
    ["<F12>"] = { "<cmd>lua require('dap').repl.open()<CR>", "Repl", opts = {} },
  },
}

return M
