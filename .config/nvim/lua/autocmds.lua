local api = vim.api
local autocmd = api.nvim_create_autocmd
vim.defer_fn(function()
	autocmd("User", {
		pattern = "PackerCompileDone",
		group = api.nvim_create_augroup("CatppuccinAutoCompile", {}),
		callback = function()
			require("catppuccin").compile()
			vim.defer_fn(function()
				vim.cmd.colorscheme("catppuccin")
			end, 0)
		end,
	})
end, 0)

-- Unlist dap-repl so that it doesn't show on bufferline
autocmd("FileType", {
	pattern = { "dap-repl" },
	callback = function()
		vim.bo.buflisted = false
	end,
})
