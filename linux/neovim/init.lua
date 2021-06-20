vim.o.smarttab = true -- Smart Tab
vim.o.expandtab = true -- Expand tab to spaces (use spaces on tab)
vim.o.cursorline = true -- Set cursorline in file
vim.o.autoindent = true -- Auto Indent
vim.o.smartindent = true -- Smart Indent
vim.o.clipboard = 'unnamed,unnamedplus' -- System clipboard used
vim.o.hidden = true -- Hide buffers
vim.o.syntax = 'true' -- Syntax enable
vim.o.wildmenu = true -- Wildmenu
vim.o.path = vim.o.path .. '**' -- path+=**
vim.wo.number = true -- Set Number
vim.wo.relativenumber = true -- Set Relative Number
vim.wo.wrap = false -- no wrap lines
vim.o.termguicolors = true -- termguicolors (enables 256 colour support in terminals)
vim.o.t_Co = '256' -- 256 colours
vim.o.inccommand = 'nosplit' -- live preview search & replace
vim.o.ignorecase = true -- Ignores case in search
vim.o.smartcase = true -- Applies smartcase
vim.o.undofile = true -- Permanent undofile
--[[ vim.api.nvim_set_var('python3_host_prog', '/usr/bin/python3.9') ]]
--[[ vim.api.nvim_set_var('$GIT_EDITOR', 'nvr --remote-wait') ]]
