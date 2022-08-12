-- List of available colors
-- base
-- blue
-- crust
-- flamingo
-- green
-- lavender
-- mantle
-- maroon
-- mauve
-- overlay0
-- overlay1
-- overlay2
-- peach
-- pink
-- red
-- rosewater
-- sapphire
-- sky
-- subtext0
-- subtext1
-- surface0
-- surface1
-- surface2
-- teal
-- text
-- yellow
local bg = "mantle"
-- local frappe = require("catppuccin.palettes.frappe")
-- frappe.base = "#AABBCC"

local hlgroups = {
	-- buffers
	BufferLineBackground = { bg = bg },
	BufferLineBuffer = { fg = "surface0", bg = bg },
	BufferLineBackcrust = { fg = "surface0", bg = bg },
	BufferLineBufferVisible = { fg = "text", bg = bg },
	BufferLineBufferSelected = { fg = "pink", bg = bg, bold = true, italic = true },

	-- tab
	BufferLineTab = { bg = bg, fg = "text" },
	BufferLineTabSelected = { fg = "red", bg = "crust", bold = true },

	-- Separators
	BufferLineSeparator = { bg = bg },
	BufferLineSeparatorVisible = { bg = bg },
	BufferLineSeparatorSelected = { bg = bg },
	-- Indicators
	BufferLineIndicatorSelected = { fg = "peach", bg = bg },
	BufferLineIndicatorVisible = { fg = "peach", bg = bg },

	-- Modified
	BufferLineModified = { bg = bg, fg = "green", },
	BufferLineModifiedVisible = { bg = bg, fg = "green" },
	BufferLineModifiedSelected = { bg = bg, fg = "green" },


	-- Name resolver
	BufferLineDuplicate = { fg = "rosewater", bg = bg, italic = false },
	BufferLineDuplicateVisible = { fg = "sky", bg = bg },
	BufferLineDuplicateSelected = { fg = "peach", bg = bg },
	-- fill
	BufferLineFill = { bg = bg },
}

return hlgroups
