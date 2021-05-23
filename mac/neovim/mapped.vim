"Asyncomplete mappings"
imap <c-space> <Plug>(asyncomplete_force_refresh)
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"
"ALE mappings"
nmap <silent> <C-q> <Plug>(ale_previous_wrap)
nmap <silent> <C-s> <Plug>(ale_next_wrap)
"Tmux+Vim Integration
"Easier split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
"Map Leader key
let mapleader=" "
nnoremap <SPACE> <Nop>
let maplocalleader = "\\"
"Neovim LSP mappings
nnoremap <silent> <leader>d <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <leader>D    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <leader>s <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> <leader>lD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> <leader>r    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> <leader>0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> <leader>W    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
"Tab Remap
nnoremap <leader>l :ls<CR>:b<space>
set wildcharm=<C-z>
"FZF buffers
nnoremap <leader>b :Buffers <CR>
"FZF History
nnoremap <leader>h :History <CR>
"Head over to next or previous buffer easily
nnoremap <Leader>f :Files<CR>
nnoremap <Leader>r :RG<CR>
"Write changes to buffer, override!
nnoremap <Leader>w :w!<CR>
"Quit NeoVim
nnoremap <Leader>q :q<CR>
" Escape Terminal Mode
tnoremap jk <C-\><C-n>
tnoremap kj <C-\><C-n>
" Escape Insert Mode
inoremap jk <Esc>
inoremap kj <Esc>
" Leader t opens term
nnoremap <leader>t :term<CR>
" Exit Buffer
nnoremap <leader>x :bd<CR>
" Disable Elm-vim generic mappings
" let g:elm_setup_keybindings = 0
