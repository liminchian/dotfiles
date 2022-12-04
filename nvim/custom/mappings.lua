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
    ["<F9>"] = { ":lua require('dap').toggle_breakpoint()", "Toggle Breakpoint", opts = {} },
    ["<F5>"] = { ":lua require('dap').continue()", "Continue execute", opts = {} },
    ["<F11>"] = { ":lua require('dap').step_into()", "Step into", opts = {} },
    ["<F10>"] = { ":lua require('dap').step_over()", "Step over", opts = {} },
    ["<F12>"] = { ":lua require('dap').repl.open()", "Repl", opts = {} },
  },
}

return M
