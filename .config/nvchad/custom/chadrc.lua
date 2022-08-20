local M = {}

local plugins = require("custom.plugins")
local highlights = require("custom.ui.highlights")

M.ui = {
	theme = "vscode_dark",
	theme_toggle = { "onedark", "vscode_dark" },
	transparency = false,
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
