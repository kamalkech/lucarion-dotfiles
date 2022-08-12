_G.setkeymaps = function(mappings)
	for mode, maps in pairs(mappings) do
		for lhs, opt in pairs(maps) do
			vim.keymap.set(mode, lhs, opt.callback, opt.opts)
		end
	end
end

_G.lazy = function(plugin, timer)
	if plugin then
		timer = timer or 0
		vim.defer_fn(function()
			require("packer").loader(plugin)
		end, timer)
	end
end

local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	print("cloning packer...")
	fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
	vim.cmd.packadd("packer.nvim")
	require("config")
	require("packer").sync()
end
