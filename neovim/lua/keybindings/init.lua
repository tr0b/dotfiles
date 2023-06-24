vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
local map = vim.keymap.set -- Alias for setting keymap
local fzf = require("fzf-lua")
fzf.setup({
	"telescope",
	files = {
		actions = {
			["default"] = require("fzf-lua.actions").file_edit,
		},
	},
	winopts = { preview = { default = "bat" } },
})

local function bind_keys(mappings)
	for _, m in ipairs(mappings) do
		map(m[1], m[2], m[3], { noremap = true, silent = true, desc = m[4] })
	end
end

-- FZF-Lua + Zoxide Custom Integration
local zoxide = function()
	local opts = {}
	opts.prompt = "Directories> "
	opts.actions = {
		["default"] = function(selected)
			vim.cmd("cd " .. selected[1])
		end,
	}
	fzf.fzf_exec("zoxide query -l", opts)
end
local fzf_maps = {
	{ "n", "<c-p>", fzf.files, "Open File" },
	{ "n", "<leader>z", zoxide, "[Zoxide]: Change Directory" },
	{ "n", "<c-l>", fzf.live_grep, "Live Grep (rg if possible)" },
	{ "n", "<c-s>", fzf.oldfiles, "Open Old Files (History)" },
	{ "n", "<leader>b", fzf.buffers, "Open Buffer" },
	{ "n", "<leader>gf", fzf.git_files, "Open Git file" },
	{ "n", "<leader>gs", fzf.git_status, "Git Status Files" },
	{ "n", "<leader>gl", fzf.git_commits, "Git Log Commits (Project)" },
	{ "n", "<leader>gb", fzf.git_bcommits, "Git Log Commits (Buffer)" },
	{ "n", "<leader>gst", fzf.git_stash, "Git Stash Files" },
}
local term_maps = {
	{ "n", "<leader>t", '<cmd>exe v:count1 . "ToggleTerm direction=float"<CR>', "Open Terminal" },
	{ "i", "<c-t>", '<Esc><cmd>exe v:count1 . "ToggleTerm direction=float"<CR>', "Open Terminal" },
}
local mappings = {
	{ "i", "kj", "<Esc>" },
	{ "i", "jk", "<Esc>" },
	{ "n", "<leader>w", ":w!<CR>", "Save current buffer (!)" },
	{ "n", "<leader>x", ":bd<CR>", "Close Buffer" },
	{ "n", "<leader>p", ":Lazy<CR>", "Paq Sync (remove, update, add packages)" },
	{ "n", "<leader>gg", ":LazyGit<CR>", "Lazy Git" },
	{ "n", "<leader>m", ":Mason<CR>", "Mason" },
	{ "n", "<leader>t", require("zen-mode").toggle, "ZenMode" },
}

local wk = require("which-key")
wk.setup({})

-- Define keymap groups
local neotest_attach = { "<cmd>lua require('neotest').run.attach()<cr>", "Attach" }
local neotest_run_file = { "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", "Run File" }
local neotest_debug_file =
	{ "<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>", "Debug File" }
local neotest_run_last = { "<cmd>lua require('neotest').run.run_last()<cr>", "Run Last" }
local neotest_debug_last = { "<cmd>lua require('neotest').run.run_last({ strategy = 'dap' })<cr>", "Debug Last" }
local neotest_run_nearest = { "<cmd>lua require('neotest').run.run()<cr>", "Run Nearest" }
local neotest_debug_nearest = { "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", "Debug Nearest" }
local neotest_output = { "<cmd>lua require('neotest').output.open({ enter = true })<cr>", "Output" }
local neotest_stop = { "<cmd>lua require('neotest').run.stop()<cr>", "Stop" }
local neotest_summary = { "<cmd>lua require('neotest').summary.toggle()<cr>", "Summary" }

-- Register keymap groups
wk.register({
	["<leader>g"] = { name = "Git" },
	["<leader>l"] = { name = "LSP" },
	["<leader>n"] = {
		name = "Neotest",
		a = neotest_attach,
		f = neotest_run_file,
		F = neotest_debug_file,
		l = neotest_run_last,
		L = neotest_debug_last,
		n = neotest_run_nearest,
		N = neotest_debug_nearest,
		o = neotest_output,
		S = neotest_stop,
		s = neotest_summary,
	},
})

-- Toggle term keymaps
function _G.set_terminal_keymaps()
	local opts = { buffer = 0 }
	map("t", "<esc>", [[<C-\><C-n>]], opts)
	map("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
	map("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
	map("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
	map("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd("autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()")
bind_keys(fzf_maps)
bind_keys(term_maps)
bind_keys(mappings)
