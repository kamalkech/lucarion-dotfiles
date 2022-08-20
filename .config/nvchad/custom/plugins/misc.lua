local M = {}

M.signature = function()
	local present, lsp_signature = pcall(require, "lsp_signature")
	if not present then
		return
	end
	local options = {
		bind = true,
		doc_lines = 20,
		floating_window = true,
		floating_window_above_cur_line = false,
		check_completion_visible = true,
		-- always_trigger = true,
		fix_pos = false,
		hint_enable = true,
		hint_prefix = " ",
		hint_scheme = "String",
		hi_parameter = "Search",
		max_height = 15,
		max_width = 80, -- max_width of signature floating_window, line will be wrapped if exceed max_width
		handler_opts = {
			border = "single", -- double, single, shadow, none
		},
		zindex = 200, -- by default it will be on top of all floating windows, set to 50 send it to bottom
		padding = "", -- character to pad on left and right of signature can be ' ', or '|'  etc
	}
	lsp_signature.setup(options)
end

M.autopairs = function()
	local present1, autopairs = pcall(require, "nvim-autopairs")
	local present2, cmp = pcall(require, "cmp")

	if not present1 and present2 then
		return
	end
	local options = {
		fast_wrap = {},
		disable_filetype = { "TelescopePrompt", "vim" },
	}


	autopairs.setup(options)
	local cmp_autopairs = require "nvim-autopairs.completion.cmp"

	---@diagnostic disable-next-line: need-check-nil
	cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
end

M.clip_image = function()
	local present, clipboard_image = pcall(require, "clipboard-image")
	if not present then
		return
	end
	clipboard_image.setup {
		default = {
			img_dir = { "%:p:h", "img" },
			img_name = function()
				return os.date("%y-%m-%d-%H-%M-%S")
			end,
		},
		markdown = {
			img_handler = function(img)
				vim.cmd "normal! f[a"
			end
		}
	}
end

M.comment = function()
	local present, Comment = pcall(require, "Comment")

	if not present then
		return
	end
	Comment.setup({
		extra = {
			eol = "gca",
		}
	})
end

M.todo_highlight = function()
	local present, todo_comments = pcall(require, "todo-comments")
	if not present then
		return
	end

	todo_comments.setup({

		signs = true, -- show icons in the signs column
		sign_priority = 8, -- sign priority
		-- keywords recognized as todo comments
		keywords = {
			FIX = {
				icon = " ", -- icon used for the sign, and in search results
				color = "error", -- can be a hex color, or a named color (see below)
				alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
				-- signs = false, -- configure signs for some keywords individually
			},
			TODO = { icon = " ", color = "info" },
			HACK = { icon = " ", color = "warning" },
			WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
			PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
			NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
		},
		merge_keywords = true, -- when true, custom keywords will be merged with the defaults
		-- highlighting of the line containing the todo comment
		-- * before: highlights before the keyword (typically comment characters)
		-- * keyword: highlights of the keyword
		-- * after: highlights after the keyword (todo text)
		highlight = {
			before = "", -- "fg" or "bg" or empty
			keyword = "wide", -- "fg", "bg", "wide" or empty.
			after = "fg", -- "fg" or "bg" or empty
			pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlightng (vim regex)
			comments_only = true, -- uses treesitter to match keywords in comments only
			-- max_line_len = 400, -- ignore lines longer than this
			exclude = {
				"NvimTree",
				"alpha",
				"vim", "lspinfo",
				"help",
				"packer",
				"toggleterm",
				"dashboard",
			}, -- list of file types to exclude highlighting
		},
		-- list of named colors where we try to extract the guifg from the
		-- list of hilight groups or use the hex color if hl not found as a fallback
		colors = {
			error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
			warning = { "DiagnosticWarning", "WarningMsg", "#FBBF24" },
			info = { "DiagnosticInfo", "#2563EB" },
			hint = { "DiagnosticHint", "#10B981" },
			default = { "Identifier", "#7C3AED" },
		},
		search = {
			command = "rg",
			args = {
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
			},
			-- regex that will be used to match keywords.
			-- don't replace the (KEYWORDS) placeholder
			pattern = [[\b(KEYWORDS):]], -- ripgrep regex
			-- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
		},
	})
end

M.gitsigns = function()
	local present, gitsigns = pcall(require, "gitsigns")

	if not present then
		return
	end


	local options = {
		signs = {
			add = { hl = "DiffAdd", text = "│", numhl = "GitSignsAddNr" },
			change = { hl = "DiffChange", text = "│", numhl = "GitSignsChangeNr" },
			delete = { hl = "DiffDelete", text = "", numhl = "GitSignsDeleteNr" },
			topdelete = { hl = "DiffDelete", text = "‾", numhl = "GitSignsDeleteNr" },
			changedelete = { hl = "DiffChangeDelete", text = "~", numhl = "GitSignsChangeNr" },
		},
		sign_priority = 0,
		current_line_blame = true,
		current_line_blame_opts = {
			delay = 400,
		},
		max_file_length = 10000,
	}

	gitsigns.setup(options)
end

M.luasnip = function()
	local present, luasnip = pcall(require, "luasnip")
	if not present then
		return
	end

	local options = {
		history = true,
		updateevents = "TextChanged,TextChangedI",
	}

	luasnip.config.set_config(options)
	require("luasnip.loaders.from_vscode").lazy_load()
	require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.g.luasnippets_path, } })

	vim.api.nvim_create_autocmd("InsertLeave", {
		callback = function()
			if require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
					and not require("luasnip").session.jump_active
			then
				require("luasnip").unlink_current()
			end
		end,
	})

end

M.blankline = function()
	require("indent_blankline").setup({
		filetype_exclude = {
			"help",
			"terminal",
			"alpha",
			"dashboard",
			"packer",
			"qf",
			"lspinfo",
			"mason",
			"TelescopePrompt",
			"TelescopeResults",
		},
		buftype_exclude = {
			"terminal",
			"help",
			"nofile",
		},
		show_trailing_blankline_indent = false,
		show_current_context = true,
		show_first_indent_level = false,
		char_highlight_list = {
			-- "IndentBlanklineIndent1",
			-- "IndentBlanklineIndent2",
			-- "IndentBlanklineIndent3",
			-- "IndentBlanklineIndent4",
			-- "IndentBlanklineIndent5",
			-- "IndentBlanklineIndent6",
		}
	})
end

M.persisted = function()
	require("persisted").setup({
		use_git_branch = true,
		save_dir = vim.fn.expand(vim.fn.stdpath("data") .. "/sessions/"),
		allowed_dirs = {
			"~/Desktop",
			"~/dotfiles",
			"~/.config",
			"~/work",
		},
		before_save = function()
			if package.loaded["nvim-tree"] then
				vim.api.nvim_command("NvimTreeClose")
			end
			local bufs = vim.api.nvim_list_bufs()
			for _, buf_id in pairs(bufs) do
				if vim.api.nvim_buf_get_option(buf_id, "buftype") == "terminal" then
					vim.api.nvim_buf_delete(buf_id, { force = true })
				end
			end
		end
	})
end

M.nvimtree = function()
	vim.g.nvimtree_side = "left"
	require("base46").load_highlight("nvimtree")
	require("nvim-tree").setup({
		create_in_closed_folder = true,
		filters = {
			dotfiles = false,
			custom = {
				"node_modules",
				".git",
				".github",
				-- "^plugin/*_compiled.*",
			},
			exclude = {
				".gitignore",
			}
		},
		disable_netrw = true,
		hijack_netrw = true,
		ignore_ft_on_setup = { "alpha", "dashboard", "aerial" },
		open_on_setup = false,
		open_on_setup_file = false,
		open_on_tab = false,
		sort_by = "extension",
		hijack_cursor = false,
		hijack_unnamed_buffer_when_opening = false,
		update_cwd = true,
		update_focused_file = {
			enable = true,
			update_cwd = false,
		},
		view = {
			side = "left",
			-- adaptive_size = true,
			-- centralize_selection = true,
			width = 25,
			hide_root_folder = false,
			preserve_window_proportions = false,
			signcolumn = "yes",
		},
		git = {
			enable = true,
			ignore = false,
			timeout = 500,
		},
		diagnostics = {
			enable = false,
			show_on_dirs = true,
			debounce_delay = 200,
			icons = {
				hint = " ",
				error = " ",
				info = " ",
				warning = " ",
			},
		},
		filesystem_watchers = {
			enable = true,
			debounce_delay = 100,
		},
		actions = {
			open_file = {
				resize_window = false,
			},
			change_dir = {
				restrict_above_cwd = true,
				-- global = true,
			}
		},
		renderer = {
			group_empty = true,
			highlight_git = false,
			highlight_opened_files = "all",
			root_folder_modifier = table.concat { ":t:gs?$?/..", string.rep(" ", 1000), "?:gs?^??" },
			indent_markers = {
				enable = true,
			},
			icons = {
				show = {
					file = true,
					folder = true,
					folder_arrow = false,
					git = true,
				},
				padding = "",
				glyphs = {
					default = "",
					symlink = "",
					git = {
						deleted = "",
						ignored = "◌",
						renamed = "➜",
						staged = "✓",
						unmerged = "",
						unstaged = "✗",
						untracked = "★",
					},
					folder = {
						default = "",
						empty = "",
						empty_open = "",
						open = "",
						symlink = "",
						symlink_open = "",
						arrow_open = "",
						arrow_closed = "",
					},
				}
			},
			special_files = {
				"Cargo.toml", "Makefile", "README.md", "readme.md", "OMakefile",
			}
		},
	})
end

M.telescope = function()
	local telescope = require("telescope")
	vim.g.theme_switcher_loaded = true
	require("base46").load_highlight("telescope")
	telescope.setup({
		defaults = {
			vimgrep_arguments = {
				"rg",
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--smart-case",
				"--trim",
			},
			prompt_prefix = "   ",
			selection_caret = "  ",
			entry_prefix = "  ",
			initial_mode = "insert",
			selection_strategy = "reset",
			sorting_strategy = "ascending",
			layout_strategy = "horizontal",
			layout_config = {
				horizontal = {
					prompt_position = "top",
					preview_width = 0.55,
					results_width = 0.8,
				},
				vertical = {
					mirror = false,
				},
				width = 0.80,
				height = 0.80,
				-- preview_cutoff = 120,
			},
			file_ignore_patterns = { "node_modules", "packer_compiled", "LICENSE" },
			path_display = { "truncate" },
			winblend = 0,
			border = {},
			borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
			color_devicons = true,
			set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
			mappings = {
				n = { ["q"] = require("telescope.actions").close },
			},
		},
		extensions = {
			fzf = {
				fuzzy = true,
				override_generic_sorter = true,
				override_file_sorter = true,
				case_mode = "smart_case",
			}
		}
	})
	local extensions = { "fzf", "themes" }
	for _, ext in pairs(extensions) do
		telescope.load_extension(ext)
	end
end

return M
