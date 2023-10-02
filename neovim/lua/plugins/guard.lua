return {
    -- TODO: deprecate null-ls, since it was archived on August 11th. Look for a newer alternative
    {
        "nvimdev/guard.nvim",
        dependencies = {
            "nvimdev/guard-collection",
        },
        config = function()
            local ft = require("guard.filetype")
            local prettier =
                { cmd = "prettier", fname = true, ignore_error = true }
            local mypy = { cmd = "mypy", stdin = true }
            local phpcbf = { cmd = "phpcbf", stdin = true }
            local phpcs = { cmd = "phpcs", stdin = true }
            local gofumpt = { cmd = "gofumpt", stdin = true }
            local golines = { cmd = "golines", args = { "--" }, stdin = true }
            local goimports = { cmd = "goimports", stdin = true }
            local sqlfluff = { cmd = "sqlfluff", stdin = true }
            local sqlfmt = { cmd = "sqlfmt", stdin = true }
            local stylua = {
                cmd = "stylua",
                args = {
                    "--column-width=80",
                    "--indent-type=Spaces",
                    "--indent-width=4",
                    "-",
                },
                stdin = true,
            }
            ft("lua"):fmt(stylua):lint("selene")
            ft("typescript,javascript,typescriptreact,html")
                :fmt(prettier)
                :lint("eslint_d")
            ft("php"):fmt(phpcbf):lint(phpcs)
            ft("go"):fmt(gofumpt):append(golines):append(goimports)
            ft("python"):fmt("black"):lint(mypy)
            ft("bash,zsh,sh,ksh"):lint("shellcheck")
            ft("sql"):lint(sqlfluff):fmt(sqlfmt)

            -- Call setup() LAST!
            require("guard").setup({
                -- the only options for the setup function
                fmt_on_save = true,
                -- Use lsp if no formatter was defined for this filetype
                lsp_as_default_formatter = false,
            })
        end,
    },
}
