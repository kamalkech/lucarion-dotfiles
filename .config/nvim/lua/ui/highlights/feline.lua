local vary_color = function(latte_clr, clr)
	if vim.g.catppuccin_flavour == "latte" then return latte_clr
	else return clr
	end
end
local bg = vary_color("crust", "surface0")
local text = vary_color("base", "surface0")
local hlgroups = {
	FelineInviSep = { fg = text, bg = bg },

	-- Git Branch
	FelineGitBranch  = { bg = bg, fg = "mauve" },
	FelineGitAdded   = { bg = bg, fg = "green" },
	FelineGitChanged = { bg = bg, fg = "yellow" },
	FelineGitRemoved = { bg = bg, fg = "red" },

	-- Vim Modes
	FelineNormalMode      = { fg = text, bold = true, bg = "lavender" },
	FelineOpMode          = { fg = text, bold = true, bg = "lavender" },
	FelineInsertMode      = { fg = text, bold = true, bg = "green" },
	FelineTerminalMode    = { fg = text, bold = true, bg = "green" },
	FelineVisualMode      = { fg = text, bold = true, bg = "flamingo" },
	FelineReplaceMode     = { fg = text, bold = true, bg = "maroon" },
	FelineSelectMode      = { fg = text, bold = true, bg = "maroon" },
	FelinePromptMode      = { fg = text, bold = true, bg = "teal" },
	FelineMoreMode        = { fg = text, bold = true, bg = "teal" },
	FelineCommandMode     = { fg = text, bold = true, bg = "peach" },
	FelineShellMode       = { fg = text, bold = true, bg = "green" },
	FelineNoneMode        = { fg = text, bold = true, bg = "sky" },
	-- Separators for Vim Modes
	FelineNormalModeSep   = { bg = bg, fg = "lavender" },
	FelineOpModeSep       = { bg = bg, fg = "lavender" },
	FelineInsertModeSep   = { bg = bg, fg = "green" },
	FelineTerminalModeSep = { bg = bg, fg = "green" },
	FelineVisualModeSep   = { bg = bg, fg = "flamingo" },
	FelineReplaceModeSep  = { bg = bg, fg = "maroon" },
	FelineSelectModeSep   = { bg = bg, fg = "maroon" },
	FelinePromptModeSep   = { bg = bg, fg = "teal" },
	FelineMoreModeSep     = { bg = bg, fg = "teal" },
	FelineCommandModeSep  = { bg = bg, fg = "peach" },
	FelineShellModeSep    = { bg = bg, fg = "green" },
	FelineNoneModeSep     = { bg = bg, fg = "sky" },

	-- LSP
	FelineLSPProgress = { bg = bg, fg = "rosewater" },
	FelineLSPClient   = { bg = bg, fg = "blue" },
	FelineLSPErrors   = { bg = bg, fg = "red" },
	FelineLSPWarnings = { bg = bg, fg = "yellow" },
	FelineLSPHints    = { bg = bg, fg = "rosewater" },
	FelineLSPInfo     = { bg = bg, fg = "sky" },

	-- Miscellaneous
	FelineFileInfoSep               = { bg = bg, fg = "sky" },
	FelineFileInfoPosition          = { bg = "sky", fg = text },
	FelineFileInfoPercentage        = { bg = "sky", fg = text },
	FelineDirInfoDirectory          = { bg = "sapphire", fg = text },
	FelineDirInfoDirectorySep       = { fg = "sapphire", bg = "teal" },
	FelineDirInfoDirectorySepNoFile = { fg = "sapphire", bg = bg },
	FelineDirInfoFilename           = { bg = "teal", fg = text, bold = true },
	FelineDirInfoFilenameSep        = { fg = "teal", bg = bg },
	FelineDirInfoSessionStatus      = { fg = "sky", bg = bg }

}

return hlgroups
