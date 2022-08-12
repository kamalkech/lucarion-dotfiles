local present, impatient = pcall(require, "impatient")

require("options")
require("autocmds")
require("utils")

vim.schedule(function()
	require("mappings")
	require("commands")
	require("ui.manage_tab")
end)
