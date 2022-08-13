local M = {}

local b = vim.b
local fn = vim.fn
local lsp_severity = vim.diagnostic.severity

-- local colors  = require("catppuccin.palettes").get_palette()
-- local ucolors = require("catppuccin.utils.colors")
-- local latte   = require("catppuccin.palettes.latte")

local lsp_provider = require("feline.providers.lsp")

local icons = {
	left_separator = "",
	right_separator = "",
	bar = "█",
	mode_icon = " ",
}
local mode_alias = {
	['n']    = { "NORMAL", "FelineNormalMode" },
	['niI']  = { "NORMAL", "FelineNormalMode" },
	['niR']  = { "NORMAL", "FelineNormalMode" },
	['niV']  = { "NORMAL", "FelineNormalMode" },
	['no']   = { "N-PENDING", "FelineOpMode" },
	['nov']  = { "N-PENDING", "FelineOpMode" },
	['noV']  = { "N-PENDING", "FelineOpMode" },
	['no']  = { "N-PENDING", "FelineOpMode" },
	['v']    = { "VISUAL", "FelineVisualMode" },
	['vs']   = { "VISUAL", "FelineVisualMode" },
	['V']    = { "V-LINE", "FelineVisualMode" },
	['Vs']   = { "V-LINE", "FelineVisualMode" },
	['']    = { "V-BLOCK", "FelineVisualMode" },
	['s']   = { "V-BLOCK", "FelineVisualMode" },
	['s']    = { "SELECT", "FelineSelectMode" },
	['S']    = { "S-LINE", "FelineSelectMode" },
	['']    = { "S-BLOCK", "FelineSelectMode" },
	['R']    = { "REPLACE", "FelineReplaceMode" },
	['Rc']   = { "REPLACE", "FelineReplaceMode" },
	['Rx']   = { "REPLACE", "FelineReplaceMode" },
	['Rv']   = { "V-REPLACE", "FelineReplaceMode" },
	['i']    = { "INSERT", "FelineInsertMode" },
	['ic']   = { "INSERT", "FelineInsertMode" },
	['ix']   = { "INSERT", "FelineInsertMode" },
	['c']    = { "COMMAND", "FelineCommandMode" },
	['cv']   = { "COMMAND", "FelineCommandMode" },
	['ce']   = { "COMMAND", "FelineCommandMode" },
	['r']    = { "ENTER", "FelinePromptMode" },
	['rm']   = { "MORE", "FelineMoreMode" },
	['r?']   = { "CONFIRM", "FelineConfirmMode" },
	['!']    = { "SHELL", "FelineShellMode" },
	['t']    = { "TERMINAL", "FelineTerminalMode" },
	['nt']   = { "TERMINAL", "FelineTerminalMode" },
	['null'] = { "NONE", "FelineNoneMode" },
}

local get_git_status = function(opts)
	if not b.gitsigns_head or b.gitsigns_git_status then
		return false
	end
	local enabled = false
	opts = opts or { "added", "changed", "removed" }
	local git_status = b.gitsigns_status_dict
	for _, status in pairs(opts) do
		enabled = enabled or (git_status[status] and git_status[status] > 0)
	end
	return enabled
end


local invi_sep = {
	provider = " ",
	hl = "FelineInviSep"
}

local vi = {
	left_sep = {
		provider = icons.left_separator,
		hl = function() return mode_alias[fn.mode()][2] .. "Sep" end
	},
	right_sep = {
		provider = icons.right_separator,
		hl = function() return mode_alias[fn.mode()][2] .. "Sep" end
	},
	vi_mode = {
		provider = function()
			return icons.mode_icon .. " " .. mode_alias[fn.mode()][1] .. " "
		end,
		hl = function() return mode_alias[fn.mode()][2] end,
	}
}

local git = {
	left_sep = {
		provider = icons.left_separator,
		enabled = function() return get_git_status() end,
		hl = "FelineInviSep",
	},
	right_sep = {
		provider = icons.right_separator,
		enabled = function() return get_git_status() end,
		hl = "FelineInviSep",
	},
	branch = {
		provider = "git_branch",
		hl = "FelineGitBranch",
		icons = "  ",
	},
	added = {
		provider = "git_diff_added",
		hl = "FelineGitAdded",
	},
	changed = {
		provider = "git_diff_changed",
		hl = "FelineGitChanged",
	},
	removed = {
		provider = "git_diff_removed",
		hl = "FelineGitRemoved",
	},
}

local lsp = {
	progress = {
		provider = function()
			local Lsp = vim.lsp.util.get_progress_messages()[1]
			if Lsp then
				local msg = Lsp.message or ""
				local percentage = Lsp.percentage or 0
				local title = Lsp.title or ""
				local spinners = {
					"",
					"",
					"",
				}
				local success_icon = {
					"",
					"",
					"",
				}

				local ms = vim.loop.hrtime() / 1000000
				local frame = math.floor(ms / 120) % #spinners

				if percentage >= 80 then
					return string.format(" %%<%s %s %s (%s%%%%) ", success_icon[frame + 1], title, msg, percentage)
				end

				return string.format(" %%<%s %s %s (%s%%%%) ", success_icon[frame + 1], title, msg, percentage)
			end

			return ""
		end,
		--enabled = is_enabled(shortline, 0, 80),
		hl = "FelineLSPProgress",
	},
	client = {
		provider = function()
			local clients = {}
			for _, client in pairs(vim.lsp.get_active_clients()) do
				if client.attached_buffers[vim.api.nvim_get_current_buf()] then
					table.insert(clients, client.name)
				end
			end
			local name = table.concat(clients, ",")
			return name
		end,
		--enabled = is_enabled(shortline, 0, 100),
		hl = "FelineLSPClient",
	},
	errors = {
		provider = "diagnostic_errors",
		enabled = function() return lsp_provider.diagnostics_exist(lsp_severity.ERROR) end,
		hl = "FelineLSPErrors",
		icon = "   ",
	},
	warnings = {
		provider = "diagnostic_warnings",
		enabled = function() return lsp_provider.diagnostics_exist(lsp_severity.WARN) end,
		hl = "FelineLSPWarnings",
		icon = "   ",
	},
	hints = {
		provider = "diagnostic_hints",
		enabled = function() return lsp_provider.diagnostics_exist(lsp_severity.HINT) end,
		hl = "FelineLSPHints",
		icon = " ﯧ ",
	},
	infos = {
		provider = "diagnostic_info",
		enabled = function() return lsp_provider.diagnostics_exist(lsp_severity.INFO) end,
		hl = "FelineLSPInfo",
		icon = "   ",
	},
}

local file_info = {
	left_sep = {
		provider = icons.left_separator,
		hl = "FelineFileInfoSep",
	},
	right_sep = {
		provider = icons.right_separator,
		hl = "FelineFileInfoSep",
	},
	line_percentage = {
		provider = function()
			local current_line = fn.line(".")
			local total_line = fn.line("$")

			if current_line == 1 then
				return " Top "
			elseif current_line == fn.line("$") then
				return " Bot "
			end
			local result, _ = math.modf((current_line / total_line) * 100)
			return " " .. result .. "%% "
		end,
		hl = "FelineFileInfoPercentage",
	},
	position = {
		provider = function()
			local line, col = unpack(vim.api.nvim_win_get_cursor(0))
			local line_text = vim.api.nvim_get_current_line()
			-- Get the text before the cursor in the current line
			local before_cursor = line_text:sub(1, col)
			-- Replace tabs with the equivalent amount of spaces according to the value of 'tabstop'
			before_cursor = before_cursor:gsub("\t", string.rep(" ", vim.bo.tabstop))
			-- Turn col from byteindex to column number and make it start from 1
			col = vim.str_utfindex(before_cursor) + 1
			return string.format("%-3d:%3d", line, col)
		end,
		enabled = function() return fn.expand("%") ~= "" end,
		hl = "FelineFileInfoPosition",
	},
}

local dir_info = {
	dirname = {
		provider = function()
			local dir_name = fn.fnamemodify(vim.fn.getcwd(), ":t")
			return "  " .. dir_name .. " "
		end,
		hl = "FelineDirInfoDirectory",
		left_sep = {
			str = icons.left_separator,
			hl = "FelineDirInfoDirectorySepNoFile",
		},
		right_sep = {
			str = icons.right_separator,
			hl = function()
				return fn.expand("%") == ""
						and "FelineDirInfoDirectorySepNoFile"
						or "FelineDirInfoDirectorySep"
			end
		},
	},
	current_filename = {
		provider = function()
			local filename = fn.expand("%:t")
			local extension = fn.expand("%:e")
			local icon = require("nvim-web-devicons").get_icon(filename, extension)
			icon = icon ~= nil and icon or " "
			return " " .. icon .. " " .. filename .. " "
		end,
		enabled = function()
			return fn.expand("%") ~= ""
		end,
		hl = "FelineDirInfoFilename",
		right_sep = {
			str = icons.right_separator,
			hl = "FelineDirInfoFilenameSep",
		}
	},
	session_status = {
		provider = function()
			if vim.g.persisting == true then
				return " "
			else
				return " "
			end
		end,
		-- enabled = function() return vim.g.persisting ~= nil end,
		hl = "FelineDirInfoSessionStatus"
	},
}

M.statusline = function()
	require("feline").setup({
		components = {
			active = {
				{ -- Left components
					invi_sep,
					vi.left_sep, vi.vi_mode, vi.right_sep,
					invi_sep,
					dir_info.dirname, dir_info.current_filename,
					--invi_sep,
					invi_sep, git.branch, git.added, git.changed, git.removed, invi_sep,
					--invi_sep,
				},
				{ -- Middle components
					dir_info.session_status, invi_sep,
					lsp.progress,
				},
				{ -- Right components
					invi_sep,
					lsp.errors, lsp.warnings, lsp.infos, lsp.hints,
					invi_sep,
					lsp.client,
					invi_sep,
					file_info.left_sep, file_info.position, file_info.right_sep,
					invi_sep,
				}
			},
			inactive = {}
		}
	})
end

M.setup = function()
	M.statusline()
end

return M
