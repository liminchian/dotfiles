local M = {}

M.general = {
  i = {
    ["jk"] = { "<ESC>", "escape insert mode", opts = { nowait = true } },
  },
  n = {
    ["<leader>e"] = { "<cmd>NvimTreeFocus<CR>", "Toggle nvimtree" },
  },
}

M.dap = {
  n = {
    ["<F5>"] = { "<cmd>lua require('dap').continue()<CR>", "Continue execute" },
    ["<F11>"] = { "<cmd>lua require('dap').step_into()<CR>", "Step into" },
    ["<F10>"] = { "<cmd>lua require('dap').step_over()<CR>", "Step over" },
    ["<F12>"] = { "<cmd>lua require('dap').step_out()<CR>", "Step out" },
    ["<F9>"] = { "<cmd>lua require('dap').toggle_breakpoint()<CR>", "Toggle breakpoint" },
  },
}

return M
