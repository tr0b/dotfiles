return {
    {
        "christoomey/vim-tmux-navigator",
        lazy = false,
        config = function()
            local map = require("helpers.keys").map
            map("n", "<C-h>", "<cmd> TmuxNavigateLeft<CR>", "Window left")
            map("n", "<C-l>", "<cmd> TmuxNavigateRight<CR>", "Window right")
            map("n", "<C-j>", "<cmd> TmuxNavigateDown<CR>", "Window down")
            map("n", "<C-k>", "<cmd> TmuxNavigateUp<CR>", "Window up")
        end,
    },
}
