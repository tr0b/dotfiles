require("lspsaga").setup({})

local capabilities = vim.lsp.protocol.make_client_capabilities() -- LSP capabilities
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
	properties = {
		"documentation",
		"detail",
		"additionalTextEdits",
	},
}

-- Signature help
-- local signature_config = {}  -- add you config here
-- require "lsp_signature".setup(signature_config)

require("go").setup({
	lsp_cfg = false,
	-- other setups...
})
local cfg = require("go.lsp").config() -- config() return the go.nvim gopls setup

require("lspconfig").gopls.setup(cfg)

-- Run gofmt + goimport on save

local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.go",
	callback = function()
		require("go.format").goimport()
	end,
	group = format_sync_grp,
})

require("lsp.lines")
require("lsp.mason")()
