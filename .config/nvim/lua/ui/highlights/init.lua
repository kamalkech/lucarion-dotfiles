local M = {}

local colors = require("catppuccin.palettes").get_palette()

M.get_hlgroups = function(parts)
	parts = (type(parts) == "table") and parts or { "general" }
	local hl_groups = {}
	for _, part in pairs(parts) do
		local hl_table = require("ui.highlights." .. part)
		hl_groups = vim.tbl_deep_extend("force", hl_groups, hl_table)
	end
	-- Use colorgroups from catppuccin color table and convert it to respective string
	for _, opts in pairs(hl_groups) do
		opts.bg = colors[opts.bg]
		opts.fg = colors[opts.fg]
	end
	return hl_groups
end

return M
