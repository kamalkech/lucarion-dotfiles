local present, packer = pcall(require, "packer")

if not present then
	return
end

packer.init {
	auto_clean = true,
	auto_reload_recomplied = true,
	compile_on_sync = true,
	disable_commands = true,
	git = { clone_timeout = 6000 },
	-- profile = {
	-- 	enable = true,
	-- 	threshold = 0,
	-- },
	display = {
		working_sym = "ﲊ",
		error_sym = "✗",
		done_sym = "﫟",
		removed_sym = "",
		moved_sym = "",
		open_fn = function()
			return require("packer.util").float { border = "rounded" }
		end,
	},
}

local plugin_list = {
	{ "lewis6991/impatient.nvim" },
	{ "wbthomason/packer.nvim" },
	{ "nvim-lua/plenary.nvim" },

	{
		"antoinemadec/FixCursorHold.nvim",
		-- opt = true,
		setup = function()
			vim.g.cursorhold_updatetime = 100
			-- vim.api.nvim_create_autocmd("VimEnter", {
			-- 	once = true,
			-- 	callback = function() lazy("FixCursorHold.nvim") end,
			-- })
		end,
	},
	-- Theme
	{
		"catppuccin/nvim",
		-- opt = true,
		as = "theme",
		-- run = ":CatppuccinCompile",
		config = function()
			require("ui.catppuccin")
		end,
		-- setup = function()
		-- 	lazy("theme")
		-- end,
	},
	{
		"olimorris/persisted.nvim",
		event = "BufReadPre",
		module = "persisted",
		config = function()
			require("config.misc").sessions()
		end,
	},
	{ "kyazdani42/nvim-web-devicons", after = "theme" },
	-- Statusline
	{
		"feline-nvim/feline.nvim",
		opt = true,
		-- after = "nvim-web-devicons",
		config = function()
			require("ui.feline").statusline()
		end,
		setup = function()
			require("lazy_load").statusline()
		end,
	},
	-- Bufferline
	{
		"akinsho/bufferline.nvim",
		opt = true,
		config = function()
			require("ui.bufferline")
		end,
		setup = function()
			require("lazy_load").bufferline()
		end,
	},


	-- Treesitter and its related plugins
	{
		"lukas-reineke/indent-blankline.nvim",
		opt = true,
		-- after = "nvim-treesitter",
		config = function()
			require("indent_blankline").setup({
				filetype_exclude = {
					"help",
					"terminal",
					"alpha",
					"dashboard",
					"packer",
					"qf",
					"lspinfo",
					"TelescopePrompt",
					"TelescopeResults",
				},
				buftype_exclude = {
					"terminal",
					"help",
					"nofile",
				},
				show_trailing_blankline_indent = false,
				show_first_indent_level = false,
				show_current_context = true,
			})
		end,
		setup = function()
			require("lazy_load").blankline()
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		event = "BufReadPre",
		run = ":TSUpdate",
		config = function()
			require("config.treesitter").setup()
		end,
	},


	-- LSP time
	-- LSP + DAP + Null-ls Installer
	{
		"williamboman/mason.nvim",
		-- opt = true,
		-- cmd = {"Mason", "MasonLog", "MasonInstall", "MasonUninstall", "MasonUninstallAll"},
		config = function()
			require("config.mason").setup()
		end,
		-- setup = function()
		-- 	require("lazy_load").mason()
		-- end,
	},
	-- {
	-- 	"williamboman/mason-lspconfig.nvim",
	-- 	opt = true,
	-- 	config = function()
	-- 		require("config.mason").lsp()
	-- 	end,
	-- 	setup = function()
	-- 		require("lazy_load").mason_lsp()
	-- 	end,
	-- },
	-- LSPconfig itself
	{
		"neovim/nvim-lspconfig",
		-- after = "mason.nvim",
		opt = true,
		config = function()
			require("config.lsp").setup()
		end,
		setup = function()
			require("lazy_load").lsp()
		end,
	},
	{
		"zbirenbaum/neodim",
		event = "LspAttach",
		config = function()
			require("neodim").setup({
				alpha = 0.75,
				hide = {
					virtual_text = true,
					underline = true,
					signs = false,
				}
			})
		end,
	},
	{
		"glepnir/lspsaga.nvim",
		event = "LspAttach",
		module = "lspsaga",
		config = function()
			require("config.lsp.lspsaga")
		end,
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		after = "nvim-lspconfig",
		opt = true,
		config = function()
			require("config.lsp.null-ls").setup()
		end,
	},
	{
		"folke/trouble.nvim",
		opt = true,
		module = "trouble",
		config = function()
			require("config.lsp.trouble").setup()
		end,
	},
	-- Addtional functionalities for clangd
	{
		"p00f/clangd_extensions.nvim",
		opt = true,
		ft = { "c", "cpp", "objc", "objcpp" },
		module = "clangd_extensions",
		config = function()
			require("config.lsp.clangd").setup()
		end
	},

	-- tree
	{
		"kyazdani42/nvim-tree.lua",
		cmd = { "NvimTreeToggle", "NvimTreeFocus" },
		config = function()
			require("config.nvimtree").setup()
		end,
	},

	-- Cmp and its related plugins
	{
		"rafamadriz/friendly-snippets",
		module = "cmp",
		event = "InsertEnter",
	},
	{
		"hrsh7th/nvim-cmp",
		after = "friendly-snippets",
		config = function()
			require("config.cmp")
		end,
	},
	{
		"L3MON4D3/LuaSnip",
		after = "nvim-cmp",
		config = function()
			require("config.misc").luasnip()
		end,
	},
	{ "saadparwaiz1/cmp_luasnip", after = "LuaSnip" },
	{ "hrsh7th/cmp-nvim-lua", after = "LuaSnip", },
	{ "hrsh7th/cmp-nvim-lsp", after = "LuaSnip", },
	{ "hrsh7th/cmp-buffer", after = "LuaSnip", },
	{ "hrsh7th/cmp-path", after = "LuaSnip", },
	-- { "hrsh7th/cmp-nvim-lsp-signature-help", after = "cmp_luasnip", },
	{
		"windwp/nvim-autopairs",
		after = "nvim-cmp",
		config = function()
			require("config.misc").autopairs()
		end,
	},

	-- Telescope start
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		config = function()
			require("config.telescope").setup()
		end,
		-- setup = function()
		--   require("config.telescope").setkeys()
		-- end,
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		after = "telescope.nvim",
		run = "make",
		config = function()
			require("telescope").load_extension("fzf")
		end,
	},
	-- Telescope end

	-- DAP and its related plugins
	{
		"mfussenegger/nvim-dap",
		-- opt = true,
		module = "dap",
		config = function()
			require("config.dap").setup()
		end,
		setup = function()
			require("lazy_load").dap()
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		after = "nvim-dap",
		config = function()
			require("config.dap.ui")
		end
	},
	{
		"theHamsta/nvim-dap-virtual-text",
		after = "nvim-dap",
		config = function()
			require("config.dap.virtual_text")
		end,
	},
	{
		"rcarriga/cmp-dap",
		opt = true,
		ft = {"dap-repl", "dapui_watches"},
		after = "nvim-dap",
		requires = "hrsh7th/nvim-cmp",
	},

	-- Misc
	{
		"numToStr/Comment.nvim",
		module = "Comment",
		keys = { "gc", "gb" },
		config = function()
			require("config.misc").comment()
		end,
	},
	{
		"xiyaowong/accelerated-jk.nvim",
		config = function() require("accelerated-jk").setup() end,
	},
	{
		"lewis6991/gitsigns.nvim",
		opt = true,
		module = "gitsigns",
		config = function()
			require("config.misc").gitsigns()
		end,
		setup = function()
			require("lazy_load").gitsigns()
		end,
	},

	-- Colorizer
	{
		"norcalli/nvim-colorizer.lua",
		opt = true,
		config = function()
			require("colorizer").setup()
		end,
		setup = function()
			lazy("nvim-colorizer.lua")
		end,
	},

	-- Clipboard image
	{
		"ekickx/clipboard-image.nvim",
		opt = true,
		cmd = "PasteImg",
		config = function()
			require("config.misc").clip_image()
		end,
	},
}

packer.startup(function(use)
	for _, plugin in pairs(plugin_list) do
		use(plugin)
	end
end)
