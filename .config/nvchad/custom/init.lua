local opt, g, fn = vim.opt, vim.g, vim.fn

opt.expandtab = false
opt.sessionoptions = "buffers,curdir,folds,winpos,tabpages"
-- Wrap, linebreak settings
opt.wrap = false
opt.linebreak = true
opt.breakindent = true
-- opt.cmdheight = 0
opt.timeoutlen = 250

opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldminlines = 4

g.cursorhold_updatetime = 100
g.loaded_clangd = false
g.loaded_jdtls = false
-- Managing python files
if fn.exists("$VIRTUAL_ENV") == 1 then
	g.python3_host_prog = fn.substitute(fn.system("which -a python3 | head -n2 | tail -n1"), "\n", "", "g")
else
	g.python3_host_prog = fn.substitute(fn.system("which python3"), "\n", "", "g")
end

local enabled_providers = {
	"node_provider",
	"python3_provider",
}
for _, provider in pairs(enabled_providers) do
	g["loaded_" .. provider] = nil
	vim.cmd("runtime " .. provider)
end
