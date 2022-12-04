local present, dap = pcall(require, "dap")

if not present then
  return
end

-- Adapters
dap.adapters.python = {
  type = "executable",
  command = function()
    return os.getenv "VIRTUAL_ENV" .. "bin/python"
  end,
  args = { "-m", "debugpy.adapter" },
}

dap.adapters.lldb = {
  type = "executable",
  command = "/usr/bin/lldb-vscode",
  name = "lldb",
}

-- Python
dap.configurations.python = {
  {
    type = "python",
    request = "launch",
    name = "Launch file",
    pythonPath = function()
      local cwd = vim.fn.getcwd()
      if vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
        return cwd .. "/.venv/bin/python"
      else
        return "/usr/bin/python"
      end
    end,
  },
}

-- Cpp
dap.configurations.cpp = {
  name = "Launch",
  type = "lldb",
  request = "launch",
  program = function()
    return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
  end,
  cwd = "${workspaceFolder}",
  stopOnEntry = false,
  args = {},
}

-- Rust
dap.configurations.rust = dap.configurations.cpp
