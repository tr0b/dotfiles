local config = {}
config.linters = { -- Setup Linters
        eslint = { -- [ts, tsx, jsx, js, json]
                sourceName = "eslint",
                command = "eslint_d",
                rootPatterns = {},
                isStdout = true,
                isStderr = false,
                debounce = 100,
                args = {"--stdin","-f","json","--stdin-filename","%filepath"},
                offsetLine = 0,
                offsetColumn = 0,
                parseJson = {

                        errorsRoot = "[0].messages",
                        line = "line",
                        column = "column",
                        endLine = "endLine",
                        endColumn = "endColumn",
                        security = "severity",
                        message = "[eslint] ${message} [${ruleId}]"

                }

        },
        shellcheck = {
                command = "shellcheck",
                rootPatterns = {},
                isStdout = true,
                isStderr = false,
                debounce = 100,
                args = {"-f", "json", "-"},
                offsetLine = 0,
                offsetColumn = 0,
                sourceName = "shellcheck",
                parseJson = {
                        line = "line",
                        column = "column",
                        endLine = "endLine",
                        endColumn = "endColumn",
                        security = "level",
                        message = "[shellcheck] ${message} [${code}]"

                }
        },
        securities = {
                [2] = "error",
                [1] = "warning"
        }}

config.formatters = { -- Formatters, for diagnosticls
        eslint = {
                command = "eslint_d",
                args = {"--fix", "--stdin-filepath", "%filepath"}
        }
}
config.filetypes = { -- Linter filetypes

        sh = "shellcheck",
        javascript = "eslint",
        javascriptreact = "eslint",
        json = "eslint",
        typescript = "eslint",
        typescriptreact = "eslint",

}
config.formatFiletypes = { -- Formatter Filetypes

        sh = "shellcheck",
        javascript = "eslint",
        javascriptreact = "eslint",
        json = "eslint",
        typescript = "eslint",
        typescriptreact = "eslint",

}
return config
