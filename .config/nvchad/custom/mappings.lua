local M = {}

M.disabled = {

	-- ["j"] = nil, ["k"] = nil,
	-- Normal mode keys
	-- I dont need any of this
	["<S-b>"] = nil,
	["<leader>n"] = nil, ["<leader>rn"] = nil,

	-- Telescope
	["<leader>gt"] = nil,
	-- Lspconfig
	["<leader>ra"] = nil,
	["<leader>f"] = nil, ["<leader>fm"] = nil,
	["<leader>wa"] = nil, ["<leader>wr"] = nil, ["<leader>wl"] = nil,

	-- Insert mode keys
}

M.general = {
	n = {
		["<C-c>"] = {"<cmd>%y+<CR>", "", opts = {silent = true}},
		["<leader>q"] = {"<cmd>q<CR>", ""},
		["j"] = {
			function ()
				   require("accelerated-jk").move_to("j")
			end, "", opts = {expr = false},
		},
		["k"] = {
			function()
				require("accelerated-jk").move_to("k")
			end, ""
		},
		["<A-j>"] = {"<cmd>m+1<CR>==", ""},
		["<A-k>"] = {"<cmd>m-2<CR>==", ""},
		["<leader>rs"] = {
			function ()
				require("persisted").load()
			end, ""
		},
		["<leader>ss"] = {
			function()
				require("persisted").save()
			end, ""
		}
	},
	i = {
		-- Emacs keybind kek
		["<C-a>"] = {"<Home><C-Right>", ""},
		["<C-f>"] = {"<C-Right>", ""},
		["<C-b>"] = {"<C-Left>", ""},
		["jk"] = {"<Esc>", ""},
		["<A-j>"] = {"<Esc><cmd>m+1<CR>==gi", ""},
		["<A-k>"] = {"<Esc><cmd>m-2<CR>==gi", ""},
		["<C-A-v>"] = {"<Esc><cmd>PasteImg<CR>", ""}
	},
	v = {
		[">"] = {">gv", ""},
		["<"] = {"<gv", ""},
		["<A-j>"] = {":m'>+1<CR>==gv", ""},
		["<A-k>"] = {":m'<-2<CR>==gv", ""},
		["j"] = {
			function ()
				   require("accelerated-jk").move_to("j")
			end, "", opts = {expr = false},
		},
		["k"] = {
			function()
				require("accelerated-jk").move_to("k")
			end, ""
		},
	}
}

M.lspconfig = {
	n = {
		["<leader>rn"] = {
			function()
				require("nvchad_ui.renamer").open()
			end, "", opts = { buffer = 0 },
		},
		["<leader>fm"] = {
			function()
				vim.lsp.buf.format({ async = true })
			end, "", opts = { buffer = 0 },
		},
		["<leader>ds"] = {
			function()
				vim.diagnostic.open_float()
			end, "", opts = { buffer = 0 }
		}
	}
}

M.telescope = {
	n = {
		["<leader>gm"] = { '<cmd>Telescope man_pages sections={"ALL"}<CR>', "" },
	}
}

-- M.dap = {
-- 	plugin = true,
-- }

return M
