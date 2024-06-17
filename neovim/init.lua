-- to avoid any annoying issues with termguicolors and plugins
vim.o.termguicolors = true
-- Handle plugins with lazy.nvim
require("core.lazy")

-- General Neovim keymaps
require("core.keymaps")

-- Options
require("core.options")
