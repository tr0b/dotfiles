-- Mappings.
local M = {
	{ "n", "gD", vim.lsp.buf.declaration, "Go to Declaration" },
	{ "n", "gd", "<cmd>Lspsaga goto_definition<CR>", "Go to Definition" },
	{ "n", "gp", "<cmd>Lspsaga peek_definition<CR>", "Peek Definition" },
	{ "n", "K", "<cmd>Lspsaga hover_doc<CR>", "Hover Documentation" },
	{ "n", "gi", "<cmd>Lspsaga lsp_finder<CR>", "Lsp Finder" },
	{ "n", "<leader>s", vim.lsp.buf.signature_help, "Signature Help" },
	{ "n", "<leader>D", vim.lsp.buf.type_definition, "Type Definition" },
	{ "n", "<leader>ln", "<cmd>Lspsaga rename ++project<CR>", "Rename" },
	{ "n", "<leader>c", "<cmd>Lspsaga code_action<CR>", "[LSP] Code Action" },
	{ "n", "<leader>r", vim.lsp.buf.references, "References" },
	{ "n", "<localleader>f", lsp_formatting, "Formatting" },
	{ "n", "<leader>ldl", "<cmd>Lspsaga show_line_diagnostics<CR>", "Show Line Diagnostics" },
	{ "n", "<leader>ldb", "<cmd>Lspsaga show_buf_diagnostics<CR>", "Show Buffer Diagnostics" },
	{ "n", "<leader>ldw", "<cmd>Lspsaga show_workspace_diagnostics<CR>", "Show Workspace Diagnostics" },
	{ "n", "<leader>ldc", "<cmd>Lspsaga show_cursor_diagnostics<CR>", "Show Cursor Diagnostics" },
	{ "n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", "Go To Next Diagnostic" },
	{ "n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", "Go To Previous Diagnostic" },
}

return M