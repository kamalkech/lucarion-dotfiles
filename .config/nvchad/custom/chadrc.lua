local M = {}

M.ui = {
	theme = "onedark",
	theme_toggle = { "onedark", "rxyhn" },
	transparency = false,
	hl_override = {
		Comment = {
			fg = "yellow", bold = true, italic = true,
		},
		markdownError = {
			link = "Normal"
		},
		Folded = {
			fg = "blue",
		},
		CmpBorder = {
			fg = "orange",
		},
		CmpDocBorder = {
			fg = "sun",
		}
	},
	-- hl_add = {
	-- }
}

M.plugins = {
	remove = {
		"folke/which-key.nvim",
		"goolord/alpha-nvim",
		"NvChad/nvterm",
	},
	override = require("custom.plugins").override,
	user = require("custom.plugins").user
}

M.mappings = require("custom.mappings")

return M
