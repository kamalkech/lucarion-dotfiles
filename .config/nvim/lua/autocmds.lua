local api = vim.api
local autocmd = api.nvim_create_autocmd

-- Unlist dap-repl so that it doesn't show on bufferline
autocmd("FileType", {
	pattern = { "dap-repl", "man" },
	callback = function()
		vim.bo.buflisted = false
	end,
})

-- autocmd("OptionSet", {
-- 	pattern = "buftype",
-- })


-- local M = require("lazy_load")
for _, func in pairs(require("lazy_load")) do
	func()
end
