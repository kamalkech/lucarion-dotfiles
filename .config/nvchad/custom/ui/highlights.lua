local M = {}

M.override = {
	Comment = { fg = "yellow", bold = true, italic = true, },
	markdownError = { link = "Normal" },
	Folded = { fg = "blue", },
	CmpBorder = { fg = "orange", },
	CmpDocBorder = { fg = "sun", },
	IndentBlanklineContextChar = { fg = "nord_blue" },
	St_NormalModeSep = {
		bg = "statusline_bg",
	},

	St_InsertModeSep = {
		bg = "statusline_bg",
	},

	St_TerminalModeSep  = { bg = "statusline_bg", },
	St_NTerminalModeSep = { bg = "statusline_bg", },
	St_VisualModeSep    = { bg = "statusline_bg", },
	St_ReplaceModeSep   = { bg = "statusline_bg", },
	St_ConfirmModeSep   = { bg = "statusline_bg", },
	St_CommandModeSep   = { bg = "statusline_bg", },
	St_SelectModeSep    = { bg = "statusline_bg", },
}

M.add = {
	--------Custom Statusline coloring-----------------
	StInviSep = { fg = "statusline_bg", bg = "statusline_bg" },
	StSessionStatus = { fg = "blue", bg = "statusline_bg" },

	--CurFile
	StCwd        = { bg = "green", fg = "black" },
	StFile       = { bg = "vibrant_green", fg = "black" },
	StCwdSep     = { fg = "green", bg = "statusline_bg" },
	StFileSep    = { fg = "vibrant_green", bg = "statusline_bg" },
	StDirFileSep = { fg = "green", bg = "vibrant_green" },

	-- Git stuffs
	StGitBranch  = { fg = "purple", bg = "statusline_bg" },
	StGitAdded   = { fg = "green", bg = "statusline_bg" },
	StGitChanged = { fg = "yellow", bg = "statusline_bg" },
	StGitRemoved = { fg = "red", bg = "statusline_bg" },

	-- LSP Stuffs
	-- StLSPProgress = { bg = "statusline_bg", fg = "" },
	StLSPClient   = { bg = "statusline_bg", fg = "blue", bold = true },
	StLSPErrors   = { bg = "statusline_bg", fg = "red" },
	StLSPWarnings = { bg = "statusline_bg", fg = "yellow" },
	StLSPHints    = { bg = "statusline_bg", fg = "baby_pink" },
	StLspInfo     = { bg = "statusline_bg", fg = "cyan" },

	-- File Info stuffs
	StPosition    = { bg = "teal", fg = "black" },
	StPositionSep = { bg = "statusline_bg", fg = "teal" }
	--------Custom Statusline coloring ends------------
}

return M
