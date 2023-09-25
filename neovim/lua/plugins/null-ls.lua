return {
	-- TODO: deprecate null-ls, since it was archived on August 11th. Look for a newer alternative
	{
		"jose-elias-alvarez/null-ls.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
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
			})
		end,
	},
}
