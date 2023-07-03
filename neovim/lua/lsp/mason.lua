local M = {}
function M.setup(_, opts)
	local util = require("lspconfig/util")
	require("null-ls").setup(require("diagnostics")) -- Import diagnostics config
	local on_attach = require("lsp.on_attach").setup
	-- Set up lspconfig.
	require("completion")()
	local capabilities = require("cmp_nvim_lsp").default_capabilities()

	-- Mason for handling LSP,linter installs
	require("mason").setup()
	require("mason-lspconfig").setup()
	require("mason-lspconfig").setup_handlers({
		-- The first entry (without a key) will be the default handler
		-- and will be called for each installed server that doesn't have
		-- a dedicated handler.
		function(server_name) -- default handler (optional)
			require("lspconfig")[server_name].setup({
				on_attach = on_attach,
				capabilities = capabilities,
			})
		end,
		-- Next, you can provide a dedicated handler for specific servers.
		-- For example, a handler override for the `rust_analyzer`:
		["tsserver"] = function()
			require("typescript-tools").setup({
				on_attach = on_attach,
				capabilities = capabilities,
			})
		end,

		["gopls"] = function() end,
	})
end

return M
