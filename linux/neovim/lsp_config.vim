" " Show errors after 1 second
set updatetime=500
let g:diagnostic_insert_delay = 1
let g:diagnostic_show_sign = 1
let g:diagnostic_enable_virtual_text = 1
" " Complete parentheses for functions
let g:completion_enable_auto_paren = 1
" Set completeopt to have a better completion experience
set completeopt=longest,menuone,noinsert,noselect
let g:completion_enable_snippet = 'UltiSnips'
 
let g:netrw_gx = '<cWORD>'
lua require('lsp_config')
let g:LanguageClient_autoStart = 1
autocmd BufEnter * lua require'completion'.on_attach()
command! -buffer -nargs=0 LspShowLineDiagnostics lua require'jumpLoc'.openLineDiagnostics()
nnoremap <buffer><silent> <leader>d <Cmd>LspShowLineDiagnostics<CR>
 
let g:diagnostic_auto_popup_while_jump = 1

