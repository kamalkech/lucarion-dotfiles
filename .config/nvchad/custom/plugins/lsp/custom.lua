local M = {}

local lspconfig = require("lspconfig")
local attach, capabilities = require("custom.plugins.lsp.utils").on_attach, require("custom.plugins.lsp.utils").set_capabilities()

M.lua = function()
	lspconfig.sumneko_lua.setup({
		on_attach = attach,
		capabilities = capabilities,
		settings = {
			Lua = {
				telemetry = {
					enable = false
				}
			}
		}
	})
end

M.python = function()
	lspconfig.pyright.setup({
		on_attach = attach,
		capabilities = capabilities,
		settings = {
			python = {
				analysis = {
					typeCheckingMode = "basic",
				}
			}
		}
	})
end

M.js = function()
	lspconfig.tsserver.setup({
		init_options = {
			hostInfo = "neovim",
		},
		on_attach = attach,
		capabilities = capabilities,
	})
end

M.clangd = function()
	if vim.g.loaded_clangd then
		return
	end
	vim.g.loaded_clangd = true
	local custom_capabilities = capabilities
	custom_capabilities.offsetEncoding = "utf-16"
	require("clangd_extensions").setup({
		server = {
			cmd = {
				"clangd",
				"--background-index",
				"--offset-encoding=utf-16", -- temporary fix to stop null-ls
				"--enable-config",
				"--completion-style=detailed",
				"--clang-tidy",
				"--all-scopes-completion",
				"--pch-storage=memory",
				"--suggest-missing-includes",
			},
			-- args = {
			-- },
			on_attach = attach,
			capabilities = custom_capabilities,
			flags = {
				debounce_text_changes = 150,
			},
		},
		extensions = {
			autosetHint = true,
			inlay_hints = {
				highlight = "DiagnosticInfo",
			},
			ast = {
				type = "",
			},
		}
	})
end

return M
