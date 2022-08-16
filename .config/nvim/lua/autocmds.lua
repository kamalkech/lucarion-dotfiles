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
		reload_theme_auto()
	end
})

autocmd("BufWritePost", {
	group = api.nvim_create_augroup("AutoCompileCatppuccin", { clear = true }),
	pattern = {
		vim.fn.stdpath("config") .. "/lua/ui/catppuccin.lua",
		vim.fn.stdpath("config") .. "/lua/ui/highlights/*",
	},
	callback = function()
		reload_theme_auto()
	end
})

-- for _, func in pairs(require("lazy_load")) do
-- 	func()
-- end
