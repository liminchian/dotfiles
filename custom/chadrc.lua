-- Just an example, supposed to be placed in /lua/custom/

local M = {}

-- make sure you maintain the structure of `core/default_config.lua` here,
-- example of changing theme:

M.options = {}

M.ui = {
   theme = "everforest",
}

local userPlugins = require "custom.plugins"

M.plugins = {
   user = userPlugins,
   options = {
      lspconfig = {
         setup_lspconf = "custom.plugins.lspconfig",
      },
   },
   override = {},
}

M.mappings = require "custom.mappings"

return M
