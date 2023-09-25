-- Telescope fuzzy finding (all the things)
return {
	{
		"ibhagwan/fzf-lua",
		branch = "main",
		config = function()
			require("fzf-lua").setup({
				"telescope",
				files = {
					actions = {
						["default"] = require("fzf-lua.actions").file_edit,
					},
				},
				grep = {
					actions = {
						["default"] = require("fzf-lua.actions").file_edit,
					},
				},
				winopts = { preview = { default = "bat" } },
			})

			-- FZF-Lua + Zoxide Custom Integration
			local zoxide = function()
				local opts = {}
				opts.prompt = "Directories> "
				opts.actions = {
					["default"] = function(selected)
						vim.cmd("cd " .. selected[1])
					end,
				}
				require("fzf-lua").fzf_exec("zoxide query -l", opts)
			end

			local map = require("helpers.keys").map
			map("n", "<c-p>", require("fzf-lua").files, "Open File")
			map("n", "<c-a>", zoxide, "[Zoxide]: Change Directory")
			map("n", "<c-l>", require("fzf-lua").live_grep, "Live Grep (rg if possible)")
			map("n", "<c-s>", require("fzf-lua").oldfiles, "Open Old Files (History)")
			map("n", "<leader>b", require("fzf-lua").buffers, "Open Buffer")
			map("n", "<leader>gf", require("fzf-lua").git_files, "Open Git file")
			map("n", "<leader>gs", require("fzf-lua").git_status, "Git Status Files")
		end,
	},
}
