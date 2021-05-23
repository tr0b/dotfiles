-- Sign definition
 vim.fn.sign_define("LspDiagnosticsSignError",
    {text = "✗", texthl = "GruvboxRed"})
vim.fn.sign_define("LspDiagnosticsSignWarning",
    {text = "", texthl = "GruvboxYellow"})
vim.fn.sign_define("LspDiagnosticsSignInformation",
    {text = "", texthl = "GruvboxBlue"})
vim.fn.sign_define("LspDiagnosticsSignHint",
    {text = "", texthl = "GruvboxAqua"})

local lspconfig = require('lspconfig')
 local on_attach = function(_, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    --require'diagnostic'.on_attach()
    require'completion'.on_attach()
 
    -- Mappings.
    local opts = { noremap=true, silent=true }
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>k', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>d', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>n', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>e', '<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
 
 
  end
 
  local servers = {'clangd', 'jsonls', 'tsserver', 'vimls', 'pyls', 'bashls', 'flow', 'solargraph'}
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
    --[[ require'lspconfig'.solargraph.setup{
       [         cmd = { "solargraph", "stdio" },
       [         filetypes = { "ruby" },
       [         on_attach = on_attach
       [ } ]]
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
