local present, null_ls = pcall(require, "null-ls")

if not present then
  return
end

local b = null_ls.builtins

local sources = {

  -- webdev stuff
  b.formatting.deno_fmt, -- choosed deno for ts/js files cuz its very fast!
  b.formatting.prettier.with { filetypes = { "html", "markdown", "css", "scss" } }, -- so prettier works only on these filetypes

  -- Lua
  b.formatting.stylua,

  -- cpp
  b.formatting.clang_format,

  -- rust
  b.formatting.rustfmt.with { extra_args = { "--edition=2021" } },

  -- python
  b.formatting.black.with { extra_args = { "--line-length", "79", "--target-version", "py311" } },
  b.formatting.ruff,
  b.diagnostics.mypy.with {
    extra_args = { "--ignore-missing-imports", "--strict-optional", "--follow-imports", "skip" },
  },
  b.formatting.isort,
}

null_ls.setup {
  debug = true,
  sources = sources,
}
