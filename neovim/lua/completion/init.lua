return function(_, opts)
	local lspkind = require("lspkind")
	local has_words_before = function()
		unpack = unpack or table.unpack
		local line, col = unpack(vim.api.nvim_win_get_cursor(0))
		return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
	end
	-- Set up nvim-cmp.
	local cmp = require("cmp")
	-- If you want insert `(` after select function or method item
	local cmp_autopairs = require("nvim-autopairs.completion.cmp")
	cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
	local luasnip = require("luasnip")

	cmp.setup({
		enabled = true,
		snippet = {
			-- REQUIRED - you must specify a snippet engine
			expand = function(args)
				luasnip.lsp_expand(args.body) -- For `luasnip` users.
			end,
		},
		window = {
			-- completion = cmp.config.window.bordered(),
			-- documentation = cmp.config.window.bordered(),
		},
		mapping = cmp.mapping.preset.insert({
			["<C-b>"] = cmp.mapping.scroll_docs(-4),
			["<C-f>"] = cmp.mapping.scroll_docs(4),
			["<C-Space>"] = cmp.mapping.complete(),
			["<C-e>"] = cmp.mapping.abort(),
			["<CR>"] = cmp.mapping.confirm({ select = true }),
			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				-- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
				-- they way you will only jump inside the snippet region
				elseif luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				elseif has_words_before() then
					cmp.complete()
				else
					fallback()
				end
			end, { "i", "s" }),
			["<S-Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, { "i", "s" }),
		}),
		sources = cmp.config.sources({
			{ name = "nvim_lsp", group_index = 2 },
			{ name = "luasnip", group_index = 2 }, -- For luasnip users.
			{ name = "copilot", group_index = 2 }, -- For snippy users.
			{ name = "async_path", group_index = 2 },
			{ name = "nvim_lsp_signature_help", group_index = 2 },
		}, {
			{ name = "buffer" },
			{
				name = "spell",
				option = {
					keep_all_entries = false,
					enable_in_context = function()
						return true
					end,
				},
				group_index = 2,
			},
		}),
	})

	-- Set configuration for specific filetype.
	cmp.setup.filetype("gitcommit", {
		sources = cmp.config.sources({
			{ name = "git" }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
		}, {
			{ name = "buffer" },
		}),
	})
	require("copilot").setup({
		suggestion = { enabled = false },
		panel = { enabled = false },
	})

	cmp.setup({
		formatting = {
			format = lspkind.cmp_format({
				mode = "symbol_text", -- show only symbol annotations
				menu = {
					buffer = "[Buffer]",
					nvim_lsp = "[LSP]",
					luasnip = "[LuaSnip]",
					nvim_lua = "[Lua]",
					latex_symbols = "[Latex]",
					copilot = "[Copilot]",
					spell = "[Spell]",
				},
				maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
				ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
			}),
		},
	})

	lspkind.init({
		symbol_map = {
			Copilot = "",
		},
	})

	vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
end
