local api = vim.api
local autocmd = api.nvim_create_autocmd

-- Unlist dap-repl so that it doesn't show on bufferline
autocmd("FileType", {
	pattern = { "dap-repl", "man" },
	callback = function()
		vim.bo.buflisted = false
	end,
})

autocmd("User", {
	group = api.nvim_create_augroup("PackerCompileCatppuccin", { clear = true }),
	pattern = "PackerCompileDone",
	callback = function()
		vim.g.loaded_telescope = 0
		require("catppuccin").compile()
		vim.defer_fn(function() vim.cmd("colorscheme catppuccin") end, 0)
	end
})

autocmd("BufWritePost", {
	group = api.nvim_create_augroup("AutoCompileCatppuccin", {}),
	pattern = {
		vim.fn.stdpath("config") .. "/lua/ui/catppuccin.lua",
		vim.fn.stdpath("config") .. "/lua/ui/highlights/*",
	},
	callback = function()
		require("plenary.reload").reload_module("ui.highlight")
		require("plenary.reload").reload_module("ui.catppuccin")
		require("ui.catppuccin")
		vim.cmd [[silent lua require("catppuccin").compile()]]
		vim.defer_fn(function() vim.cmd("colorscheme catppuccin") end, 0)
	end
})

for _, func in pairs(require("lazy_load")) do
	func()
end
