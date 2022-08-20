return {
	run = function()
		local modules = require("custom.ui.statusline.modules")
		return table.concat({
			modules.invi_sep,
			modules.mode(),
			modules.invi_sep,
			modules.cwd(),
			modules.file_name(),
			modules.git(),
			"%=",
			modules.session_status(),
			"%=",
			modules.lsp_diagnostics(),
			modules.lsp_clients(),
			modules.position(),
			modules.invi_sep,
		})
	end
}
