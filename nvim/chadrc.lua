-- Just an example, supposed to be placed in /lua/custom/
-- make sure you maintain the structure of `core/default_config.lua` here,
-- example of changing theme:
local M = {}

M.ui = {
  theme = "catppuccin",
}
M.plugins = require "custom.plugins"
M.mappings = require "custom.mappings"

return M
