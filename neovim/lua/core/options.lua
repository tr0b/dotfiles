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
  " If you don't like using :w | bd and prefer the good old :wq (or :x), put the following in your vimrc:
  autocmd FileType gitcommit,gitrebase,gitconfig set bufhidden=delete
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

local opts = {
    shiftwidth = 4,
    tabstop = 4,
    expandtab = true,
    wrap = false,
    termguicolors = true,
    list = true,
    number = true,
    relativenumber = true,
    timeout = true,
    cursorline = true,
    timeoutlen = 300,
    ignorecase = true,
    smartcase = true,
    undofile = true,
    lazyredraw = true,
    ruler = true,
    completeopt = [[longest,menuone,noinsert,noselect]],
    conceallevel = 3,
    inccommand = "nosplit",
}

-- Set options from table
for opt, val in pairs(opts) do
    vim.o[opt] = val
end

-- Set other options
local colorscheme = require("helpers.colorscheme")
vim.cmd.colorscheme(colorscheme)

vim.api.nvim_exec(neovim_terminal, false) -- Creates augroup through vimscript, sets GIT_EDITOR term
vim.api.nvim_exec(undodir, false) -- Creates persistent undodir
vim.api.nvim_set_hl(1, "Comment", { italic = true })
vim.opt.listchars:append("space:⋅")
vim.opt.listchars:append("eol:↴")

vim.cmd([[highlight 160CharColumn guifg=#E06C75 gui=nocombine]])
vim.cmd([[highlight 120CharColumn guifg=#E5C07B gui=nocombine]])
vim.cmd([[highlight 80CharColumn guifg=#98C379 gui=nocombine]])
