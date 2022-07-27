local M = {}

M.setup = function(_, capabilities)
  local lspconfig = require("lspconfig")
  lspconfig.tsserver.setup({
		init_options = {
			hostInfo = "neovim",
			-- includeInlayParameterNameHints = "all",
		},
    on_attach = function(client, bufnr)
      -- Load LSP mappings on attach to buffer
    end,
		capabilities = capabilities,
  })

  lspconfig.eslint.setup({
    on_attach = function(client, bufnr)
      -- Load LSP mappings on attach to buffer
      require("config.lsp.utils").setkeymaps()
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
      if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({
          group = augroup,
          buffer = bufnr,
        })
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = augroup,
          buffer = bufnr,
          callback = function()
            vim.cmd [[EslintFixAll]]
            vim.lsp.buf.format({ bufnr = bufnr })
          end,
        })
      end
    end,
		capabilities = capabilities
  })
end

return M
