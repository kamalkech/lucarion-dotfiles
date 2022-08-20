-- from shaun-mathew/Chameleon.nvim/blob/main/change_background.lua

local fn = vim.fn
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup("BackgroundReload", { clear = true })
vim.g.kitty_bg_color = nil

local get_color = function(group, attr)
	return fn.synIDattr(fn.synIDtrans(fn.hlID(group)), attr)
end

local set_kitty_bg = function(color)
	local command = string.format('kitty @ set-colors background="%s"', color)
	vim.schedule(function()
		local handle = io.popen(command)
		if handle ~= nil then
			handle:close()
		end
	end)
end

-- autocmd("User", {
-- 	pattern = "NvChadThemeReload",
-- 	group = augroup,
-- 	callback = function()
-- 		get_kitty_bg()
-- 		local color = get_color("Normal", "bg")
-- 		set_kitty_bg(color)
-- 	end
-- })

autocmd("ColorScheme", {
	group = augroup,
	callback = function()
		local color = get_color("Normal", "bg")
		set_kitty_bg(color)
	end
})

autocmd("VimLeavePre", {
	once = true,
	callback = function()
		if vim.g.kitty_bg_color then
			set_kitty_bg(vim.g.kitty_bg_color)
		end
	end
})

vim.schedule(function()
	require("plenary.job"):new({
		command = "kitty",
		args = {
			"@", "get-colors"
		},
		cwd = "/usr/bin/",
		on_exit = function(ret, _)
			local color = vim.split(ret:result()[4], "%s+")[2]
			vim.g.kitty_bg_color = color
		end
	}):start()
end)
