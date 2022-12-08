local present, dap, ui = pcall(require, "dap", "dapui")

if not present then
  return
end

-- UI configurations
dap.listeners.after.event_initialized["dapui_config"] = function()
  ui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  ui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  ui.close()
end

-- Adapters
dap.adapters.python = {
  type = "executable",
  command = function()
    if os.getenv "VIRTUAL_ENV" == 1 then
      return os.getenv "VIRTUAL_ENV" .. "/bin/python"
    else
      return "/usr/bin/python"
    end
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
  {
    name = "Launch",
    type = "lldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    args = {},
  },
}

-- Rust
dap.configurations.rust = {
  {
    name = "Launch",
    type = "lldb",
    request = "launch",
    program = function()
      local cwd = vim.fn.getcwd()
      return vim.fn.input(cwd, "target/debug" .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    args = {},
  },
}
