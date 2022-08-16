--local present, impatient =
vim.schedule(function() pcall(require, "impatient") end)

require("utils")
require("options")
require("autocmds")

vim.schedule(function()
	require("mappings")
	require("commands")
	require("ui.manage_tab")
end)
