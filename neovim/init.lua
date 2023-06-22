-- Lazy Nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("plugins") -- Plugins
require("settings") -- General settings
require("aesthetics") -- Aesthetic configuration
require("keybindings") -- Keybindings, mapped keys & such
require("treesitter") -- Treesitter
require("lsp") -- LSP
require("completion") -- Auto-completion
require("autopairs") -- Auto pairs settings
require("twilight-config") -- Twilight dim code sections
require("zenmode-config") -- Twilight dim code sections
require("indent-blankline-config") -- vertical lines config
require("gitsigns-config") -- git signs config
require("neorg-config") -- work in neorg config
require("penvim-config") -- additional indent configs
require("debugger") -- Debugger, neotest settings
