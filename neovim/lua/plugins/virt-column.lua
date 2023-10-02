return {
    {
        "lukas-reineke/virt-column.nvim",
        opts = {},
        config = function()
            require("virt-column").setup({
                virtcolumn = "79,119,159",
                enabled = true,
                highlight = { "80CharColumn", "120CharColumn", "160CharColumn" },
            })
        end,
    },
}
