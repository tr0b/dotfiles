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
	"rebelot/kanagawa.nvim", -- Colourscheme
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
})
