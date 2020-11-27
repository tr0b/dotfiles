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
let mapleader=","
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
"List buffers
nnoremap <leader>b :Buffers<CR>
"Head over to next or previous buffer easily
nnoremap F  :bprevious<CR>
nnoremap f :bnext<CR>
" fuzzy hotkeys!
nnoremap <leader>f :Files<CR>
nnoremap <leader>r :Rg<CR>
