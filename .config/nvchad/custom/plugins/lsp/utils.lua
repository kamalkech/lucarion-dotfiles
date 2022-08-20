local M = {}


M.on_attach = function(client, bufnr)
	-- Load LSP mappings for buffer bufnr
	require("core.utils").load_mappings("lspconfig", {buffer = bufnr})

	if client.server_capabilities.signatureHelpProvider then
		require("nvchad_ui.signature").setup(client)
	end
	-- If the LSP server have format provider
	-- Show diagnostics on move
	-- Really wanna enable this but its too distracting
	-- vim.api.nvim_create_autocmd("CursorHold", {
	-- 	buffer = bufnr,
	-- 	callback = function()
	-- 		local opts = {
	-- 			focusable = false,
	-- 			close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
	-- 			border = "rounded",
	-- 			source = "always",
	-- 			prefix = " ",
	-- 			scope = "line",
	-- 		}
	-- 		vim.diagnostic.open_float(opts)
	-- 	end
	-- })
end

M.set_capabilities = function()
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.textDocument.completion.completionItem = {
		documentationFormat = { "markdown", "plaintext" },
		snippetSupport = true,
		preselectSupport = true,
		insertReplaceSupport = true,
		labelDetailsSupport = true,
		deprecatedSupport = true,
		commitCharactersSupport = true,
		tagSupport = { valueSet = { 1 } },
		resolveSupport = {
			properties = {
				"documentation",
				"detail",
				"additionalTextEdits",
			},
		},
	}
	return capabilities
end

M.lsp_handlers = function()

	local function lspSymbol(name, icon)
		local hl = "DiagnosticSign" .. name
		vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
	end

	lspSymbol("Error", " ")
	lspSymbol("Warn", " ")
	lspSymbol("Info", " ")
	lspSymbol("Hint", "")

	vim.diagnostic.config {
		virtual_text     = false,
		signs            = true,
		underline        = true,
		update_in_insert = false,
		severity_sort    = true,
	}

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "single",
		focusable = false,
	})
	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
		focusable = false,
		relative = "cursor",
	})
	-- suppress error messages from lang servers
	vim.notify = function(msg, log_level)
		if msg:match "exit code" then
			return
		end
		if log_level == vim.log.levels.ERROR then
			vim.api.nvim_err_writeln(msg)
		else
			vim.api.nvim_echo({ { msg } }, true, {})
		end
	end
end


return M

