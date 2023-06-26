local M = {}
function M.setup(_, opts)
	local util = require("lspconfig/util")
	require("null-ls").setup(require("diagnostics")) -- Import diagnostics config
	local map = vim.keymap.set
	-- Formatting
	local lsp_formatting = function(bufnr)
		vim.lsp.buf.format({
			filter = function(client)
				-- apply whatever logic you want (in this example, we'll only use null-ls)
				return client.name == "null-ls"
			end,
			bufnr = bufnr,
		})
	end

	local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

	-- Use an on_attach function to only map the following keys
	-- after the language server attaches to the current buffer
	local mappings = require("lsp.keybindings") -- LSP specific keybindings
	local on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					lsp_formatting(bufnr)
				end,
			})
		end
		--Enable completion triggered by <c-x><c-o>
		vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

		for _, m in ipairs(mappings) do
			m[3] = m[3] or m[2]
			map(m[1], m[2], m[3], { noremap = true, silent = true, buffer = bufnr, desc = m[4] })
		end
	end

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

		["gopls"] = function()
			require("lspconfig").gopls.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				cmd = { "gopls" },
				filetypes = { "go", "gomod", "gowork", "gotmpl" },
				root_dir = util.root_pattern("go.work", "go.mod", ".git"),
				settings = {
					gopls = {
						completeUnimported = true,
						usePlaceholders = true,
						analyses = {
							unusedparams = true,
						},
					},
				},
			})
		end,
	})
end

return M
