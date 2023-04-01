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
let g:LanguageClient_autoStart = 1
autocmd BufEnter * lua require'completion'.on_attach()
command! -buffer -nargs=0 LspShowLineDiagnostics lua require'jumpLoc'.openLineDiagnostics()
nnoremap <buffer><silent> <leader>d <Cmd>LspShowLineDiagnostics<CR>
 
let g:diagnostic_auto_popup_while_jump = 1
:lua << EOF
 local lspconfig = require('lspconfig')
 local on_attach = function(_, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    require'completion'.on_attach()
 
    -- Mappings.
    local opts = { noremap=true, silent=true }
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>K', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n','<leader>p', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>R', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>i', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>', opts)
 
 
  end
 
  local servers = {'clangd', 'jsonls', 'tsserver', 'vimls', 'pyls', 'bashls', 'solargraph'}
  for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
      on_attach = on_attach,
    }
    --require'lspconfig'.julials.setup{}
    --html LSP server config
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    require'lspconfig'.html.setup{

    capabilities = capabilities,
    on_attach = on_attach,

    }
	require'lspconfig'.hie.setup{
		init_options = {
			languageServerHaskell = {
			    hlintOn = true;
			    maxNumberOfProblems = 100;
			    liquidOn = true;
			    completionSnippetsOn = true;
			    formatOnImportOn = true;
			    formattingProvider = "brittany";
			    languageServerVariant = "haskell-language-server"
			  }
		},
		cmd = { "hie-wrapper", "--lsp" },
		filetypes = { "haskell" }
	}
  end
EOF
