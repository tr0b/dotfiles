require("paq")({
	"savq/paq-nvim", -- Let Paq manage itself
	"neovim/nvim-lspconfig", -- LSP for Nvim >= 0.5
	"nvim-tree/nvim-web-devicons", -- Neovim web dev icons for patched fonts
	{ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }, -- Treesitter
	"NvChad/nvim-colorizer.lua", -- Colorizer (e.g. for CSS colors)
	"glepnir/lspsaga.nvim", -- LSP Saga
	{ "ibhagwan/fzf-lua", branch = "main" }, -- Lua FZF
	"folke/which-key.nvim", -- Shortcut guide
	"sindrets/diffview.nvim", -- Diffview -- Key shortcuts
	"kdheepak/lazygit.nvim", -- Lazygit
	{ "whynothugo/lsp_lines.nvim", url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim" },
	"lukas-reineke/indent-blankline.nvim", -- blank line indentation (vertical line)
	"folke/twilight.nvim", -- dim unfocused code
	"folke/zen-mode.nvim", -- Zen mode & twilight for improved focus
	{ "ms-jpq/coq_nvim", branch = "coq" }, -- auto completion with coq
	{ "ms-jpq/coq.artifacts", branch = "artifacts" }, -- snippets
	"ms-jpq/coq.thirdparty", -- third party snippets
	"windwp/nvim-autopairs", -- autopairs
	"windwp/nvim-ts-autotag", -- autotags
	"rebelot/kanagawa.nvim", -- Colourscheme
	"lewis6991/gitsigns.nvim", -- Add git signs (git blame, hunk, etc)
	"nvim-lua/plenary.nvim", -- organizing my life with neorg
	"Abstract-IDE/penvim", -- organizing my life with neorg
	"Bekaboo/deadcolumn.nvim", -- Dynamic, color columns
	"m-demare/hlargs.nvim", -- Semantic highlight args (todo: change to use native neovim semantic tokens)
	"nvim-lualine/lualine.nvim", -- Awesome status line with Lua
	"nvim-lualine/lualine.nvim", -- Awesome status line with Lua
	"nvim-neorg/neorg", -- Organze my life with Neorg
	"folke/neodev.nvim", -- Recommended for DAP
	"mfussenegger/nvim-dap", -- Neovim Debugger Adapter Protocol (DAP)
	"rcarriga/nvim-dap-ui", -- DAP UI
	"akinsho/toggleterm.nvim",
	"williamboman/mason.nvim", -- Handle LSP,DAPs automatically
	"williamboman/mason-lspconfig.nvim", -- Automatic LSP configuration
	"jose-elias-alvarez/typescript.nvim", -- Better typescript utils and LSP
})
