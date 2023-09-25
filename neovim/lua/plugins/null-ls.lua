return {
	-- TODO: deprecate null-ls, since it was archived on August 11th. Look for a newer alternative
	{
		"jose-elias-alvarez/null-ls.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			local lsp_map = require("helpers.keys").lsp_map
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.formatting.clang_format,
					null_ls.builtins.formatting.black,
					null_ls.builtins.formatting.isort,
					null_ls.builtins.diagnostics.eslint_d,
					null_ls.builtins.diagnostics.phpstan,
					null_ls.builtins.formatting.phpcsfixer,
				},
				on_attach = function(client, bufnr)
					-- Formatting
					local lsp_formatting = function(buf)
						vim.lsp.buf.format({
							filter = function(cli)
								-- apply whatever logic you want (in this example, we'll only use null-ls)
								return cli.name == "null-ls"
							end,
							bufnr = buf,
						})
					end

					local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
					if client.supports_method("textDocument/formatting") then
						vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = augroup,
							buffer = bufnr,
							callback = function()
								lsp_formatting(bufnr)
							end,
						})
						-- Create a command `:Format` local to the LSP buffer
						vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
							vim.lsp.buf.format()
						end, { desc = "Format current buffer with LSP" })

						lsp_map("<localleader>f", "<cmd>Format<cr>", bufnr, "Format")

						--Enable completion triggered by <c-x><c-o>
						vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
					end
				end,
			})
		end,
	},
}
