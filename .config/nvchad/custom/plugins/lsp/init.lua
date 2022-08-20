local lspconfig = require("lspconfig")
local utils = require("custom.plugins.lsp.utils")
local custom = require("custom.plugins.lsp.custom")
local capabilities = utils.set_capabilities()

local default_servers = {
	"volar",
	"bashls",
	"ocamllsp",
	"html", "cssls",
}

utils.lsp_handlers()

for _, server_name in pairs(default_servers) do
	lspconfig[server_name].setup({
		on_attach = utils.on_attach,
		capabilities = capabilities
	})
end

local custom_servers = {
	"python",
	"js",
	"lua",
}

for _, server_name in pairs(custom_servers) do
	custom[server_name]()
end

