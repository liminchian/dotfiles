local present, null_ls = pcall(require, "null-ls")

if not present then
  return
end

local b = null_ls.builtins

local sources = {
  -- Yaml
  b.formatting.yamlfmt,

  -- Css / Html
  b.formatting.prettierd,

  -- JavaScript / TypeScript
  b.formatting.deno_fmt,

  -- Lua
  b.formatting.stylua,

  -- Shell
  b.formatting.shfmt,
  b.diagnostics.shellcheck.with { diagnostics_format = "#{m} [#{c}]" },

  -- Cpp
  b.formatting.clang_format,
  b.formatting.cmake_format,

  -- Python
  b.formatting.black,
  b.formatting.isort,
  b.diagnostics.mypy,

  -- Rust
  b.formatting.rustfmt.with {
    extra_args = function(params)
      local Path = require "plenary.path"
      local cargo_toml = Path:new(params.root .. "/" .. "Cargo.toml")

      if cargo_toml:exists() and cargo_toml:is_file() then
        for _, line in ipairs(cargo_toml:readlines()) do
          local edition = line:match [[^edition%s*=%s*%"(%d+)%"]]
          if edition then
            return { "--edition=" .. edition }
          end
        end
      end
      -- default edition when we don't find `Cargo.toml` or the `edition` in it.
      return { "--edition=2021" }
    end,
  },
}

null_ls.setup { debug = true, sources = sources }
