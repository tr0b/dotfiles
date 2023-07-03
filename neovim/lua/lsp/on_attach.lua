local M = {}
function M.setup(client, bufnr)
	-- Formatting
	local map = vim.keymap.set
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

	-- Use an on_attach function to only map the following keys
	-- after the language server attaches to the current buffer
	local mappings = require("lsp.keybindings") -- LSP specific keybindings
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				lsp_formatting(bufnr)
			end,
		})
		--Enable completion triggered by <c-x><c-o>
		vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

		for _, m in ipairs(mappings) do
			m[3] = m[3] or m[2]
			map(m[1], m[2], m[3], { noremap = true, silent = true, buffer = bufnr, desc = m[4] })
		end
	end
end

return M
