local ignore = [[*.bmp,*.gif,*.ico,*.jpg,*.png,*.ico,**/node_modules/**,*.pdf,*.psd]]
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
vim.o.inccommand = 'nosplit' -- live preview search & replace
vim.o.ignorecase = true -- Ignores case in search
vim.o.wildignore = vim.o.wildignore .. ignore -- What should wildmenu ignore
vim.o.smartcase = true -- Applies smartcase
vim.o.undofile = true -- Permanent undofile
vim.o.lazyredraw = true -- Lazy redraw, slightly optimize macros execution
vim.o.ruler = true -- Enable ruler
vim.o.completeopt=[[longest,menuone,noinsert,noselect]] -- Complete menu options
vim.api.nvim_set_var('python3_host_prog', '/usr/bin/python3.9')
vim.api.nvim_set_var('$GIT_EDITOR', 'nvr --remote-wait')
-- [[ Neovim Terminal tweaks.
-- Since augroup  & auto-commands are still not implemented in Lua, we have to
-- directly call the nvim api and define the autocommand, so that it can be 
-- evaluated as Vimscript code ]] --

local neovim_terminal = [[
  augroup neovim_terminal
    autocmd!

    " Enter Terminal-mode (insert) automatically
    autocmd TermOpen,TermEnter * startinsert

    " Disables number lines on terminal buffers
    autocmd TermOpen,TermEnter * :set nonumber norelativenumber
    " Enables number lines when entering non term buffer
    autocmd BufEnter,TermLeave * :set number relativenumber
  augroup END
]]

vim.api.nvim_exec(neovim_terminal, false) -- Creates augroup through vimscript
