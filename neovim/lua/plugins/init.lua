require("lazy").setup({
	"neovim/nvim-lspconfig", -- LSP for Nvim >= 0.5
	"nvim-tree/nvim-web-devicons", -- Neovim web dev icons for patched fonts
	{ "nvim-treesitter/nvim-treesitter", cmd = "TSUpdate" }, -- Treesitter
	"NvChad/nvim-colorizer.lua", -- Colorizer (e.g. for CSS colors)
	"glepnir/lspsaga.nvim", -- LSP Saga
	{ "ibhagwan/fzf-lua", branch = "main" }, -- Lua FZF
	"folke/which-key.nvim", -- Shortcut guide
	"sindrets/diffview.nvim", -- Diffview -- Key shortcuts
	"kdheepak/lazygit.nvim", -- Lazygit
	{ "whynothugo/lsp_lines.nvim", url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim" },
	"lukas-reineke/indent-blankline.nvim", -- blank line indentation (vertical line)
	"folke/twilight.nvim",
	"folke/zen-mode.nvim",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"FelipeLema/cmp-async-path", -- async instead of sync path seek
	"hrsh7th/cmp-nvim-lsp-signature-help", -- lsp signature help
	"hrsh7th/cmp-cmdline",
	"f3fora/cmp-spell",
	"hrsh7th/nvim-cmp",
	"L3MON4D3/LuaSnip",
	"onsails/lspkind.nvim",
	{
		"zbirenbaum/copilot-cmp",
		config = function()
			require("copilot_cmp").setup()
		end,
		dependencies = { "copilot.lua" },
	},
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		opts = {},
	},
	"saadparwaiz1/cmp_luasnip",
	"windwp/nvim-autopairs",
	"windwp/nvim-ts-autotag", -- auto (pairs/tags)
	"folke/tokyonight.nvim", -- Colourscheme
	"RRethy/nvim-base16", -- Colourscheme
	"lewis6991/gitsigns.nvim", -- Add git signs (git blame, hunk, etc)
	"nvim-lua/plenary.nvim", -- organizing my life with neorg
	"Abstract-IDE/penvim", -- organizing my life with neorg
	"m-demare/hlargs.nvim", -- Semantic highlight args (todo: change to use native neovim semantic tokens)
	"nvim-lualine/lualine.nvim", -- Awesome status line with Lua
	"nvim-neorg/neorg", -- Organize my life with Neorg
	"folke/neodev.nvim", -- Recommended for DAP
	"mfussenegger/nvim-dap", -- Neovim Debugger Adapter Protocol (DAP)
	"rcarriga/nvim-dap-ui", -- DAP UI
	"akinsho/toggleterm.nvim",
	"williamboman/mason.nvim", -- Handle LSP,DAPs automatically
	"williamboman/mason-lspconfig.nvim", -- Automatic LSP configuration
	"ray-x/go.nvim", -- Go utils
	"nvim-neotest/neotest", -- Neotest
	"antoinemadec/FixCursorHold.nvim", -- optimizes cursor hold event, for neotest
	"nvim-neotest/neotest-go", -- Neotest adapter for go
	"haydenmeade/neotest-jest",
	"olimorris/neotest-rspec",
	"ray-x/guihua.lua", -- Some GUI enhancements for plugins
	{ "zbirenbaum/copilot.lua" }, -- Copilot for Neovim
	"lukas-reineke/virt-column.nvim", -- Display a virtual char in colorcolumn
	"jose-elias-alvarez/null-ls.nvim", -- Null-ls for formatting
	{
		"ray-x/go.nvim",
		ft = "go",
		config = function()
			require("go").setup({
				lsp_cfg = true,
				goimport = "gopls", -- goimport command, can be gopls[default] or goimport
				lsp_gofumpt = true, -- true: set default gofmt in gopls format to gofumpt
				lsp_on_attach = require("lsp.on_attach").setup, -- use on_attach from go.nvim
				lsp_diag_virtual_text = false,
				luasnip = true,
				lsp_inlay_hints = {
					parameter_hints_prefix = "󰊕",
				},
			})
			local cfg = require("go.lsp").config() -- config() return the go.nvim gopls setup
			require("lspconfig").gopls.setup(cfg)
			local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})
			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "*.go",
				callback = function()
					require("go.format").goimport()
				end,
				group = format_sync_grp,
			})
		end,
		lazy = true,
	},
})
