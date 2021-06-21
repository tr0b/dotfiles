vim.o.background = 'dark' -- Dark background, useful for transparency options
vim.o.termguicolors = true -- termguicolors (256 colour)
vim.o.t_Co = '256' -- 256 colours
vim.o.colorcolumn = '80' -- 80 char limit for columns
vim.o.conceallevel = 3 -- MARKDOWN conceal level
vim.o.guifont = [[DejaVu\ Sans\ Mono\ 13]] -- GUI font
-- Regardless of colorscheme, highlight should have no bg, fg in gui
vim.api.nvim_exec([[au ColorScheme * hi Normal ctermbg=none guibg=none]], false) 
-- Regardless of colorscheme, lines should have no bg, fg in gui
vim.api.nvim_exec([[au ColorScheme * hi LineNr ctermbg=NONE guibg=NONE]], false) 
vim.g.onedark_style = 'deep' -- Deep variant of onedark
require('onedark').setup() -- colorscheme onedark
