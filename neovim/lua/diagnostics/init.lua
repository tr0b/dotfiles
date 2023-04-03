local config = {} -- EFM lsp configuration
local eslint = { -- Eslint format, linting configuration
	lintCommand = "eslint_d -f unix --stdin --stdin-filename=${INPUT}", -- Use eslint_d. daemon server is way quicker than ordinary eslint
	lintStdin = true,
	lintFormats = { "%f:%l:%c: %m" }, -- UNIX strings MUST be set correctly, no typos. else, no output will be printed by LSP
	lintIgnoreExitCode = true,
	formatCommand = "eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}",
	formatStdin = true,
}
local shellcheck = { -- Shellcheck, linting configuration
	lintCommand = "shellcheck -f gcc -x -",
	lintStdin = true,
	lintFormats = { "%f:%l:%c: %trror: %m", "%f:%l:%c: %tarning: %m", "%f:%l:%c: %tote: %m" }, -- UNIX strings MUST be set correctly, no typos. else, no output will be printed by LSP
	lintIgnoreExitCode = true,
	lintSource = "shellcheck",
}
local jq = { -- Shellcheck, linting configuration
	lintCommand = "jq .",
	lintFormats = { "%f:%l:%c: %m", "%f:%l:%c: %trror: %m", "%f:%l:%c: %tarning: %m", "%f:%l:%c: %tote: %m" }, -- UNIX strings MUST be set correctly, no typos. else, no output will be printed by LSP
	lintIgnoreExitCode = true,
}
local stylua = { -- Shellcheck, linting configuration
	lintCommand = "stylua -",
	formatStdin = true,
}
local bladeformatter = { -- Shellcheck, linting configuration
	lintCommand = "blade-formatter --stdin",
	formatStdin = true,
}
local psalm = { -- Shellcheck, linting configuration
	lintCommand = "./vendor/bin/psalm --output-format=emacs --no-progress",
	lintFormats = { "%f:%l:%c:%trror - %m", "%f:%l:%c:%tarning - %m" }, -- UNIX strings MUST be set correctly, no typos. else, no output will be printed by LSP
}
local phpstan = { -- Shellcheck, linting configuration
	lintCommand = "./vendor/bin/phpstan analyze --error-format raw --no-progress",
}

config.settings = { -- Language settings for efm LSP
	languages = {
		json = { jq },
		javascript = { eslint },
		javascriptreact = { eslint },
		["javascript.jsx"] = { eslint },
		typescript = { eslint },
		typescriptreact = { eslint },
		["typescript.jsx"] = { eslint },
		sh = { shellcheck },
		lua = { stylua },
		blade = { bladeformatter },
		php = { psalm, phpstan },
	},
}
config.filetypes = { -- Allowed filetypes
	"javascript",
	"javascriptreact",
	"javascript.jsx",
	"typescript",
	"typescript.tsx",
	"typescriptreact",
	"json",
	"sh",
	"php",
	"lua",
	"blade",
}
--[[TODO:
-- Add Lua formatting & linting if possible
-- Add JSON formatting. not a priority as of right now, though
-- Add UNIX shell formatting (POSIX, ksh, bash, etc.)
--]]
--
return config
