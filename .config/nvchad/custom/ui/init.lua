local M = {}

local config = {
	statusline = {
		separator_style = "round",
		overriden_modules = nil,
	},
	tabufline = {
		enabled = true,
		lazyload = true,
		overriden_modules = function()
			return require("custom.ui.tabufline.override")
		end
	}
}
M.statusline = function()
  return require("custom.ui.statusline").run()
end

M.tabufline = function()
  return require("nvchad_ui.tabufline").run(config.tabufline)
end

M.setup = function()
  vim.opt.statusline = "%!v:lua.require('custom.ui').statusline()"

  -- lazyload tabufline
  require("nvchad_ui.tabufline.lazyload")(config.tabufline)
end

return M
