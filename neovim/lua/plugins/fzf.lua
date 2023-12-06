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
                    continue_last_search = true,
                    rg_glob = true,
                    glob_flag = "--iglob",
                    glob_separator = "%s%-%-",
                },
                winopts = { preview = { hidden = "hidden" } },
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
            map("n", "<M-g>", zoxide, "[Zoxide]: Change Directory")
            map(
                "n",
                "<M-i>",
                require("fzf-lua").live_grep,
                "Live Grep (rg if possible)"
            )
            map(
                "n",
                "<c-s>",
                require("fzf-lua").oldfiles,
                "Open Old Files (History)"
            )
            map("n", "<leader>b", require("fzf-lua").buffers, "Open Buffer")
            map(
                "n",
                "<leader>gf",
                require("fzf-lua").git_files,
                "Open Git file"
            )
            map(
                "n",
                "<leader>gs",
                require("fzf-lua").git_status,
                "Git Status Files"
            )
            require("fzf-lua").register_ui_select(function(_, items)
                local min_h, max_h = 0.15, 0.70
                local h = (#items + 4) / vim.o.lines
                if h < min_h then
                    h = min_h
                elseif h > max_h then
                    h = max_h
                end
                return { winopts = { height = h, width = 0.60, row = 0.40 } }
            end)
        end,
    },
}
