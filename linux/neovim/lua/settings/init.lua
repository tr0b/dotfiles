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
  let $GIT_EDITOR = 'nvr --remote-wait'
]]

local undodir = [[
if !isdirectory($HOME."/.vim")
    call mkdir($HOME."/.vim", "", 0770)
endif
if !isdirectory($HOME."/.vim/undo-dir")
    call mkdir($HOME."/.vim/undo-dir", "", 0700)
endif
set undodir=~/.vim/undo-dir
set undofile
]]

vim.o.smarttab = true -- Smart Tab
vim.o.expandtab = true -- Expand tab to spaces (use spaces on tab)
vim.o.cursorline = true -- Set cursorline in file
vim.o.autoindent = true -- Auto Indent
vim.bo.smartindent = true -- Smart Indent
vim.o.clipboard = 'unnamed,unnamedplus' -- System clipboard used
vim.o.hidden = true -- Hide buffers
vim.o.syntax = 'true' -- Syntax enable
vim.o.wildmenu = true -- Wildmenu
vim.o.wildmode="longest:full,full"
vim.o.path = vim.o.path .. '**' -- path+=**
vim.o.wildignore = vim.o.wildignore .. [[*/node_modules/*,_site]] -- Ignore dirs
vim.o.wildignorecase = true -- When searching, ignore case
vim.wo.number = true -- Set Number
vim.wo.relativenumber = true -- Set Relative Number
vim.wo.wrap = false -- no wrap lines
vim.o.inccommand = 'nosplit' -- live preview search & replace
vim.o.ignorecase = true -- Ignores case in search
vim.o.smartcase = true -- Applies smartcase
vim.o.undofile = true -- Permanent undofile
vim.o.lazyredraw = true -- Lazy redraw, slightly optimize macros execution
vim.o.ruler = true -- Enable ruler
vim.o.completeopt=[[longest,menuone,noinsert,noselect]] -- Complete menu options
vim.wo.conceallevel=3 -- Completely hides concealed text
vim.bo.expandtab=true -- Use appropiate number of spaces to place <TAB>
vim.api.nvim_set_var('python3_host_prog', '/usr/bin/python3.9')

vim.api.nvim_exec(neovim_terminal, false) -- Creates augroup through vimscript, sets GIT_EDITOR term
vim.api.nvim_exec(undodir, false) -- Creates persistent undodir
