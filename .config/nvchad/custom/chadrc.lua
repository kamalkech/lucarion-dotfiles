local M = {}

local plugins = require("custom.plugins")
local highlights = require("custom.ui.highlights")

M.ui = {
	theme = "onedark",
	theme_toggle = { "onedark", "rxyhn" },
	transparency = true,
	hl_override = highlights.override,
	hl_add = highlights.add,
}

M.plugins = {
	remove = {
		"folke/which-key.nvim",
		"goolord/alpha-nvim",
		"NvChad/nvterm",
	},
	override = plugins.override,
	user = plugins.user
}

M.mappings = require("custom.mappings")

return M
