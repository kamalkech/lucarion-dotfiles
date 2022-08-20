local M = {}

M.override = {
	["NvChad/ui"] = {
		statusline = {
			separator_style = "round",
		}
	},
	["lewis6991/gitsigns.nvim"] = {
		current_line_blame = true,
		current_line_blame_opts = {
			delay = 400,
		},
		max_file_length = 10000,
	},
	["kyazdani42/nvim-tree.lua"]
}

M.user = {
	--------------Plugins not in NvChad-----------------------
	-- Useful
	["antoinemadec/FixCursorHold.nvim"] = {},
	["rainbowhxch/accelerated-jk.nvim"] = {},
	["olimorris/persisted.nvim"] = {
		module = "persisted",
		config = function()
			require("custom.plugins.misc").persisted()
		end
	},
	-- LSP for specific filetypes
	["p00f/clangd_extensions.nvim"] = { 
		ft = {"c", "cpp", "objc", "objcpp"},
		config = function()
			require("custom.plugins.lsp.custom").clangd()
		end
	},
	["mfussenegger/nvim-jdtls"] = { opt = true },
	-- LSP extension
	["zbirenbaum/neodim"] = {
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
	["jose-elias-alvarez/null-ls.nvim"] = {
		after = "nvim-lspconfig",
		-- config = function()
		-- 	require("custom.plugins.lsp.null-ls")
		-- end,
	},
	-- Entirety of Nvim-Dap

	--------------Plugins in NvChad---------------------------
	["neovim/nvim-lspconfig"] = {
		opt = true,
		setup = function()
			require("core.lazy_load").lazy_load({
				plugin = "nvim-lspconfig",
				events = "UIEnter",
				condition = function() return true end,
				augroup_name = "LazyLoadLSPConfig",
			})
		end,
		config = function()
			require("custom.plugins.lsp")
		end
	},
	-- 	config = function()
	-- 		require("custom.plugins.lsp")
	-- 	end
	-- },
	-- ["kyazdani42/nvim-tree.lua"] = {
		-- config = function()
		-- 	require("custom.plugins.misc").nvimtree()
		-- end
	-- },
	-- ["nvim-telescope/telescope.nvim"] = {
	-- 	config = function()
	-- 		require("custom.plugins.misc").telescope()
	-- 	end,
	-- },
	["ekickx/clipboard-image.nvim"] = {
		cmd = "PasteImg",
		config = function()
			require("custom.plugins.misc").clip_image()
		end
	},
	--------------Plugins in NvChad ends here------------------
}

return M
