_G.setkeymaps = function(mappings)
	for mode, maps in pairs(mappings) do
		for lhs, value in pairs(maps) do
			vim.keymap.set(mode, lhs, value.callback, value.opts)
		end
	end
end

_G.lazy = function(plugin, timer)
	vim.defer_fn(function()
		-- pcall(require, "impatient")
		require("packer").loader(plugin)
	end, timer or 0)
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
