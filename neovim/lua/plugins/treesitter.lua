-- Highlight, edit, and navigate code
return {
	{ "RRethy/nvim-treesitter-textsubjects" },
	{
		"nvim-treesitter/nvim-treesitter",
		build = function()
			pcall(require("nvim-treesitter.install").update({ with_sync = true }))
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		config = function()
			require("nvim-treesitter.configs").setup({
				-- Add languages to be installed here that you want installed for treesitter
				ensure_installed = {
					"c",
					"cpp",
					"go",
					"lua",
					"python",
					"rust",
					"vim",
					"elixir",
					"php",
					"typescript",
					"cmake",
					"css",
					"dockerfile",
					"comment",
					"json",
					"git_config",
					"git_rebase",
					"gitattributes",
					"graphql",
					"haskell",
					"javascript",
					"yaml",
					"html",
					"rust",
					"ruby",
					"awk",
					"gomod",
					"gosum",
					"scheme",
					"sql",
					"markdown",
					"markdown_inline",
				},

				highlight = { enable = true },
				indent = { enable = true, disable = { "python" } },
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<c-space>",
						node_incremental = "<c-space>",
						scope_incremental = "<c-s>",
						node_decremental = "<c-backspace>",
					},
				},
				textsubjects = {
					enable = true,
					prev_selection = ",", -- (Optional) keymap to select the previous selection
					keymaps = {
						["."] = "textsubjects-smart",
						[";"] = "textsubjects-container-outer",
						["i;"] = "textsubjects-container-inner",
					},
				},
			})
		end,
	},
}
