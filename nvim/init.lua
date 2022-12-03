-- example file i.e lua/custom/init.lua
-- require("my autocmds file") or just declare them here
vim.cmd [[
augroup change_cursor
  au!
  au ExitPre * :set guicursor=a:ver90
augroup END
]]
